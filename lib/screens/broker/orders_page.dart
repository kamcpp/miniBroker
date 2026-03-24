import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as xl;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import '../../services/theme_service.dart';
import '../../utils/menu_items_helper.dart';
import '../../config/app_config.dart';
import '../../config/ui_constants.dart';
import '../../widgets/base_page.dart';
import '../../widgets/styled_data_table.dart';
import '../../generated/prtagent/v1/participant.pbgrpc.dart';
import '../../generated/prtagent/v1/participant_types.pb.dart';
import '../../generated/fin/trading.pb.dart' as fin;
import '../../generated/fin/trading.pbenum.dart' as fin_enum;
import '../../generated/common.pb.dart' as common_pb;
import '../../services/page_state_service.dart';


class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  static const double _commandButtonHeight = UIConstants.buttonHeightStandard * 0.7;

  // Data
  List<Map<String, dynamic>> _orders = [];
  int _totalCount = 0;

  // Loading state
  bool _isLoading = false;
  String? _errorMessage;

  // Selection
  int? _selectedRowIndex;

  // Pagination
  int _currentPage = 1;
  int _pageSize = 20;
  int _totalPages = 1;

  // Filters
  final _searchController = TextEditingController();
  final _symbolController = TextEditingController();
  final _currencyController = TextEditingController();
  String? _sideFilter;
  String? _statusFilter;

  static const _sideOptions = <String, String>{
    '': 'All Sides',
    'BUY': 'Buy',
    'SELL': 'Sell',
  };

  static const _statusOptions = <String, String>{
    '': 'All Statuses',
    'active': 'Active',
    'filled': 'Filled',
    'cancelled': 'Cancelled',
    'expired': 'Expired',
  };

  static const _pageId = 'orders';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'search': _searchController.text,
      'symbol': _symbolController.text,
      'currency': _currencyController.text,
      'sideFilter': _sideFilter,
      'statusFilter': _statusFilter,
      'currentPage': _currentPage,
      'pageSize': _pageSize,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _searchController.text = state['search'] ?? '';
      _symbolController.text = state['symbol'] ?? '';
      _currencyController.text = state['currency'] ?? '';
      _sideFilter = state['sideFilter'];
      _statusFilter = state['statusFilter'];
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 20;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrders();
    });
  }

  @override
  void dispose() {
    _saveState();
    _searchController.dispose();
    _symbolController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ClientChannel? channel;
    try {
      channel = ClientChannel(
        AppConfig.grpcHost,
        port: AppConfig.grpcPort,
        options: ChannelOptions(
          credentials: AppConfig.grpcUseSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
        ),
      );

      final callOptions = CallOptions(
        metadata: {
          if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty)
            'x-agora-participant-api-key': AppConfig.grpcApiKey!,
        },
        timeout: const Duration(minutes: 5),
      );

      final client = ParticipantServiceClient(channel);

      final request = GetParticipantOrdersRequest(
        proposedExecutionId: 'get_orders_${DateTime.now().millisecondsSinceEpoch}',
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
      );

      // Apply optional filters
      if (_sideFilter != null && _sideFilter!.isNotEmpty) {
        if (_sideFilter == 'BUY') {
          request.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_BUY;
        } else if (_sideFilter == 'SELL') {
          request.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_SELL;
        }
      }

      print('📋 [Orders] Calling GetParticipantOrders page=$_currentPage, pageSize=$_pageSize');
      final response = await client.getParticipantOrders(request, options: callOptions);
      print('📋 [Orders] Raw response: ${response.toString()}');

      if (!mounted) return;

      final orders = response.orders;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0
          ? (totalCount / _pageSize).ceil().clamp(1, 999999)
          : (orders.length == _pageSize ? _currentPage + 1 : _currentPage);

      print('📋 [Orders] Got ${orders.length} orders, totalCount=$totalCount, totalPages=$totalPages');

      // Convert protobuf objects to maps for the UI, applying client-side filters
      final orderMaps = orders.map((o) => _orderToMap(o)).where((map) {
        // Client-side text search filter
        final search = _searchController.text.trim().toLowerCase();
        if (search.isNotEmpty) {
          final searchable = [
            map['orderId'], map['symbol'], map['currency'],
            map['participantOrderId'], map['status'],
            map['externalOrderId'], map['investorAccountIid'],
          ].map((v) => (v ?? '').toString().toLowerCase()).join(' ');
          if (!searchable.contains(search)) return false;
        }
        // Client-side symbol filter
        final symbolFilter = _symbolController.text.trim().toLowerCase();
        if (symbolFilter.isNotEmpty) {
          if (!(map['symbol'] ?? '').toString().toLowerCase().contains(symbolFilter)) return false;
        }
        // Client-side currency filter
        final currencyFilter = _currencyController.text.trim().toLowerCase();
        if (currencyFilter.isNotEmpty) {
          if (!(map['currency'] ?? '').toString().toLowerCase().contains(currencyFilter)) return false;
        }
        // Client-side status filter
        if (_statusFilter != null && _statusFilter!.isNotEmpty) {
          final isFilled = map['isFilled'] == true;
          final isCancelled = map['isCancelled'] == true;
          final isExpired = map['isExpired'] == true;
          switch (_statusFilter) {
            case 'active':
              if (isFilled || isCancelled || isExpired) return false;
              break;
            case 'filled':
              if (!isFilled) return false;
              break;
            case 'cancelled':
              if (!isCancelled) return false;
              break;
            case 'expired':
              if (!isExpired) return false;
              break;
          }
        }
        return true;
      }).toList();

      setState(() {
        _orders = orderMaps;
        _totalCount = totalCount > 0 ? totalCount : orders.length;
        _totalPages = totalPages;
        _isLoading = false;
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      print('❌ [Orders] gRPC error: code=${e.code}, message=${e.message}');
      setState(() {
        _errorMessage = 'gRPC error ${e.code}: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      print('❌ [Orders] Error: $e');
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    } finally {
      await channel?.shutdown();
    }
  }

  Map<String, dynamic> _orderToMap(fin.Order o) {
    final sideStr = o.side == fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_BUY
        ? 'BUY'
        : o.side == fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_SELL
            ? 'SELL'
            : o.side.name;
    String statusStr = _cleanStatusEnum(o.status);
    if (statusStr.isEmpty) {
      if (o.isFilled) {
        statusStr = 'FILLED';
      } else if (o.isCancelled) {
        statusStr = 'CANCELLED';
      } else if (o.isExpired) {
        statusStr = 'EXPIRED';
      } else {
        statusStr = 'ACTIVE';
      }
    }
    return <String, dynamic>{
      'orderId': o.orderId,
      'participantOrderId': o.participantOrderId,
      'externalOrderId': o.externalOrderId,
      'participantIid': o.participantIid,
      'investorAccountIid': o.investorAccountIid,
      'orderType': o.orderType,
      'side': sideStr,
      'symbol': o.symbol,
      'currency': o.currency,
      'quantity': o.quantity,
      'remainingQuantity': o.remainingQuantity,
      'price': o.price,
      'volume': o.volume,
      'remainingVolume': o.remainingVolume,
      'timeInForce': o.timeInForce,
      'status': statusStr,
      'isFilled': o.isFilled,
      'isCancelled': o.isCancelled,
      'isExpired': o.isExpired,
      'feeAmount': o.feeAmount,
      'securityListingIid': o.securityListingIid,
      'sagaInstanceId': o.sagaInstanceId,
      'createTimestamp': o.createTimestamp,
      'updatedAtTimestamp': o.updatedAtTimestamp,
    };
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() {
      _currentPage = page;
    });
    _fetchOrders();
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
    });
    _fetchOrders();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _symbolController.clear();
      _currencyController.clear();
      _sideFilter = null;
      _statusFilter = null;
      _currentPage = 1;
    });
    _fetchOrders();
  }

  // Column definitions for export
  static const _exportColumns = [
    'orderId', 'participantOrderId', 'externalOrderId', 'orderType', 'side',
    'symbol', 'currency', 'quantity', 'remainingQuantity', 'price', 'volume',
    'remainingVolume', 'timeInForce', 'status', 'feeAmount',
    'investorAccountIid', 'securityListingIid', 'createTimestamp', 'updatedAtTimestamp',
  ];

  static const _exportHeaders = [
    'Order ID', 'Participant Order ID', 'External Order ID', 'Type', 'Side',
    'Symbol', 'Currency', 'Quantity', 'Remaining Qty', 'Price', 'Volume',
    'Remaining Vol', 'Time in Force', 'Status', 'Fee',
    'Investor Account', 'Security Listing', 'Created', 'Updated',
  ];

  Future<List<Map<String, dynamic>>> _fetchAllOrdersForExport() async {
    final allOrders = <Map<String, dynamic>>[];
    int page = 1;
    const batchSize = 500;

    ClientChannel? channel;
    try {
      channel = ClientChannel(
        AppConfig.grpcHost,
        port: AppConfig.grpcPort,
        options: ChannelOptions(
          credentials: AppConfig.grpcUseSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
        ),
      );

      final callOptions = CallOptions(
        metadata: {
          if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty)
            'x-agora-participant-api-key': AppConfig.grpcApiKey!,
        },
        timeout: const Duration(minutes: 5),
      );

      final client = ParticipantServiceClient(channel);

      while (true) {
        final request = GetParticipantOrdersRequest(
          proposedExecutionId: 'export_orders_${DateTime.now().millisecondsSinceEpoch}',
          pagination: common_pb.PaginationParams(
            pageNr: page,
            pageSize: batchSize,
          ),
        );

        if (_sideFilter != null && _sideFilter!.isNotEmpty) {
          if (_sideFilter == 'BUY') {
            request.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_BUY;
          } else if (_sideFilter == 'SELL') {
            request.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_SELL;
          }
        }

        final response = await client.getParticipantOrders(request, options: callOptions);
        final orders = response.orders;

        for (final o in orders) {
          allOrders.add(_orderToMap(o));
        }

        if (orders.length < batchSize) break;
        page++;
      }
    } finally {
      await channel?.shutdown();
    }

    return allOrders;
  }

  Future<void> _exportOrders(String format) async {
    if (_orders.isEmpty) return;

    try {
      setState(() => _isLoading = true);

      final exportData = await _fetchAllOrdersForExport();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (exportData.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No orders to export')),
          );
        }
        return;
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final defaultName = 'orders_$timestamp';

      switch (format) {
        case 'csv':
          await _exportCSV(defaultName, exportData);
          break;
        case 'json':
          await _exportJSON(defaultName, exportData);
          break;
        case 'excel':
          await _exportExcel(defaultName, exportData);
          break;
        case 'pdf':
          await _exportPDF(defaultName, exportData);
          break;
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  List<List<String>> _buildExportRows(List<Map<String, dynamic>> data) {
    final rows = <List<String>>[_exportHeaders];
    for (final order in data) {
      rows.add(_exportColumns.map((col) => _str(order, col)).toList());
    }
    return rows;
  }

  Future<String?> _pickSaveLocation(String defaultName, String extension) async {
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Orders',
      fileName: '$defaultName.$extension',
    );
    return result;
  }

  Future<void> _exportCSV(String defaultName, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(defaultName, 'csv');
    if (path == null) return;

    final csv = const ListToCsvConverter().convert(_buildExportRows(data));
    await File(path).writeAsString(csv);
    _showExportSuccess(path, data.length);
  }

  Future<void> _exportJSON(String defaultName, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(defaultName, 'json');
    if (path == null) return;

    final jsonList = data.map((order) {
      final map = <String, String>{};
      for (int i = 0; i < _exportColumns.length; i++) {
        map[_exportHeaders[i]] = _str(order, _exportColumns[i]);
      }
      return map;
    }).toList();

    final encoder = const JsonEncoder.withIndent('  ');
    await File(path).writeAsString(encoder.convert(jsonList));
    _showExportSuccess(path, data.length);
  }

  Future<void> _exportExcel(String defaultName, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(defaultName, 'xlsx');
    if (path == null) return;

    final excel = xl.Excel.createExcel();
    final sheet = excel['Orders'];
    excel.delete('Sheet1');

    for (int i = 0; i < _exportHeaders.length; i++) {
      sheet.cell(xl.CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = xl.TextCellValue(_exportHeaders[i]);
    }

    for (int r = 0; r < data.length; r++) {
      for (int c = 0; c < _exportColumns.length; c++) {
        sheet.cell(xl.CellIndex.indexByColumnRow(columnIndex: c, rowIndex: r + 1)).value =
            xl.TextCellValue(_str(data[r], _exportColumns[c]));
      }
    }

    final bytes = excel.save();
    if (bytes != null) {
      await File(path).writeAsBytes(bytes);
    }
    _showExportSuccess(path, data.length);
  }

  Future<void> _exportPDF(String defaultName, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(defaultName, 'pdf');
    if (path == null) return;

    final pdf = pw.Document();
    final rows = _buildExportRows(data);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a3.landscape,
        margin: const pw.EdgeInsets.all(20),
        header: (context) => pw.Text(
          'Orders - Exported ${DateTime.now().toIso8601String().split('T').first} (${data.length} records)',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 5),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignments: {for (int i = 0; i < _exportHeaders.length; i++) i: pw.Alignment.centerLeft},
            data: rows,
          ),
        ],
      ),
    );

    final bytes = await pdf.save();
    await File(path).writeAsBytes(bytes);
    _showExportSuccess(path, data.length);
  }

  void _showExportSuccess(String path, int count) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exported $count orders to: $path', style: const TextStyle(fontSize: 12)),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Open Folder',
          onPressed: () {
            final dir = File(path).parent.path;
            Process.run('open', [dir]);
          },
        ),
      ),
    );
  }

  void _copyToClipboard(String value) {
    if (value.isEmpty || value == '-') return;
    Clipboard.setData(ClipboardData(text: value));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied: $value', style: const TextStyle(fontSize: 12)),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          width: 250,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;
    final backgroundColor = UIConstants.pageBackground(isDarkTheme);

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'orders'),
      content: Container(
        color: backgroundColor,
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),
            _buildFiltersRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.error_outline, size: 48, color: Colors.red),
                              SizedBox(height: UIConstants.spacingMd),
                              Tooltip(
                                message: 'Click to copy',
                                child: InkWell(
                                  onTap: () => _copyToClipboard(_errorMessage!),
                                  child: SelectableText(
                                    _errorMessage!,
                                    style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _commandButtonHeight,
                                child: ElevatedButton(
                                  onPressed: _fetchOrders,
                                  style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
                                    minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
                                  ),
                                  child: Text('Retry', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
                                ),
                              ),
                            ],
                          ),
                        )
                      : _buildContent(isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(bool isDarkTheme) {
    return Row(
      children: [
        Text(
          'Orders',
          style: TextStyle(
            color: UIConstants.textPrimary(isDarkTheme),
            fontSize: UIConstants.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (_totalCount > 0)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              '$_totalCount total',
              style: TextStyle(
                color: UIConstants.textSecondary(isDarkTheme),
                fontSize: UIConstants.fontSizeSm,
              ),
            ),
          ),
        SizedBox(
          height: _commandButtonHeight,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchOrders,
            icon: const Icon(Icons.refresh, size: 16),
            label: Text('Refresh', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
              minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: _commandButtonHeight,
          child: PopupMenuButton<String>(
            onSelected: _orders.isEmpty ? null : (format) => _exportOrders(format),
            enabled: _orders.isNotEmpty,
            tooltip: 'Export',
            offset: const Offset(0, 36),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'csv', child: Text('Export as CSV')),
              const PopupMenuItem(value: 'json', child: Text('Export as JSON')),
              const PopupMenuItem(value: 'excel', child: Text('Export as Excel')),
              const PopupMenuItem(value: 'pdf', child: Text('Export as PDF')),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: UIConstants.commandColor(isDarkTheme),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text('Export', style: TextStyle(fontSize: UIConstants.fontSizeSm, color: Colors.white)),
                  const Icon(Icons.arrow_drop_down, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersRow(bool isDarkTheme) {
    final textStyle = TextStyle(
      color: UIConstants.textPrimary(isDarkTheme),
      fontSize: UIConstants.fontSizeSm,
    );
    final hintStyle = TextStyle(
      color: UIConstants.textHint(isDarkTheme),
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
        SizedBox(
          width: 160,
          height: UIConstants.buttonHeightStandard,
          child: TextField(
            controller: _searchController,
            style: textStyle,
            decoration: inputDecoration.copyWith(
              hintText: 'Search...',
              hintStyle: hintStyle,
              prefixIcon: Icon(Icons.search, size: 16, color: UIConstants.textHint(isDarkTheme)),
              prefixIconConstraints: const BoxConstraints(minWidth: 32),
            ),
            onSubmitted: (_) => _applyFilters(),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 100,
          height: UIConstants.buttonHeightStandard,
          child: TextField(
            controller: _symbolController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Symbol', hintStyle: hintStyle),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 90,
          height: UIConstants.buttonHeightStandard,
          child: TextField(
            controller: _currencyController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Currency', hintStyle: hintStyle),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 130,
          height: UIConstants.buttonHeightStandard,
          child: DropdownButtonFormField<String>(
            value: _sideFilter,
            isDense: true,
            isExpanded: true,
            decoration: inputDecoration.copyWith(hintText: 'Side', hintStyle: hintStyle),
            style: textStyle,
            dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
            items: _sideOptions.entries
                .map((e) => DropdownMenuItem(
                      value: e.key.isEmpty ? null : e.key,
                      child: Text(e.value, style: textStyle),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _sideFilter = value),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 150,
          height: UIConstants.buttonHeightStandard,
          child: DropdownButtonFormField<String>(
            value: _statusFilter,
            isDense: true,
            isExpanded: true,
            decoration: inputDecoration.copyWith(hintText: 'Status', hintStyle: hintStyle),
            style: textStyle,
            dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
            items: _statusOptions.entries
                .map((e) => DropdownMenuItem(
                      value: e.key.isEmpty ? null : e.key,
                      child: Text(e.value, style: textStyle),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _statusFilter = value),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          height: _commandButtonHeight,
          child: ElevatedButton(
            onPressed: _applyFilters,
            style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
              minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
            ),
            child: Text('Apply', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
          ),
        ),
        SizedBox(width: UIConstants.spacingXs),
        SizedBox(
          height: UIConstants.buttonHeightStandard,
          child: TextButton(
            onPressed: _resetFilters,
            child: Text('Reset', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(bool isDarkTheme) {
    if (_orders.isEmpty) {
      return Center(
        child: Text(
          'No orders found.',
          style: TextStyle(
            color: UIConstants.textSecondary(isDarkTheme),
            fontSize: UIConstants.fontSizeSm,
          ),
        ),
      );
    }

    return _buildOrdersTable(isDarkTheme);
  }

  Widget _buildOrdersTable(bool isDarkTheme) {
    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: const [
        StyledColumn(label: 'Order ID', flex: 2),
        StyledColumn(label: 'Prt Order ID', flex: 2),
        StyledColumn(label: 'Ext Order ID', flex: 2),
        StyledColumn(label: 'Type', flex: 1),
        StyledColumn(label: 'Side', flex: 1),
        StyledColumn(label: 'Symbol', flex: 1),
        StyledColumn(label: 'Currency', flex: 1),
        StyledColumn(label: 'Quantity', flex: 1),
        StyledColumn(label: 'Rem Qty', flex: 1),
        StyledColumn(label: 'Price', flex: 1),
        StyledColumn(label: 'Volume', flex: 1),
        StyledColumn(label: 'Rem Vol', flex: 1),
        StyledColumn(label: 'TIF', flex: 1),
        StyledColumn(label: 'Status', flex: 1),
        StyledColumn(label: 'Fee', flex: 1),
        StyledColumn(label: 'Investor Acct', flex: 2),
        StyledColumn(label: 'Security Listing', flex: 2),
        StyledColumn(label: 'Saga ID', flex: 2),
        StyledColumn(label: 'Created', flex: 2),
        StyledColumn(label: 'Updated', flex: 2),
      ],
      rows: _orders.asMap().entries.map((entry) {
        final idx = entry.key;
        final order = entry.value;
        final side = _str(order, 'side');
        final status = _str(order, 'status');
        return StyledRow(
          selected: _selectedRowIndex == idx,
          onTap: () {
            setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx);
          },
          cells: [
            _copyableCell(_str(order, 'orderId'), isDarkTheme),
            _copyableCell(_str(order, 'participantOrderId'), isDarkTheme),
            _copyableCell(_str(order, 'externalOrderId'), isDarkTheme),
            _orderTypeBadge(_str(order, 'orderType'), isDarkTheme),
            _sideCell(side, isDarkTheme),
            _copyableCell(_str(order, 'symbol'), isDarkTheme),
            _copyableCell(_str(order, 'currency'), isDarkTheme),
            _qtyCell(_str(order, 'quantity'), isDarkTheme),
            _qtyCell(_str(order, 'remainingQuantity'), isDarkTheme),
            _priceCell(_str(order, 'price'), isDarkTheme),
            _qtyCell(_str(order, 'volume'), isDarkTheme),
            _qtyCell(_str(order, 'remainingVolume'), isDarkTheme),
            _copyableCell(_str(order, 'timeInForce'), isDarkTheme),
            _statusBadge(status, isDarkTheme),
            _priceCell(_str(order, 'feeAmount'), isDarkTheme),
            _copyableCell(_str(order, 'investorAccountIid'), isDarkTheme),
            _copyableCell(_str(order, 'securityListingIid'), isDarkTheme),
            _copyableCell(_str(order, 'sagaInstanceId'), isDarkTheme),
            _copyableCell(_str(order, 'createTimestamp'), isDarkTheme, noTruncate: true),
            _copyableCell(_str(order, 'updatedAtTimestamp'), isDarkTheme, noTruncate: true),
          ],
        );
      }).toList(),
      rowsPerPage: _pageSize,
      currentPage: _currentPage,
      totalPages: _totalPages,
      onPageChanged: _goToPage,
    );
  }

  /// Strip common proto enum prefixes and convert to human-readable form.
  /// e.g. "ORDER_REQUEST_STATUS_ENUM_PARTIALLY_FILLED" → "PARTIALLY FILLED"
  ///      "ORDER_SIDE_ENUM_BUY" → "BUY"
  static String _cleanStatusEnum(String raw) {
    if (raw.isEmpty) return raw;
    // Strip known prefixes
    const prefixes = [
      'ORDER_REQUEST_STATUS_ENUM_',
      'ORDER_STATUS_ENUM_',
      'ORDER_SIDE_ENUM_',
    ];
    String cleaned = raw;
    for (final prefix in prefixes) {
      if (cleaned.startsWith(prefix)) {
        cleaned = cleaned.substring(prefix.length);
        break;
      }
    }
    // Replace underscores with spaces for display
    return cleaned.replaceAll('_', ' ');
  }

  String _str(Map<String, dynamic> map, String key1, [String? key2]) {
    final val = map[key1] ?? (key2 != null ? map[key2] : null);
    if (val == null) return '-';
    if (val is bool) return val ? 'Yes' : 'No';
    return val.toString().isEmpty ? '-' : val.toString();
  }

  static const int _truncateThreshold = 20;

  String _truncate(String value, [int maxLen = _truncateThreshold]) {
    if (value == '-') return value;
    if (value.startsWith('0x') && value.length == 42) {
      return '${value.substring(0, 6)}...${value.substring(value.length - 4)}';
    }
    if (value.startsWith('0x') && value.length > 14) {
      return '${value.substring(0, 6)}...${value.substring(value.length - 4)}';
    }
    if (value.length <= maxLen) return value;
    final keep = (maxLen - 3) ~/ 2;
    return '${value.substring(0, keep)}...${value.substring(value.length - keep)}';
  }

  Widget _copyableCell(String value, bool isDarkTheme, {Color? textColor, bool noTruncate = false}) {
    final sanitized = value.replaceAll('\x01', '|');
    final display = noTruncate ? sanitized : _truncate(sanitized);
    final needsTooltip = display != value;
    final child = Text(
      display,
      style: TextStyle(
        color: textColor ?? UIConstants.textPrimary(isDarkTheme),
        fontSize: UIConstants.fontSizeSm,
        fontWeight: textColor != null ? FontWeight.w600 : null,
      ),
      overflow: TextOverflow.ellipsis,
    );

    return Tooltip(
      message: needsTooltip ? value : '',
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(value),
        child: child,
      ),
    );
  }

  Widget _sideCell(String side, bool isDarkTheme) {
    final s = side.toUpperCase();
    final isBuy = s == '1' || s.contains('BUY') || s.contains('BID') || s.contains('CALL');
    final isSell = s == '2' || s.contains('SELL') || s.contains('ASK') || s.contains('PUT');
    final displaySide = isBuy ? 'BUY' : isSell ? 'SELL' : side;
    return Tooltip(
      message: displaySide,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(displaySide),
        child: Text(
          displaySide,
          style: TextStyle(
            color: isBuy ? UIConstants.colorAccept : Colors.red,
            fontSize: UIConstants.fontSizeSm,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _priceCell(String value, bool isDarkTheme) {
    if (value == '-') return _copyableCell(value, isDarkTheme);
    return _copyableCell(value, isDarkTheme, textColor: Colors.amber.shade300);
  }

  Widget _qtyCell(String value, bool isDarkTheme) {
    return _copyableCell(value, isDarkTheme);
  }

  Widget _orderTypeBadge(String orderType, bool isDarkTheme) {
    final label = orderType.isEmpty || orderType == '-' ? '-' : orderType.toUpperCase();
    Color bgColor;
    switch (label) {
      case 'LIMIT':
        bgColor = Colors.blue;
        break;
      case 'MARKET':
        bgColor = Colors.orange;
        break;
      default:
        bgColor = UIConstants.textHint(isDarkTheme);
    }

    if (label == '-') return _copyableCell(label, isDarkTheme);

    return Tooltip(
      message: label,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(label),
        child: Container(
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
        ),
      ),
    );
  }

  Widget _statusBadge(String status, bool isDarkTheme) {
    final s = status.toUpperCase();
    Color color;
    if (s.contains('PARTIALLY') || s == 'PARTIAL FILL') {
      color = Colors.orange;
    } else if (s == 'FILLED' || s == 'FILL') {
      color = UIConstants.colorAccept;
    } else if (s.contains('CANCEL')) {
      color = Colors.deepOrange.shade400;
    } else if (s.contains('FAIL') || s.contains('REJECT')) {
      color = Colors.red;
    } else if (s.contains('EXPIR')) {
      color = Colors.amber.shade700;
    } else if (s == 'ACTIVE' || s.contains('PENDING') || s.contains('VALIDAT') || s.contains('SUBMIT') || s == 'NEW') {
      color = Colors.blue;
    } else {
      color = UIConstants.textSecondary(isDarkTheme);
    }

    return Tooltip(
      message: status,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(status),
        child: Text(
          s,
          style: TextStyle(color: color, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
