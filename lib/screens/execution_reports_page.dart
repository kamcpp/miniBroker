import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../utils/menu_items_helper.dart';
import '../config/ui_constants.dart';
import '../widgets/base_page.dart';

class ExecutionReportsPage extends StatefulWidget {
  final String? initialRequestId;

  const ExecutionReportsPage({super.key, this.initialRequestId});

  @override
  State<ExecutionReportsPage> createState() => _ExecutionReportsPageState();
}

class _ExecutionReportsPageState extends State<ExecutionReportsPage> {
  final _requestIdController = TextEditingController();

  // Data
  List<Map<String, dynamic>> _executionReports = [];
  List<Map<String, dynamic>> _businessRejects = [];
  Map<String, dynamic>? _sentOrder;
  int _totalExecutionReports = 0;
  int _totalBusinessRejects = 0;

  // Loading state
  bool _isLoading = false;
  String? _errorMessage;

  // Pagination
  int _currentPage = 1;
  int _pageSize = 20;
  int _totalPages = 1;

  // Filters
  final _symbolFilterController = TextEditingController();
  final _currencyFilterController = TextEditingController();
  String? _execTypeFilter;
  String? _sortBy;
  String _sortDirection = 'desc';

  // Exec type options for dropdown
  static const _execTypeOptions = <String, String>{
    '': 'All',
    '0': 'New',
    '1': 'Partial Fill',
    '2': 'Fill',
    '3': 'Done for Day',
    '4': 'Canceled',
    '5': 'Replaced',
    '6': 'Pending Cancel',
    '8': 'Rejected',
    'F': 'Trade',
  };

  static const _sortByOptions = <String, String>{
    '': 'Default',
    'created_at': 'Created At',
    'symbol': 'Symbol',
    'side': 'Side',
    'exec_type': 'Exec Type',
    'ord_status': 'Status',
    'price': 'Price',
    'order_qty': 'Quantity',
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialRequestId != null) {
      _requestIdController.text = widget.initialRequestId!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchExecutionReports();
      });
    }
  }

  @override
  void dispose() {
    _requestIdController.dispose();
    _symbolFilterController.dispose();
    _currencyFilterController.dispose();
    super.dispose();
  }

  Future<void> _fetchExecutionReports() async {
    final requestId = _requestIdController.text.trim();
    if (requestId.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a request ID';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await realGrpcClient.getOrderExecutionReports(
        requestId: requestId,
        pageNumber: _currentPage,
        pageSize: _pageSize,
        symbolFilter: _symbolFilterController.text.trim().isNotEmpty
            ? _symbolFilterController.text.trim()
            : null,
        currencyFilter: _currencyFilterController.text.trim().isNotEmpty
            ? _currencyFilterController.text.trim()
            : null,
        execTypeFilter: (_execTypeFilter != null && _execTypeFilter!.isNotEmpty)
            ? _execTypeFilter
            : null,
        sortBy: (_sortBy != null && _sortBy!.isNotEmpty) ? _sortBy : null,
        sortDirection: _sortDirection,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        final output = result['output'] as Map<String, dynamic>? ?? {};

        final reports = (output['executionReports'] as List<dynamic>? ??
                output['execution_reports'] as List<dynamic>? ??
                [])
            .cast<Map<String, dynamic>>();

        final rejects = (output['businessRejects'] as List<dynamic>? ??
                output['business_rejects'] as List<dynamic>? ??
                [])
            .cast<Map<String, dynamic>>();

        final sentOrder = output['sentOrder'] as Map<String, dynamic>? ??
            output['sent_order'] as Map<String, dynamic>?;

        final totalReports = output['totalExecutionReports'] as int? ??
            output['total_execution_reports'] as int? ??
            reports.length;

        final totalRejects = output['totalBusinessRejects'] as int? ??
            output['total_business_rejects'] as int? ??
            rejects.length;

        // Calculate total pages from pagination_info if available
        final paginationInfo = output['paginationInfo'] as Map<String, dynamic>? ??
            output['pagination_info'] as Map<String, dynamic>?;
        int totalPages = 1;
        if (paginationInfo != null) {
          final totalItems = paginationInfo['totalItems'] as int? ??
              paginationInfo['total_items'] as int? ??
              totalReports;
          totalPages = (totalItems / _pageSize).ceil().clamp(1, 999999);
        } else if (totalReports > 0) {
          totalPages = (totalReports / _pageSize).ceil().clamp(1, 999999);
        }

        setState(() {
          _executionReports = reports;
          _businessRejects = rejects;
          _sentOrder = sentOrder;
          _totalExecutionReports = totalReports;
          _totalBusinessRejects = totalRejects;
          _totalPages = totalPages;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['output']?['error'] ?? 'Unknown error';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages) return;
    setState(() {
      _currentPage = page;
    });
    _fetchExecutionReports();
  }

  void _resetFilters() {
    setState(() {
      _symbolFilterController.clear();
      _currencyFilterController.clear();
      _execTypeFilter = null;
      _sortBy = null;
      _sortDirection = 'desc';
      _currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    final backgroundColor = isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[50]!;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'execution_reports'),
      content: Container(
        color: backgroundColor,
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            _buildSearchBar(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),

            // Filters row
            _buildFiltersRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: UIConstants.fontSizeSm,
                            ),
                          ),
                        )
                      : _executionReports.isEmpty && _businessRejects.isEmpty && _sentOrder == null
                          ? Center(
                              child: Text(
                                'Enter a request ID and click Fetch to view execution reports.',
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                  fontSize: UIConstants.fontSizeSm,
                                ),
                              ),
                            )
                          : _buildContent(isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isDarkTheme) {
    return Row(
      children: [
        Text(
          'Execution Reports',
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: UIConstants.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: UIConstants.spacingLg),
        Expanded(
          child: SizedBox(
            height: UIConstants.buttonHeightStandard,
            child: TextField(
              controller: _requestIdController,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: UIConstants.fontSizeSm,
              ),
              decoration: InputDecoration(
                hintText: 'Enter request ID...',
                hintStyle: TextStyle(
                  color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                  fontSize: UIConstants.fontSizeSm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
                contentPadding: UIConstants.textFieldContentPadding,
                isDense: true,
                suffixIcon: _requestIdController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, size: 16, color: isDarkTheme ? Colors.grey[400] : Colors.grey),
                        onPressed: () {
                          _requestIdController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onSubmitted: (_) => _fetchExecutionReports(),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          height: UIConstants.buttonHeightStandard,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchExecutionReports,
            icon: Icon(Icons.search, size: 16),
            label: Text('Fetch', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            style: UIConstants.buttonStyle(UIConstants.colorCommand),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersRow(bool isDarkTheme) {
    final textStyle = TextStyle(
      color: isDarkTheme ? Colors.white : Colors.black,
      fontSize: UIConstants.fontSizeSm,
    );
    final hintStyle = TextStyle(
      color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
      fontSize: UIConstants.fontSizeSm,
    );
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      contentPadding: UIConstants.textFieldContentPadding,
      isDense: true,
    );

    return Row(
      children: [
        // Symbol filter
        SizedBox(
          width: 120,
          height: 32,
          child: TextField(
            controller: _symbolFilterController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Symbol', hintStyle: hintStyle),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),

        // Currency filter
        SizedBox(
          width: 100,
          height: 32,
          child: TextField(
            controller: _currencyFilterController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Currency', hintStyle: hintStyle),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),

        // Exec type dropdown
        SizedBox(
          width: 130,
          height: 32,
          child: DropdownButtonFormField<String>(
            value: _execTypeFilter,
            isDense: true,
            isExpanded: true,
            decoration: inputDecoration.copyWith(hintText: 'Exec Type', hintStyle: hintStyle),
            style: textStyle,
            dropdownColor: isDarkTheme ? UIConstants.colorDarkFill : Colors.white,
            items: _execTypeOptions.entries
                .map((e) => DropdownMenuItem(
                      value: e.key.isEmpty ? null : e.key,
                      child: Text(e.value, style: textStyle),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _execTypeFilter = value;
              });
            },
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),

        // Sort by dropdown
        SizedBox(
          width: 130,
          height: 32,
          child: DropdownButtonFormField<String>(
            value: _sortBy,
            isDense: true,
            isExpanded: true,
            decoration: inputDecoration.copyWith(hintText: 'Sort By', hintStyle: hintStyle),
            style: textStyle,
            dropdownColor: isDarkTheme ? UIConstants.colorDarkFill : Colors.white,
            items: _sortByOptions.entries
                .map((e) => DropdownMenuItem(
                      value: e.key.isEmpty ? null : e.key,
                      child: Text(e.value, style: textStyle),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _sortBy = value;
              });
            },
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),

        // Sort direction toggle
        SizedBox(
          height: 32,
          child: IconButton(
            icon: Icon(
              _sortDirection == 'asc' ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _sortDirection = _sortDirection == 'asc' ? 'desc' : 'asc';
              });
            },
            tooltip: _sortDirection == 'asc' ? 'Ascending' : 'Descending',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),

        // Apply filters button
        SizedBox(
          height: 32,
          child: ElevatedButton(
            onPressed: () {
              _currentPage = 1;
              _fetchExecutionReports();
            },
            style: UIConstants.buttonStyle(UIConstants.colorCommand),
            child: Text('Apply', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
          ),
        ),
        SizedBox(width: UIConstants.spacingXs),

        // Reset filters button
        SizedBox(
          height: 32,
          child: TextButton(
            onPressed: () {
              _resetFilters();
              _fetchExecutionReports();
            },
            child: Text('Reset', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
          ),
        ),

        const Spacer(),

        // Total counts
        if (_totalExecutionReports > 0 || _totalBusinessRejects > 0)
          Text(
            '$_totalExecutionReports reports, $_totalBusinessRejects rejects',
            style: TextStyle(
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              fontSize: UIConstants.fontSizeSm,
            ),
          ),
      ],
    );
  }

  Widget _buildContent(bool isDarkTheme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sent order summary
          if (_sentOrder != null) _buildSentOrderCard(isDarkTheme),

          SizedBox(height: UIConstants.spacingMd),

          // Execution reports table
          if (_executionReports.isNotEmpty) _buildExecutionReportsTable(isDarkTheme),

          // Business rejects
          if (_businessRejects.isNotEmpty) ...[
            SizedBox(height: UIConstants.spacingLg),
            _buildBusinessRejectsTable(isDarkTheme),
          ],

          SizedBox(height: UIConstants.spacingMd),

          // Pagination controls
          if (_totalPages > 1) _buildPaginationControls(isDarkTheme),
        ],
      ),
    );
  }

  Widget _buildSentOrderCard(bool isDarkTheme) {
    final order = _sentOrder!;
    final cardColor = isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[100];
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final labelColor = isDarkTheme ? Colors.grey[400] : Colors.grey[600];

    return Container(
      width: double.infinity,
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkTheme ? Colors.white12 : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sent Order',
            style: TextStyle(
              color: textColor,
              fontSize: UIConstants.fontSizeMd,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: UIConstants.spacingSm),
          Wrap(
            spacing: UIConstants.spacingXl,
            runSpacing: UIConstants.spacingXs,
            children: [
              _orderField('Request ID', order['requestId'] ?? order['request_id'] ?? '-', labelColor!, textColor),
              _orderField('Symbol', order['symbol'] ?? '-', labelColor, textColor),
              _orderField('Side', order['side'] ?? '-', labelColor, textColor),
              _orderField('Type', order['orderType'] ?? order['order_type'] ?? '-', labelColor, textColor),
              _orderField('Qty', order['quantity'] ?? '-', labelColor, textColor),
              _orderField('Price', order['price'] ?? '-', labelColor, textColor),
              _orderField('Currency', order['currency'] ?? '-', labelColor, textColor),
              _orderField('Status', order['status'] ?? '-', labelColor, textColor),
              _orderField('Cl Ord ID', order['clOrdId'] ?? order['cl_ord_id'] ?? '-', labelColor, textColor),
              _orderField('Venue', order['venueIid'] ?? order['venue_iid'] ?? '-', labelColor, textColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderField(String label, String value, Color labelColor, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 10)),
        Text(value, style: TextStyle(color: valueColor, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildExecutionReportsTable(bool isDarkTheme) {
    final headerColor = isDarkTheme ? Colors.grey[400] : Colors.grey[700];
    final cellColor = isDarkTheme ? Colors.white : Colors.black;
    final headerStyle = TextStyle(color: headerColor, fontSize: 10, fontWeight: FontWeight.bold);
    final cellStyle = TextStyle(color: cellColor, fontSize: UIConstants.fontSizeSm);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: UIConstants.spacingLg,
        headingRowHeight: 32,
        dataRowMinHeight: 28,
        dataRowMaxHeight: 36,
        decoration: BoxDecoration(
          border: Border.all(color: isDarkTheme ? Colors.white12 : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        columns: [
          DataColumn(label: Text('Exec ID', style: headerStyle)),
          DataColumn(label: Text('Type', style: headerStyle)),
          DataColumn(label: Text('Status', style: headerStyle)),
          DataColumn(label: Text('Symbol', style: headerStyle)),
          DataColumn(label: Text('Side', style: headerStyle)),
          DataColumn(label: Text('Price', style: headerStyle)),
          DataColumn(label: Text('Ord Qty', style: headerStyle)),
          DataColumn(label: Text('Cum Qty', style: headerStyle)),
          DataColumn(label: Text('Leaves', style: headerStyle)),
          DataColumn(label: Text('Avg Px', style: headerStyle)),
          DataColumn(label: Text('Currency', style: headerStyle)),
          DataColumn(label: Text('Time', style: headerStyle)),
          DataColumn(label: Text('Text', style: headerStyle)),
        ],
        rows: _executionReports.map((report) {
          final execType = report['execType'] ?? report['exec_type'] ?? '';
          final ordStatus = report['ordStatus'] ?? report['ord_status'] ?? '';
          final side = report['side'] ?? '';

          return DataRow(cells: [
            DataCell(Text(report['execId'] ?? report['exec_id'] ?? '-', style: cellStyle)),
            DataCell(_execTypeBadge(execType, isDarkTheme)),
            DataCell(_ordStatusBadge(ordStatus, isDarkTheme)),
            DataCell(Text(report['symbol'] ?? '-', style: cellStyle)),
            DataCell(Text(
              side,
              style: cellStyle.copyWith(
                color: side.toUpperCase() == 'BUY' ? UIConstants.colorAccept : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            )),
            DataCell(Text(report['price'] ?? '-', style: cellStyle)),
            DataCell(Text(report['orderQty'] ?? report['order_qty'] ?? '-', style: cellStyle)),
            DataCell(Text(report['cumQty'] ?? report['cum_qty'] ?? '-', style: cellStyle)),
            DataCell(Text(report['leavesQty'] ?? report['leaves_qty'] ?? '-', style: cellStyle)),
            DataCell(Text(report['avgPx'] ?? report['avg_px'] ?? '-', style: cellStyle)),
            DataCell(Text(report['currency'] ?? '-', style: cellStyle)),
            DataCell(Text(report['transactTime'] ?? report['transact_time'] ?? '-', style: cellStyle)),
            DataCell(
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  report['text'] ?? '-',
                  style: cellStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _execTypeBadge(String execType, bool isDarkTheme) {
    final label = _execTypeOptions[execType] ?? execType;
    Color bgColor;
    switch (execType) {
      case '0':
        bgColor = Colors.blue;
        break;
      case '1':
        bgColor = Colors.orange;
        break;
      case '2':
      case 'F':
        bgColor = UIConstants.colorAccept;
        break;
      case '4':
        bgColor = Colors.grey;
        break;
      case '8':
        bgColor = Colors.red;
        break;
      default:
        bgColor = isDarkTheme ? Colors.grey[700]! : Colors.grey[400]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: bgColor, width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(color: bgColor, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _ordStatusBadge(String status, bool isDarkTheme) {
    Color color;
    switch (status.toUpperCase()) {
      case 'NEW':
      case '0':
        color = Colors.blue;
        break;
      case 'PARTIALLY_FILLED':
      case '1':
        color = Colors.orange;
        break;
      case 'FILLED':
      case '2':
        color = UIConstants.colorAccept;
        break;
      case 'CANCELED':
      case '4':
        color = Colors.grey;
        break;
      case 'REJECTED':
      case '8':
        color = Colors.red;
        break;
      default:
        color = isDarkTheme ? Colors.grey[400]! : Colors.grey[600]!;
    }

    return Text(
      status,
      style: TextStyle(color: color, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildBusinessRejectsTable(bool isDarkTheme) {
    final headerColor = isDarkTheme ? Colors.grey[400] : Colors.grey[700];
    final cellColor = isDarkTheme ? Colors.white : Colors.black;
    final headerStyle = TextStyle(color: headerColor, fontSize: 10, fontWeight: FontWeight.bold);
    final cellStyle = TextStyle(color: cellColor, fontSize: UIConstants.fontSizeSm);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Rejects',
          style: TextStyle(
            color: Colors.red,
            fontSize: UIConstants.fontSizeMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: UIConstants.spacingXs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: UIConstants.spacingLg,
            headingRowHeight: 32,
            dataRowMinHeight: 28,
            dataRowMaxHeight: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(4),
            ),
            columns: [
              DataColumn(label: Text('Ref Seq Num', style: headerStyle)),
              DataColumn(label: Text('Ref Msg Type', style: headerStyle)),
              DataColumn(label: Text('Reject Reason', style: headerStyle)),
              DataColumn(label: Text('Text', style: headerStyle)),
            ],
            rows: _businessRejects.map((reject) {
              return DataRow(cells: [
                DataCell(Text(reject['refSeqNum'] ?? reject['ref_seq_num'] ?? '-', style: cellStyle)),
                DataCell(Text(reject['refMsgType'] ?? reject['ref_msg_type'] ?? '-', style: cellStyle)),
                DataCell(Text(reject['businessRejectReason'] ?? reject['business_reject_reason'] ?? '-', style: cellStyle)),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(reject['text'] ?? '-', style: cellStyle, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaginationControls(bool isDarkTheme) {
    final textColor = isDarkTheme ? Colors.white : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.first_page, color: textColor, size: 20),
          onPressed: _currentPage > 1 ? () => _goToPage(1) : null,
        ),
        IconButton(
          icon: Icon(Icons.chevron_left, color: textColor, size: 20),
          onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
        ),
        Text(
          'Page $_currentPage of $_totalPages',
          style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: textColor, size: 20),
          onPressed: _currentPage < _totalPages ? () => _goToPage(_currentPage + 1) : null,
        ),
        IconButton(
          icon: Icon(Icons.last_page, color: textColor, size: 20),
          onPressed: _currentPage < _totalPages ? () => _goToPage(_totalPages) : null,
        ),
        SizedBox(width: UIConstants.spacingMd),
        // Page size selector
        SizedBox(
          width: 80,
          height: 32,
          child: DropdownButtonFormField<int>(
            value: _pageSize,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
              ),
              contentPadding: UIConstants.textFieldContentPadding,
              isDense: true,
            ),
            style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm),
            dropdownColor: isDarkTheme ? UIConstants.colorDarkFill : Colors.white,
            items: [10, 20, 50, 100]
                .map((size) => DropdownMenuItem(
                      value: size,
                      child: Text('$size', style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm)),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _pageSize = value;
                  _currentPage = 1;
                });
                _fetchExecutionReports();
              }
            },
          ),
        ),
        Text(
          ' / page',
          style: TextStyle(color: isDarkTheme ? Colors.grey[400] : Colors.grey[600], fontSize: UIConstants.fontSizeSm),
        ),
      ],
    );
  }
}
