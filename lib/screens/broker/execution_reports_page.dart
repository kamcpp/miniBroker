import 'dart:convert';
import 'dart:io';
import 'dart:ui';
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
import '../../generated/prtagent/v1/reporting.pbgrpc.dart';
import '../../generated/common.pb.dart' as common_pb;
import '../../services/page_state_service.dart';

class ExecutionReportsPage extends StatefulWidget {
  const ExecutionReportsPage({super.key});

  @override
  State<ExecutionReportsPage> createState() => _ExecutionReportsPageState();
}

class _ExecutionReportsPageState extends State<ExecutionReportsPage> {
  static const double _commandButtonHeight = UIConstants.buttonHeightStandard * 0.7;

  // Scroll controllers
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  // Data
  List<Map<String, dynamic>> _reports = [];
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
  final _requestIdController = TextEditingController();
  final _symbolController = TextEditingController();
  final _currencyController = TextEditingController();
  String? _execTypeFilter;
  String? _sideFilter;
  String? _sortBy = 'created_at';
  String _sortDirection = 'desc';

  static const _execTypeOptions = <String, String>{
    '': 'All Types',
    '0': 'New',
    '1': 'Partial Fill',
    '2': 'Fill',
    '3': 'Done for Day',
    '4': 'Canceled',
    '5': 'Replaced',
    '6': 'Pending Cancel',
    '8': 'Rejected',
    'A': 'Pending New',
    'C': 'Expired',
    'E': 'Pending Replace',
    'F': 'Trade',
  };

  static const _sideOptions = <String, String>{
    '': 'All Sides',
    '1': 'Buy',
    '2': 'Sell',
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

  static const _pageId = 'execution_reports';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'search': _searchController.text,
      'requestId': _requestIdController.text,
      'symbol': _symbolController.text,
      'currency': _currencyController.text,
      'execTypeFilter': _execTypeFilter,
      'sideFilter': _sideFilter,
      'sortBy': _sortBy,
      'sortDirection': _sortDirection,
      'currentPage': _currentPage,
      'pageSize': _pageSize,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _searchController.text = state['search'] ?? '';
      _requestIdController.text = state['requestId'] ?? '';
      _symbolController.text = state['symbol'] ?? '';
      _currencyController.text = state['currency'] ?? '';
      _execTypeFilter = state['execTypeFilter'];
      _sideFilter = state['sideFilter'];
      _sortBy = state['sortBy'] ?? 'created_at';
      _sortDirection = state['sortDirection'] ?? 'desc';
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 20;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchReports();
    });
  }

  @override
  void dispose() {
    _saveState();
    _searchController.dispose();
    _requestIdController.dispose();
    _symbolController.dispose();
    _currencyController.dispose();
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchReports() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ClientChannel? channel;
    try {
      // Create gRPC channel using app config
      channel = ClientChannel(
        AppConfig.grpcHost,
        port: AppConfig.grpcPort,
        options: ChannelOptions(
          credentials: AppConfig.grpcUseSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
        ),
      );

      // Build call options with API key header
      final callOptions = CallOptions(
        metadata: {
          if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty)
            'x-agora-participant-api-key': AppConfig.grpcApiKey!,
        },
        timeout: const Duration(minutes: 5),
      );

      final client = ReportingServiceClient(channel);

      // Build request
      final request = GetExecutionReportsRequest(
        proposedExecutionId: 'get_exec_reports_${DateTime.now().millisecondsSinceEpoch}',
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
        sortDirection: _sortDirection,
      );

      // Apply optional filters
      final requestId = _requestIdController.text.trim();
      if (requestId.isNotEmpty) request.requestId = requestId;
      final symbol = _symbolController.text.trim();
      if (symbol.isNotEmpty) request.symbol = symbol;
      final currency = _currencyController.text.trim();
      if (currency.isNotEmpty) request.currency = currency;
      if (_execTypeFilter != null && _execTypeFilter!.isNotEmpty) request.execType = _execTypeFilter!;
      if (_sideFilter != null && _sideFilter!.isNotEmpty) request.side = _sideFilter!;
      if (_sortBy != null && _sortBy!.isNotEmpty) request.sortBy = _sortBy!;
      final search = _searchController.text.trim();
      if (search.isNotEmpty) request.search = search;

      print('📋 [ExecReports] Calling GetExecutionReports sortBy=${request.sortBy}, sortDirection=${request.sortDirection}');
      final response = await client.getExecutionReports(request, options: callOptions);
      print('📋 [ExecReports] Raw response: ${response.toString()}');

      if (!mounted) return;

      final reports = response.executionReports;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0 ? (totalCount / _pageSize).ceil().clamp(1, 999999) : (reports.length == _pageSize ? _currentPage + 1 : _currentPage);

      print('📋 [ExecReports] Got ${reports.length} reports, totalCount=$totalCount, totalPages=$totalPages');
      if (reports.isNotEmpty) {
        print('📋 [ExecReports] First report: ${reports.first.toString()}');
      }

      // Convert protobuf objects to maps for the UI
      final reportMaps = reports.map((r) => <String, dynamic>{
        'iid': r.iid,
        'requestId': r.requestId,
        'venueIid': r.venueIid,
        'clOrdId': r.clOrdId,
        'orderId': r.orderId,
        'execId': r.execId,
        'execType': r.execType,
        'ordStatus': r.ordStatus,
        'symbol': r.symbol,
        'side': r.side,
        'leavesQty': r.leavesQty,
        'cumQty': r.cumQty,
        'avgPx': r.avgPx,
        'price': r.price,
        'orderQty': r.orderQty,
        'currency': r.currency,
        'transactTime': r.transactTime,
        'text': r.text,
        'createdAt': r.createdAt,
      }).toList();

      setState(() {
        _reports = reportMaps;
        _totalCount = totalCount > 0 ? totalCount : reports.length;
        _totalPages = totalPages;
        _isLoading = false;
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      print('❌ [ExecReports] gRPC error: code=${e.code}, message=${e.message}');
      setState(() {
        _errorMessage = 'gRPC error ${e.code}: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      print('❌ [ExecReports] Error: $e');
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    } finally {
      await channel?.shutdown();
    }
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() {
      _currentPage = page;
    });
    _fetchReports();
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
    });
    _fetchReports();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _requestIdController.clear();
      _symbolController.clear();
      _currencyController.clear();
      _execTypeFilter = null;
      _sideFilter = null;
      _sortBy = 'created_at';
      _sortDirection = 'desc';
      _currentPage = 1;
    });
    _fetchReports();
  }

  // Column definitions for export
  static const _exportColumns = [
    'execId', 'requestId', 'execType', 'ordStatus', 'symbol', 'side',
    'price', 'orderQty', 'cumQty', 'leavesQty', 'avgPx', 'currency',
    'clOrdId', 'orderId', 'venueIid', 'transactTime', 'createdAt', 'text',
  ];

  static const _exportHeaders = [
    'Exec ID', 'Request ID', 'Type', 'Status', 'Symbol', 'Side',
    'Price', 'Ord Qty', 'Cum Qty', 'Leaves', 'Avg Px', 'Currency',
    'Cl Ord ID', 'Order ID', 'Venue', 'Time', 'Created At', 'Text',
  ];

  /// Fetch ALL reports matching current filters (no pagination limit) for export.
  Future<List<Map<String, dynamic>>> _fetchAllReportsForExport() async {
    final allReports = <Map<String, dynamic>>[];
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

      final client = ReportingServiceClient(channel);

      while (true) {
        final request = GetExecutionReportsRequest(
          proposedExecutionId: 'export_${DateTime.now().millisecondsSinceEpoch}',
          pagination: common_pb.PaginationParams(
            pageNr: page,
            pageSize: batchSize,
          ),
          sortDirection: _sortDirection,
        );

        // Apply same filters as the current view
        final requestId = _requestIdController.text.trim();
        if (requestId.isNotEmpty) request.requestId = requestId;
        final symbol = _symbolController.text.trim();
        if (symbol.isNotEmpty) request.symbol = symbol;
        final currency = _currencyController.text.trim();
        if (currency.isNotEmpty) request.currency = currency;
        if (_execTypeFilter != null && _execTypeFilter!.isNotEmpty) request.execType = _execTypeFilter!;
        if (_sideFilter != null && _sideFilter!.isNotEmpty) request.side = _sideFilter!;
        if (_sortBy != null && _sortBy!.isNotEmpty) request.sortBy = _sortBy!;
        final search = _searchController.text.trim();
        if (search.isNotEmpty) request.search = search;

        final response = await client.getExecutionReports(request, options: callOptions);
        final reports = response.executionReports;

        for (final r in reports) {
          allReports.add(<String, dynamic>{
            'iid': r.iid,
            'requestId': r.requestId,
            'venueIid': r.venueIid,
            'clOrdId': r.clOrdId,
            'orderId': r.orderId,
            'execId': r.execId,
            'execType': r.execType,
            'ordStatus': r.ordStatus,
            'symbol': r.symbol,
            'side': r.side,
            'leavesQty': r.leavesQty,
            'cumQty': r.cumQty,
            'avgPx': r.avgPx,
            'price': r.price,
            'orderQty': r.orderQty,
            'currency': r.currency,
            'transactTime': r.transactTime,
            'text': r.text,
            'createdAt': r.createdAt,
          });
        }

        // Stop if we got fewer than requested (last page) or no results
        if (reports.length < batchSize) break;
        page++;
      }
    } finally {
      await channel?.shutdown();
    }

    return allReports;
  }

  Future<void> _exportReports(String format) async {
    if (_reports.isEmpty) return;

    try {
      // Show loading indicator
      setState(() => _isLoading = true);

      final exportData = await _fetchAllReportsForExport();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (exportData.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No reports to export')),
          );
        }
        return;
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final defaultName = 'exec_reports_$timestamp';

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
        case 'fix':
          await _exportFIX(defaultName, exportData);
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
    for (final report in data) {
      rows.add(_exportColumns.map((col) => _str(report, col)).toList());
    }
    return rows;
  }

  Future<String?> _pickSaveLocation(String defaultName, String extension) async {
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Execution Reports',
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

    final jsonList = data.map((report) {
      final map = <String, String>{};
      for (int i = 0; i < _exportColumns.length; i++) {
        map[_exportHeaders[i]] = _str(report, _exportColumns[i]);
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
    final sheet = excel['Execution Reports'];

    // Remove default Sheet1
    excel.delete('Sheet1');

    // Header row
    for (int i = 0; i < _exportHeaders.length; i++) {
      sheet.cell(xl.CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = xl.TextCellValue(_exportHeaders[i]);
    }

    // Data rows
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
          'Execution Reports - Exported ${DateTime.now().toIso8601String().split('T').first} (${data.length} records)',
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

  Future<void> _exportFIX(String defaultName, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(defaultName, 'txt');
    if (path == null) return;

    final buffer = StringBuffer();
    final soh = '|'; // Use | as delimiter for readability (SOH in real FIX)

    for (final report in data) {
      final fields = <String>[
        '35=8', // MsgType = Execution Report
        '17=${_str(report, 'execId')}',
        '11=${_str(report, 'clOrdId')}',
        '37=${_str(report, 'orderId')}',
        '150=${_str(report, 'execType')}',
        '39=${_str(report, 'ordStatus')}',
        '55=${_str(report, 'symbol')}',
        '54=${_str(report, 'side')}',
        '44=${_str(report, 'price')}',
        '38=${_str(report, 'orderQty')}',
        '14=${_str(report, 'cumQty')}',
        '151=${_str(report, 'leavesQty')}',
        '6=${_str(report, 'avgPx')}',
        '15=${_str(report, 'currency')}',
        '60=${_str(report, 'transactTime')}',
        '58=${_str(report, 'text')}',
      ];
      buffer.writeln(fields.join(soh));
    }

    await File(path).writeAsString(buffer.toString());
    _showExportSuccess(path, data.length);
  }

  void _showExportSuccess(String path, int count) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exported $count reports to: $path', style: const TextStyle(fontSize: 12)),
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
      menuItems: MenuItemsHelper.buildMenuItems(context, 'execution_reports'),
      content: Container(
        color: backgroundColor,
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title row
            _buildTitleRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),

            // Filters - centered
            _buildFiltersRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),

            // Content
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
                                  child: Text(
                                    _errorMessage!,
                                    style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _commandButtonHeight,
                                child: ElevatedButton(
                                  onPressed: _fetchReports,
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
          'Execution Reports',
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
            onPressed: _isLoading ? null : _fetchReports,
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
            onSelected: _reports.isEmpty ? null : (format) => _exportReports(format),
            enabled: _reports.isNotEmpty,
            tooltip: 'Export',
            offset: const Offset(0, 36),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'csv', child: Text('Export as CSV')),
              const PopupMenuItem(value: 'json', child: Text('Export as JSON')),
              const PopupMenuItem(value: 'excel', child: Text('Export as Excel')),
              const PopupMenuItem(value: 'pdf', child: Text('Export as PDF')),
              const PopupMenuItem(value: 'fix', child: Text('Export as FIX (tag=value)')),
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

    return Column(
      children: [
        // Line 1: Text fields
        Row(
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
              width: 130,
              height: UIConstants.buttonHeightStandard,
              child: TextField(
                controller: _requestIdController,
                style: textStyle,
                decoration: inputDecoration.copyWith(hintText: 'Request ID', hintStyle: hintStyle),
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
          ],
        ),
        const SizedBox(height: 2),
        // Line 2: Combo boxes + buttons
        Row(
          children: [
            SizedBox(
              width: 150,
              height: UIConstants.buttonHeightStandard,
              child: DropdownButtonFormField<String>(
                value: _execTypeFilter,
                isDense: true,
                isExpanded: true,
                decoration: inputDecoration.copyWith(hintText: 'Exec Type', hintStyle: hintStyle),
                style: textStyle,
                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                items: _execTypeOptions.entries
                    .map((e) => DropdownMenuItem(
                          value: e.key.isEmpty ? null : e.key,
                          child: Text(e.value, style: textStyle),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _execTypeFilter = value),
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
                value: _sortBy,
                isDense: true,
                isExpanded: true,
                decoration: inputDecoration.copyWith(hintText: 'Sort By', hintStyle: hintStyle),
                style: textStyle,
                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                items: _sortByOptions.entries
                    .map((e) => DropdownMenuItem(
                          value: e.key.isEmpty ? null : e.key,
                          child: Text(e.value, style: textStyle),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _sortBy = value),
              ),
            ),
            SizedBox(width: UIConstants.spacingXs),
            SizedBox(
              height: _commandButtonHeight,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _sortDirection = _sortDirection == 'desc' ? 'asc' : 'desc';
                  });
                },
                icon: Icon(
                  _sortDirection == 'desc' ? Icons.arrow_downward : Icons.arrow_upward,
                  size: 16,
                  color: UIConstants.textPrimary(isDarkTheme),
                ),
                tooltip: _sortDirection == 'desc' ? 'Descending (click for Ascending)' : 'Ascending (click for Descending)',
                style: IconButton.styleFrom(
                  backgroundColor: UIConstants.tableHeaderBackground(isDarkTheme),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                    side: BorderSide(color: UIConstants.borderColor(isDarkTheme)),
                  ),
                ),
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
        ),
      ],
    );
  }

  Widget _buildContent(bool isDarkTheme) {
    if (_reports.isEmpty) {
      return Center(
        child: Text(
          'No execution reports found.',
          style: TextStyle(
            color: UIConstants.textSecondary(isDarkTheme),
            fontSize: UIConstants.fontSizeSm,
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            controller: _verticalScrollController,
            thumbVisibility: true,
            child: Scrollbar(
              controller: _horizontalScrollController,
              thumbVisibility: true,
              notificationPredicate: (notification) => notification.depth == 1,
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                          child: _buildReportsTable(isDarkTheme),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: UIConstants.spacingMd),
        _buildPaginationControls(isDarkTheme),
      ],
    );
  }

  Widget _buildReportsTable(bool isDarkTheme) {
    final headerColor = UIConstants.textSecondary(isDarkTheme);
    final headerStyle = TextStyle(color: headerColor, fontSize: 10, fontWeight: FontWeight.bold);

    return DataTable(
      columnSpacing: UIConstants.spacingLg,
      headingRowHeight: 32,
      dataRowMinHeight: 28,
      dataRowMaxHeight: 36,
      showCheckboxColumn: false,
      headingRowColor: WidgetStatePropertyAll(UIConstants.tableHeaderBackground(isDarkTheme)),
      decoration: BoxDecoration(
        border: Border.all(color: UIConstants.borderColor(isDarkTheme)),
        borderRadius: BorderRadius.circular(4),
      ),
      columns: [
        DataColumn(label: Text('Exec ID', style: headerStyle)),
        DataColumn(label: Text('Request ID', style: headerStyle)),
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
        DataColumn(label: Text('Cl Ord ID', style: headerStyle)),
        DataColumn(label: Text('Order ID', style: headerStyle)),
        DataColumn(label: Text('Venue', style: headerStyle)),
        DataColumn(label: Text('Time', style: headerStyle)),
        DataColumn(label: Text('Created At', style: headerStyle)),
        DataColumn(label: Text('Text', style: headerStyle)),
      ],
      rows: _reports.asMap().entries.map((entry) {
        final idx = entry.key;
        final report = entry.value;
        final execType = _str(report, 'execType', 'exec_type');
        final ordStatus = _str(report, 'ordStatus', 'ord_status');
        final side = _str(report, 'side');
        return DataRow(
          selected: _selectedRowIndex == idx,
          onSelectChanged: (_) {
            setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx);
          },
          color: WidgetStatePropertyAll(
            idx % 2 == 0 ? UIConstants.tableRowEven(isDarkTheme) : UIConstants.tableRowOdd(isDarkTheme),
          ),
          cells: [
          _copyableCell(_str(report, 'execId', 'exec_id'), isDarkTheme),
          _copyableCell(_str(report, 'requestId', 'request_id'), isDarkTheme),
          _badgeCell(execType, _execTypeBadge(execType, isDarkTheme)),
          _badgeCell(ordStatus, _ordStatusBadge(ordStatus, isDarkTheme)),
          _copyableCell(_str(report, 'symbol'), isDarkTheme),
          _sideCell(side, isDarkTheme),
          _priceCell(_str(report, 'price'), isDarkTheme),
          _qtyCell(_str(report, 'orderQty', 'order_qty'), isDarkTheme),
          _qtyCell(_str(report, 'cumQty', 'cum_qty'), isDarkTheme),
          _qtyCell(_str(report, 'leavesQty', 'leaves_qty'), isDarkTheme),
          _priceCell(_str(report, 'avgPx', 'avg_px'), isDarkTheme),
          _copyableCell(_str(report, 'currency'), isDarkTheme),
          _copyableCell(_str(report, 'clOrdId', 'cl_ord_id'), isDarkTheme),
          _copyableCell(_str(report, 'orderId', 'order_id'), isDarkTheme),
          _copyableCell(_str(report, 'venueIid', 'venue_iid'), isDarkTheme),
          _copyableCell(_str(report, 'transactTime', 'transact_time'), isDarkTheme, noTruncate: true),
          _copyableCell(_str(report, 'createdAt', 'created_at'), isDarkTheme, noTruncate: true),
          _copyableTextCell(_str(report, 'text'), isDarkTheme),
        ]);
      }).toList(),
    );
  }

  /// Extract string value from report map, trying camelCase then snake_case keys
  String _str(Map<String, dynamic> map, String key1, [String? key2]) {
    final val = map[key1] ?? (key2 != null ? map[key2] : null);
    if (val == null) return '-';
    return val.toString().isEmpty ? '-' : val.toString();
  }

  /// Max column width for cell content
  static const double _defaultMaxCellWidth = 140;
  static const double _wideMaxCellWidth = 200;
  static const int _truncateThreshold = 20;

  /// Truncate long values showing start...end
  /// Eth addresses (0x + 40 hex chars) get special short form: 0x1234...abcd
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

  DataCell _copyableCell(String value, bool isDarkTheme, {double maxWidth = _defaultMaxCellWidth, Color? textColor, bool noTruncate = false}) {
    final display = noTruncate ? value : _truncate(value);
    final needsTooltip = display != value;
    final child = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(
        display,
        style: TextStyle(
          color: textColor ?? UIConstants.textPrimary(isDarkTheme),
          fontSize: UIConstants.fontSizeSm,
          fontWeight: textColor != null ? FontWeight.w600 : null,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );

    return DataCell(
      Tooltip(
        message: needsTooltip ? value : '',
        waitDuration: const Duration(milliseconds: 300),
        child: InkWell(
          onTap: () => _copyToClipboard(value),
          child: child,
        ),
      ),
    );
  }

  DataCell _copyableTextCell(String value, bool isDarkTheme) {
    return _copyableCell(value, isDarkTheme, maxWidth: _wideMaxCellWidth);
  }

  DataCell _sideCell(String side, bool isDarkTheme) {
    final isBuy = side == '1' || side.toUpperCase() == 'BUY';
    final displaySide = side == '1' ? 'BUY' : side == '2' ? 'SELL' : side;
    return DataCell(
      Tooltip(
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
      ),
    );
  }

  /// Price cell with amber color — show raw value as received
  DataCell _priceCell(String value, bool isDarkTheme) {
    if (value == '-') return _copyableCell(value, isDarkTheme);
    return _copyableCell(value, isDarkTheme, textColor: Colors.amber.shade300);
  }

  /// Quantity cell — show raw value as received
  DataCell _qtyCell(String value, bool isDarkTheme) {
    return _copyableCell(value, isDarkTheme);
  }

  DataCell _badgeCell(String value, Widget badge) {
    return DataCell(
      Tooltip(
        message: value,
        waitDuration: const Duration(milliseconds: 300),
        child: InkWell(
          onTap: () => _copyToClipboard(value),
          child: badge,
        ),
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
        bgColor = Colors.deepOrange.shade400;
        break;
      case '8':
        bgColor = Colors.red;
        break;
      case 'C':
        bgColor = Colors.amber.shade700;
        break;
      case 'A':
      case 'E':
        bgColor = Colors.cyan;
        break;
      default:
        bgColor = UIConstants.textHint(isDarkTheme);
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

  static const _ordStatusLabels = <String, String>{
    '0': 'New',
    '1': 'Partially Filled',
    '2': 'Filled',
    '3': 'Done for Day',
    '4': 'Canceled',
    '5': 'Replaced',
    '6': 'Pending Cancel',
    '7': 'Stopped',
    '8': 'Rejected',
    '9': 'Suspended',
    'A': 'Pending New',
    'B': 'Calculated',
    'C': 'Expired',
    'D': 'Accepted for Bidding',
    'E': 'Pending Replace',
  };

  Widget _ordStatusBadge(String status, bool isDarkTheme) {
    final label = _ordStatusLabels[status] ?? _ordStatusLabels[status.toUpperCase()] ?? status;
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
        color = Colors.deepOrange.shade400;
        break;
      case 'REJECTED':
      case '8':
        color = Colors.red;
        break;
      case 'EXPIRED':
      case 'C':
        color = Colors.amber.shade700;
        break;
      case 'PENDING_NEW':
      case 'PENDING_CANCEL':
      case 'PENDING_REPLACE':
      case 'A':
      case '6':
      case 'E':
        color = Colors.cyan;
        break;
      case 'REPLACED':
      case '5':
        color = Colors.teal;
        break;
      default:
        color = UIConstants.textSecondary(isDarkTheme);
    }

    return Text(
      label,
      style: TextStyle(color: color, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPaginationControls(bool isDarkTheme) {
    final textColor = UIConstants.textPrimary(isDarkTheme);

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
        SizedBox(
          width: 80,
          height: UIConstants.buttonHeightStandard,
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
            dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
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
                _fetchReports();
              }
            },
          ),
        ),
        Text(
          ' / page',
          style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
        ),
      ],
    );
  }
}
