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
import '../../generated/prtagent/v1/reporting.pbgrpc.dart';
import '../../generated/common.pb.dart' as common_pb;
import '../../services/page_state_service.dart';

class AgoraEventsPage extends StatefulWidget {
  const AgoraEventsPage({super.key});

  @override
  State<AgoraEventsPage> createState() => _AgoraEventsPageState();
}

class _AgoraEventsPageState extends State<AgoraEventsPage> {
  // Data
  List<Map<String, dynamic>> _events = [];
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
  final _eventTypeController = TextEditingController();
  final _orderIdController = TextEditingController();
  final _tradeIdController = TextEditingController();
  final _deploymentIidController = TextEditingController();

  static const _pageId = 'agora_events';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'eventType': _eventTypeController.text,
      'orderId': _orderIdController.text,
      'tradeId': _tradeIdController.text,
      'deploymentIid': _deploymentIidController.text,
      'currentPage': _currentPage,
      'pageSize': _pageSize,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _eventTypeController.text = state['eventType'] ?? '';
      _orderIdController.text = state['orderId'] ?? '';
      _tradeIdController.text = state['tradeId'] ?? '';
      _deploymentIidController.text = state['deploymentIid'] ?? '';
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 20;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchEvents();
    });
  }

  @override
  void dispose() {
    _saveState();
    _eventTypeController.dispose();
    _orderIdController.dispose();
    _tradeIdController.dispose();
    _deploymentIidController.dispose();
    super.dispose();
  }

  Future<void> _fetchEvents() async {
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

      final client = AdminServiceClient(channel);

      final request = GetAgoraEventsRequest(
        proposedExecutionId: 'get_agora_events_${DateTime.now().millisecondsSinceEpoch}',
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
        sortDirection: 'desc',
      );

      // Apply optional filters
      final eventType = _eventTypeController.text.trim();
      if (eventType.isNotEmpty) request.eventType = eventType;
      final orderId = _orderIdController.text.trim();
      if (orderId.isNotEmpty) request.orderId = orderId;
      final tradeId = _tradeIdController.text.trim();
      if (tradeId.isNotEmpty) request.tradeId = tradeId;
      final deploymentIid = _deploymentIidController.text.trim();
      if (deploymentIid.isNotEmpty) request.deploymentIid = deploymentIid;

      print('📋 [AgoraEvents] Calling GetAgoraEvents sortDirection=${request.sortDirection}');
      final response = await client.getAgoraEvents(request, options: callOptions);
      print('📋 [AgoraEvents] Raw response: ${response.toString()}');

      if (!mounted) return;

      final events = response.agoraEvents;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0 ? (totalCount / _pageSize).ceil().clamp(1, 999999) : (events.length == _pageSize ? _currentPage + 1 : _currentPage);

      print('📋 [AgoraEvents] Got ${events.length} events, totalCount=$totalCount, totalPages=$totalPages');
      if (events.isNotEmpty) {
        print('📋 [AgoraEvents] First event: ${events.first.toString()}');
      }

      final eventMaps = events.map((e) => <String, dynamic>{
        'iid': e.iid,
        'eventHash': e.eventHash,
        'eventId': e.eventId,
        'timestamp': e.timestamp,
        'pairId': e.pairId,
        'eventType': e.eventType,
        'eventTypeName': e.eventTypeName,
        'orderId': e.orderId,
        'otherOrderId': e.otherOrderId,
        'tradeId': e.tradeId,
        'quantity': e.quantity,
        'errorCode': e.errorCode,
        'reason': e.reason,
        'quoteBalance': e.quoteBalance,
        'data': e.data,
        'engineAddr': e.engineAddr,
        'deploymentIid': e.deploymentIid,
        'createdAt': e.createdAt,
      }).toList();

      setState(() {
        _events = eventMaps;
        _totalCount = totalCount > 0 ? totalCount : events.length;
        _totalPages = totalPages;
        _isLoading = false;
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      print('❌ [AgoraEvents] gRPC error: code=${e.code}, message=${e.message}');
      setState(() {
        _errorMessage = 'gRPC error ${e.code}: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      print('❌ [AgoraEvents] Error: $e');
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
    _fetchEvents();
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
    });
    _fetchEvents();
  }

  void _resetFilters() {
    setState(() {
      _eventTypeController.clear();
      _orderIdController.clear();
      _tradeIdController.clear();
      _deploymentIidController.clear();
      _currentPage = 1;
    });
    _fetchEvents();
  }

  // Column definitions for export
  static const _exportColumns = [
    'eventId', 'eventHash', 'eventType', 'eventTypeName', 'pairId',
    'orderId', 'otherOrderId', 'tradeId', 'quantity', 'errorCode',
    'reason', 'quoteBalance', 'engineAddr', 'deploymentIid',
    'timestamp', 'createdAt', 'data',
  ];

  static const _exportHeaders = [
    'Event ID', 'Event Hash', 'Event Type', 'Event Type Name', 'Pair ID',
    'Order ID', 'Other Order ID', 'Trade ID', 'Quantity', 'Error Code',
    'Reason', 'Quote Balance', 'Engine Addr', 'Deployment IID',
    'Timestamp', 'Created At', 'Data',
  ];

  Future<List<Map<String, dynamic>>> _fetchAllEventsForExport() async {
    final allEvents = <Map<String, dynamic>>[];
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

      final client = AdminServiceClient(channel);

      while (true) {
        final request = GetAgoraEventsRequest(
          proposedExecutionId: 'export_${DateTime.now().millisecondsSinceEpoch}',
          pagination: common_pb.PaginationParams(
            pageNr: page,
            pageSize: batchSize,
          ),
          sortDirection: 'desc',
        );

        final eventType = _eventTypeController.text.trim();
        if (eventType.isNotEmpty) request.eventType = eventType;
        final orderId = _orderIdController.text.trim();
        if (orderId.isNotEmpty) request.orderId = orderId;
        final tradeId = _tradeIdController.text.trim();
        if (tradeId.isNotEmpty) request.tradeId = tradeId;
        final deploymentIid = _deploymentIidController.text.trim();
        if (deploymentIid.isNotEmpty) request.deploymentIid = deploymentIid;

        final response = await client.getAgoraEvents(request, options: callOptions);
        final events = response.agoraEvents;

        for (final e in events) {
          allEvents.add(<String, dynamic>{
            'iid': e.iid,
            'eventHash': e.eventHash,
            'eventId': e.eventId,
            'timestamp': e.timestamp,
            'pairId': e.pairId,
            'eventType': e.eventType,
            'eventTypeName': e.eventTypeName,
            'orderId': e.orderId,
            'otherOrderId': e.otherOrderId,
            'tradeId': e.tradeId,
            'quantity': e.quantity,
            'errorCode': e.errorCode,
            'reason': e.reason,
            'quoteBalance': e.quoteBalance,
            'data': e.data,
            'engineAddr': e.engineAddr,
            'deploymentIid': e.deploymentIid,
            'createdAt': e.createdAt,
          });
        }

        if (events.length < batchSize) break;
        page++;
      }
    } finally {
      await channel?.shutdown();
    }

    return allEvents;
  }

  Future<void> _exportEvents(String format) async {
    if (_events.isEmpty) return;

    try {
      setState(() => _isLoading = true);

      final exportData = await _fetchAllEventsForExport();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (exportData.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No events to export')),
          );
        }
        return;
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final defaultName = 'agora_events_$timestamp';

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
    for (final event in data) {
      rows.add(_exportColumns.map((col) => _str(event, col)).toList());
    }
    return rows;
  }

  Future<String?> _pickSaveLocation(String defaultName, String extension) async {
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Agora Events',
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

    final jsonList = data.map((event) {
      final map = <String, String>{};
      for (int i = 0; i < _exportColumns.length; i++) {
        map[_exportHeaders[i]] = _str(event, _exportColumns[i]);
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
    final sheet = excel['Agora Events'];

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
          'Agora Events - Exported ${DateTime.now().toIso8601String().split('T').first} (${data.length} records)',
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
        content: Text('Exported $count events to: $path', style: const TextStyle(fontSize: 12)),
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
      menuItems: MenuItemsHelper.buildMenuItems(context, 'agora_events'),
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
                                height: UIConstants.buttonHeightStandard * 0.7,
                                child: ElevatedButton(
                                  onPressed: _fetchEvents,
                                  style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)),
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
          'Agora Events',
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
          height: UIConstants.buttonHeightStandard * 0.7,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchEvents,
            icon: const Icon(Icons.refresh, size: 16),
            label: Text('Refresh', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: UIConstants.buttonHeightStandard * 0.7,
          child: PopupMenuButton<String>(
            onSelected: _events.isEmpty ? null : (format) => _exportEvents(format),
            enabled: _events.isNotEmpty,
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
          width: 120,
          height: UIConstants.buttonHeightStandard * 0.7,
          child: TextField(
            controller: _eventTypeController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Event Type', hintStyle: hintStyle),
            onSubmitted: (_) => _applyFilters(),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 120,
          height: UIConstants.buttonHeightStandard * 0.7,
          child: TextField(
            controller: _orderIdController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Order ID', hintStyle: hintStyle),
            onSubmitted: (_) => _applyFilters(),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 120,
          height: UIConstants.buttonHeightStandard * 0.7,
          child: TextField(
            controller: _tradeIdController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Trade ID', hintStyle: hintStyle),
            onSubmitted: (_) => _applyFilters(),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          width: 140,
          height: UIConstants.buttonHeightStandard * 0.7,
          child: TextField(
            controller: _deploymentIidController,
            style: textStyle,
            decoration: inputDecoration.copyWith(hintText: 'Deployment IID', hintStyle: hintStyle),
            onSubmitted: (_) => _applyFilters(),
          ),
        ),
        SizedBox(width: UIConstants.spacingSm),
        SizedBox(
          height: UIConstants.buttonHeightStandard * 0.7,
          child: ElevatedButton(
            onPressed: _applyFilters,
            style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)),
            child: Text('Apply', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
          ),
        ),
        SizedBox(width: UIConstants.spacingXs),
        SizedBox(
          height: UIConstants.buttonHeightStandard * 0.7,
          child: TextButton(
            onPressed: _resetFilters,
            child: Text('Reset', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(bool isDarkTheme) {
    if (_events.isEmpty) {
      return Center(
        child: Text(
          'No agora events found.',
          style: TextStyle(
            color: UIConstants.textSecondary(isDarkTheme),
            fontSize: UIConstants.fontSizeSm,
          ),
        ),
      );
    }

    return _buildEventsTable(isDarkTheme);
  }

  Widget _buildEventsTable(bool isDarkTheme) {
    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: const [
        StyledColumn(label: 'Event ID', flex: 1),
        StyledColumn(label: 'Event Hash', flex: 1),
        StyledColumn(label: 'Event Type', flex: 1),
        StyledColumn(label: 'Pair ID', flex: 1),
        StyledColumn(label: 'Order ID', flex: 1),
        StyledColumn(label: 'Other Order ID', flex: 1),
        StyledColumn(label: 'Trade ID', flex: 1),
        StyledColumn(label: 'Quantity', flex: 1),
        StyledColumn(label: 'Error Code', flex: 1),
        StyledColumn(label: 'Reason', flex: 1),
        StyledColumn(label: 'Quote Balance', flex: 1),
        StyledColumn(label: 'Engine Addr', flex: 1),
        StyledColumn(label: 'Deployment IID', flex: 1),
        StyledColumn(label: 'Timestamp', flex: 1),
        StyledColumn(label: 'Created At', flex: 1),
        StyledColumn(label: 'Data', flex: 1),
      ],
      rows: _events.asMap().entries.map((entry) {
        final idx = entry.key;
        final event = entry.value;
        return StyledRow(
          onTap: () {
            setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx);
          },
          cells: [
            _copyableCell(_str(event, 'eventId'), isDarkTheme),
            _copyableCell(_str(event, 'eventHash'), isDarkTheme),
            _eventTypeCell(_str(event, 'eventType'), _str(event, 'eventTypeName'), isDarkTheme),
            _copyableCell(_str(event, 'pairId'), isDarkTheme),
            _copyableCell(_str(event, 'orderId'), isDarkTheme),
            _copyableCell(_str(event, 'otherOrderId'), isDarkTheme),
            _copyableCell(_str(event, 'tradeId'), isDarkTheme),
            _copyableCell(_str(event, 'quantity'), isDarkTheme),
            _errorCodeCell(_str(event, 'errorCode'), isDarkTheme),
            _copyableTextCell(_str(event, 'reason'), isDarkTheme),
            _copyableCell(_str(event, 'quoteBalance'), isDarkTheme),
            _copyableCell(_str(event, 'engineAddr'), isDarkTheme),
            _copyableCell(_str(event, 'deploymentIid'), isDarkTheme),
            _copyableCell(_str(event, 'timestamp'), isDarkTheme, noTruncate: true),
            _copyableCell(_str(event, 'createdAt'), isDarkTheme, noTruncate: true),
            _copyableTextCell(_str(event, 'data'), isDarkTheme),
          ],
        );
      }).toList(),
      rowsPerPage: _pageSize,
      onPageChanged: _goToPage,
      currentPage: _currentPage,
      totalPages: _totalPages,
    );
  }

  String _str(Map<String, dynamic> map, String key1, [String? key2]) {
    final val = map[key1] ?? (key2 != null ? map[key2] : null);
    if (val == null) return '-';
    final s = val.toString();
    if (s.isEmpty || s == '0' && key1 == 'eventType') return '-';
    return s.isEmpty ? '-' : s;
  }

  static const double _defaultMaxCellWidth = 140;
  static const double _wideMaxCellWidth = 200;
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

  Widget _copyableCell(String value, bool isDarkTheme, {double maxWidth = _defaultMaxCellWidth, Color? textColor, bool noTruncate = false}) {
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

    return Tooltip(
      message: needsTooltip ? value : '',
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(value),
        child: child,
      ),
    );
  }

  Widget _copyableTextCell(String value, bool isDarkTheme) {
    return _copyableCell(value, isDarkTheme, maxWidth: _wideMaxCellWidth);
  }

  Color _eventTypeColor(String typeName) {
    final name = typeName.toLowerCase();
    if (name.contains('trade') || name.contains('fill')) return const Color(0xFF2E7D32); // green
    if (name.contains('cancel')) return Colors.deepOrange.shade400;
    if (name.contains('expire')) return Colors.amber.shade700;
    if (name.contains('reject')) return Colors.red;
    if (name.contains('place') || name.contains('new') || name.contains('create')) return Colors.blue;
    if (name.contains('replace') || name.contains('modify')) return Colors.teal;
    if (name.contains('partial')) return Colors.orange;
    if (name.contains('market') || name.contains('price')) return Colors.cyan;
    if (name.contains('system') || name.contains('admin')) return Colors.blueGrey;
    if (name.contains('error') || name.contains('fail')) return Colors.red.shade300;
    return Colors.amber.shade300; // default
  }

  Widget _eventTypeCell(String numericValue, String typeName, bool isDarkTheme) {
    final display = typeName.isNotEmpty && typeName != '-' ? typeName : numericValue;
    final color = _eventTypeColor(display);
    final child = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 168),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color, width: 0.5),
        ),
        child: Text(
          display,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );

    return Tooltip(
      message: numericValue,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(numericValue),
        child: child,
      ),
    );
  }

  Widget _errorCodeCell(String value, bool isDarkTheme) {
    if (value == '-' || value == '0') return _copyableCell(value, isDarkTheme);
    return _copyableCell(value, isDarkTheme, textColor: Colors.red);
  }

}
