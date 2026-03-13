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

class TreasuryActivitiesPage extends StatefulWidget {
  const TreasuryActivitiesPage({super.key});

  @override
  State<TreasuryActivitiesPage> createState() => _TreasuryActivitiesPageState();
}

class _TreasuryActivitiesPageState extends State<TreasuryActivitiesPage> {
  // Scroll controllers
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  // Data
  List<Map<String, dynamic>> _activities = [];
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
  final _operationController = TextEditingController();
  final _contractAddrController = TextEditingController();
  final _senderAccountController = TextEditingController();
  String? _sortBy = 'created_at';
  String _sortDirection = 'desc';

  static const _sortByOptions = <String, String>{
    '': 'Default',
    'created_at': 'Created At',
    'operation': 'Operation',
    'amount': 'Amount',
    'token_id': 'Token ID',
    'timestamp': 'Timestamp',
  };

  static const _pageId = 'treasury_activities';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'search': _searchController.text,
      'operation': _operationController.text,
      'contractAddr': _contractAddrController.text,
      'senderAccount': _senderAccountController.text,
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
      _operationController.text = state['operation'] ?? '';
      _contractAddrController.text = state['contractAddr'] ?? '';
      _senderAccountController.text = state['senderAccount'] ?? '';
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
      _fetchActivities();
    });
  }

  @override
  void dispose() {
    _saveState();
    _searchController.dispose();
    _operationController.dispose();
    _contractAddrController.dispose();
    _senderAccountController.dispose();
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchActivities() async {
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
      final request = GetTreasuryActivitiesRequest(
        proposedExecutionId: 'get_treasury_activities_${DateTime.now().millisecondsSinceEpoch}',
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
        sortDirection: _sortDirection,
      );

      // Apply optional filters
      final operation = _operationController.text.trim();
      if (operation.isNotEmpty) request.operation = operation;
      final contractAddr = _contractAddrController.text.trim();
      if (contractAddr.isNotEmpty) request.contractAddr = contractAddr;
      final senderAccount = _senderAccountController.text.trim();
      if (senderAccount.isNotEmpty) request.senderAccount = senderAccount;
      if (_sortBy != null && _sortBy!.isNotEmpty) request.sortBy = _sortBy!;
      final search = _searchController.text.trim();
      if (search.isNotEmpty) request.search = search;

      print('📋 [TreasuryActivities] Calling ReportingService.GetTreasuryActivities via native gRPC');
      final response = await client.getTreasuryActivities(request, options: callOptions);
      print('📋 [TreasuryActivities] Raw response: ${response.toString()}');

      if (!mounted) return;

      final activities = response.activities;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0 ? (totalCount / _pageSize).ceil().clamp(1, 999999) : (activities.length == _pageSize ? _currentPage + 1 : _currentPage);

      print('📋 [TreasuryActivities] Got ${activities.length} activities, totalCount=$totalCount, totalPages=$totalPages');
      if (activities.isNotEmpty) {
        print('📋 [TreasuryActivities] First activity: ${activities.first.toString()}');
      }

      // Convert protobuf objects to maps for the UI
      final activityMaps = activities.map((r) => <String, dynamic>{
        'iid': r.iid,
        'activityId': r.activityId,
        'activityHash': r.activityHash,
        'idempotencyKey': r.idempotencyKey,
        'timestamp': r.timestamp,
        'ledgerId': r.ledgerId,
        'operation': r.operation,
        'operationName': r.operationName,
        'senderAccount': r.senderAccount,
        'callerAccount': r.callerAccount,
        'contractAddr': r.contractAddr,
        'contractType': r.contractType,
        'fromAccount': r.fromAccount,
        'toAccount': r.toAccount,
        'fromVault': r.fromVault,
        'toVault': r.toVault,
        'fromReserveId': r.fromReserveId,
        'toReserveId': r.toReserveId,
        'fromStash': r.fromStash,
        'toStash': r.toStash,
        'tokenId': r.tokenId,
        'amount': r.amount,
        'data': r.data,
        'deploymentIid': r.deploymentIid,
        'mechanismIid': r.mechanismIid,
        'legalStructureIid': r.legalStructureIid,
        'trezorSlotAddress': r.trezorSlotAddress,
        'execRuntimeName': r.execRuntimeName,
        'createdAt': r.createdAt,
      }).toList();

      setState(() {
        _activities = activityMaps;
        _totalCount = totalCount > 0 ? totalCount : activities.length;
        _totalPages = totalPages;
        _isLoading = false;
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      print('❌ [TreasuryActivities] gRPC error: code=${e.code}, message=${e.message}');
      setState(() {
        _errorMessage = 'gRPC error ${e.code}: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      print('❌ [TreasuryActivities] Error: $e');
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
    _fetchActivities();
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
    });
    _fetchActivities();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _operationController.clear();
      _contractAddrController.clear();
      _senderAccountController.clear();
      _sortBy = 'created_at';
      _sortDirection = 'desc';
      _currentPage = 1;
    });
    _fetchActivities();
  }

  // Column definitions for export (all 29 fields)
  static const _exportColumns = [
    'iid', 'activityId', 'activityHash', 'idempotencyKey', 'timestamp',
    'ledgerId', 'operation', 'operationName', 'senderAccount', 'callerAccount',
    'contractAddr', 'contractType', 'fromAccount', 'toAccount', 'fromVault',
    'toVault', 'fromReserveId', 'toReserveId', 'fromStash', 'toStash',
    'tokenId', 'amount', 'data', 'deploymentIid', 'mechanismIid',
    'legalStructureIid', 'trezorSlotAddress', 'execRuntimeName', 'createdAt',
  ];

  static const _exportHeaders = [
    'IID', 'Activity ID', 'Activity Hash', 'Idempotency Key', 'Timestamp',
    'Ledger ID', 'Operation', 'Operation Name', 'Sender Account', 'Caller Account',
    'Contract Addr', 'Contract Type', 'From Account', 'To Account', 'From Vault',
    'To Vault', 'From Reserve ID', 'To Reserve ID', 'From Stash', 'To Stash',
    'Token ID', 'Amount', 'Data', 'Deployment IID', 'Mechanism IID',
    'Legal Structure IID', 'Trezor Slot Address', 'Exec Runtime Name', 'Created At',
  ];

  /// Fetch ALL activities matching current filters (no pagination limit) for export.
  Future<List<Map<String, dynamic>>> _fetchAllActivitiesForExport() async {
    final allActivities = <Map<String, dynamic>>[];
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
        final request = GetTreasuryActivitiesRequest(
          proposedExecutionId: 'export_${DateTime.now().millisecondsSinceEpoch}',
          pagination: common_pb.PaginationParams(
            pageNr: page,
            pageSize: batchSize,
          ),
          sortDirection: _sortDirection,
        );

        // Apply same filters as the current view
        final operation = _operationController.text.trim();
        if (operation.isNotEmpty) request.operation = operation;
        final contractAddr = _contractAddrController.text.trim();
        if (contractAddr.isNotEmpty) request.contractAddr = contractAddr;
        final senderAccount = _senderAccountController.text.trim();
        if (senderAccount.isNotEmpty) request.senderAccount = senderAccount;
        if (_sortBy != null && _sortBy!.isNotEmpty) request.sortBy = _sortBy!;
        final search = _searchController.text.trim();
        if (search.isNotEmpty) request.search = search;

        final response = await client.getTreasuryActivities(request, options: callOptions);
        final activities = response.activities;

        for (final r in activities) {
          allActivities.add(<String, dynamic>{
            'iid': r.iid,
            'activityId': r.activityId,
            'activityHash': r.activityHash,
            'idempotencyKey': r.idempotencyKey,
            'timestamp': r.timestamp,
            'ledgerId': r.ledgerId,
            'operation': r.operation,
            'operationName': r.operationName,
            'senderAccount': r.senderAccount,
            'callerAccount': r.callerAccount,
            'contractAddr': r.contractAddr,
            'contractType': r.contractType,
            'fromAccount': r.fromAccount,
            'toAccount': r.toAccount,
            'fromVault': r.fromVault,
            'toVault': r.toVault,
            'fromReserveId': r.fromReserveId,
            'toReserveId': r.toReserveId,
            'fromStash': r.fromStash,
            'toStash': r.toStash,
            'tokenId': r.tokenId,
            'amount': r.amount,
            'data': r.data,
            'deploymentIid': r.deploymentIid,
            'mechanismIid': r.mechanismIid,
            'legalStructureIid': r.legalStructureIid,
            'trezorSlotAddress': r.trezorSlotAddress,
            'execRuntimeName': r.execRuntimeName,
            'createdAt': r.createdAt,
          });
        }

        // Stop if we got fewer than requested (last page) or no results
        if (activities.length < batchSize) break;
        page++;
      }
    } finally {
      await channel?.shutdown();
    }

    return allActivities;
  }

  Future<void> _exportActivities(String format) async {
    if (_activities.isEmpty) return;

    try {
      // Show loading indicator
      setState(() => _isLoading = true);

      final exportData = await _fetchAllActivitiesForExport();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (exportData.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No activities to export')),
          );
        }
        return;
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final defaultName = 'treasury_activities_$timestamp';

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
    for (final activity in data) {
      rows.add(_exportColumns.map((col) => _str(activity, col)).toList());
    }
    return rows;
  }

  Future<String?> _pickSaveLocation(String defaultName, String extension) async {
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Treasury Activities',
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

    final jsonList = data.map((activity) {
      final map = <String, String>{};
      for (int i = 0; i < _exportColumns.length; i++) {
        map[_exportHeaders[i]] = _str(activity, _exportColumns[i]);
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
    final sheet = excel['Treasury Activities'];

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
          'Treasury Activities - Exported ${DateTime.now().toIso8601String().split('T').first} (${data.length} records)',
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
    final soh = '|'; // Use | as delimiter for readability

    for (final activity in data) {
      final fields = <String>[
        'iid=${_str(activity, 'iid')}',
        'activityId=${_str(activity, 'activityId')}',
        'activityHash=${_str(activity, 'activityHash')}',
        'idempotencyKey=${_str(activity, 'idempotencyKey')}',
        'timestamp=${_str(activity, 'timestamp')}',
        'ledgerId=${_str(activity, 'ledgerId')}',
        'operation=${_str(activity, 'operation')}',
        'operationName=${_str(activity, 'operationName')}',
        'senderAccount=${_str(activity, 'senderAccount')}',
        'callerAccount=${_str(activity, 'callerAccount')}',
        'contractAddr=${_str(activity, 'contractAddr')}',
        'contractType=${_str(activity, 'contractType')}',
        'fromAccount=${_str(activity, 'fromAccount')}',
        'toAccount=${_str(activity, 'toAccount')}',
        'fromVault=${_str(activity, 'fromVault')}',
        'toVault=${_str(activity, 'toVault')}',
        'fromReserveId=${_str(activity, 'fromReserveId')}',
        'toReserveId=${_str(activity, 'toReserveId')}',
        'fromStash=${_str(activity, 'fromStash')}',
        'toStash=${_str(activity, 'toStash')}',
        'tokenId=${_str(activity, 'tokenId')}',
        'amount=${_str(activity, 'amount')}',
        'data=${_str(activity, 'data')}',
        'deploymentIid=${_str(activity, 'deploymentIid')}',
        'mechanismIid=${_str(activity, 'mechanismIid')}',
        'legalStructureIid=${_str(activity, 'legalStructureIid')}',
        'trezorSlotAddress=${_str(activity, 'trezorSlotAddress')}',
        'execRuntimeName=${_str(activity, 'execRuntimeName')}',
        'createdAt=${_str(activity, 'createdAt')}',
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
        content: Text('Exported $count activities to: $path', style: const TextStyle(fontSize: 12)),
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
      menuItems: MenuItemsHelper.buildMenuItems(context, 'treasury_activities'),
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
                                height: UIConstants.buttonHeightStandard,
                                child: ElevatedButton(
                                  onPressed: _fetchActivities,
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
          'Treasury Activities',
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
          height: UIConstants.buttonHeightStandard,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchActivities,
            icon: const Icon(Icons.refresh, size: 16),
            label: Text('Refresh', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: UIConstants.buttonHeightStandard,
          child: PopupMenuButton<String>(
            onSelected: _activities.isEmpty ? null : (format) => _exportActivities(format),
            enabled: _activities.isNotEmpty,
            tooltip: 'Export',
            offset: const Offset(0, 36),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'csv', child: Text('Export as CSV')),
              const PopupMenuItem(value: 'json', child: Text('Export as JSON')),
              const PopupMenuItem(value: 'excel', child: Text('Export as Excel')),
              const PopupMenuItem(value: 'pdf', child: Text('Export as PDF')),
              const PopupMenuItem(value: 'fix', child: Text('Export as FIX (key=value)')),
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
                controller: _operationController,
                style: textStyle,
                decoration: inputDecoration.copyWith(hintText: 'Operation', hintStyle: hintStyle),
              ),
            ),
            SizedBox(width: UIConstants.spacingSm),
            SizedBox(
              width: 130,
              height: UIConstants.buttonHeightStandard,
              child: TextField(
                controller: _contractAddrController,
                style: textStyle,
                decoration: inputDecoration.copyWith(hintText: 'Contract Addr', hintStyle: hintStyle),
              ),
            ),
            SizedBox(width: UIConstants.spacingSm),
            SizedBox(
              width: 130,
              height: UIConstants.buttonHeightStandard,
              child: TextField(
                controller: _senderAccountController,
                style: textStyle,
                decoration: inputDecoration.copyWith(hintText: 'Sender Account', hintStyle: hintStyle),
              ),
            ),
          ],
        ),
        SizedBox(height: UIConstants.spacingSm),
        // Line 2: Combo boxes + buttons
        Row(
          children: [
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
            SizedBox(width: UIConstants.spacingSm),
            SizedBox(
              height: UIConstants.buttonHeightStandard,
              child: IconButton(
                icon: Icon(
                  _sortDirection == 'asc' ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 16,
                  color: UIConstants.textPrimary(isDarkTheme),
                ),
                onPressed: () => setState(() => _sortDirection = _sortDirection == 'asc' ? 'desc' : 'asc'),
                tooltip: _sortDirection == 'asc' ? 'Ascending' : 'Descending',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ),
            SizedBox(width: UIConstants.spacingSm),
            SizedBox(
              height: UIConstants.buttonHeightStandard,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)),
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
    if (_activities.isEmpty) {
      return Center(
        child: Text(
          'No treasury activities found.',
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
                          child: _buildActivitiesTable(isDarkTheme),
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

  Widget _buildActivitiesTable(bool isDarkTheme) {
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
        DataColumn(label: Text('#', style: headerStyle)),
        DataColumn(label: Text('Activity ID', style: headerStyle)),
        DataColumn(label: Text('Operation', style: headerStyle)),
        DataColumn(label: Text('Amount', style: headerStyle)),
        DataColumn(label: Text('Sender Account', style: headerStyle)),
        DataColumn(label: Text('From Account', style: headerStyle)),
        DataColumn(label: Text('To Account', style: headerStyle)),
        DataColumn(label: Text('From Vault', style: headerStyle)),
        DataColumn(label: Text('To Vault', style: headerStyle)),
        DataColumn(label: Text('From Stash', style: headerStyle)),
        DataColumn(label: Text('To Stash', style: headerStyle)),
        DataColumn(label: Text('Contract Addr', style: headerStyle)),
        DataColumn(label: Text('Contract Type', style: headerStyle)),
        DataColumn(label: Text('Timestamp', style: headerStyle)),
        DataColumn(label: Text('Created At', style: headerStyle)),
        DataColumn(label: Text('Data', style: headerStyle)),
      ],
      rows: _activities.asMap().entries.map((entry) {
        final idx = entry.key;
        final activity = entry.value;
        final opName = _str(activity, 'operationName').toUpperCase();

        // Operation-aware N/A logic
        final isTransferVault = opName.contains('TRANSFER_VAULT') || opName.contains('TRANSFERVAULT');
        final isDeposit = opName.contains('DEPOSIT');

        final fromAccount = isTransferVault ? 'N/A' : _str(activity, 'fromAccount');
        final toAccount = isTransferVault ? 'N/A' : _str(activity, 'toAccount');
        final fromVault = isDeposit ? 'N/A' : _str(activity, 'fromVault');
        final fromStash = isDeposit ? 'N/A' : _str(activity, 'fromStash');
        final toStash = isDeposit ? 'N/A' : _str(activity, 'toStash');

        return DataRow(
          selected: _selectedRowIndex == idx,
          onSelectChanged: (_) {
            setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx);
          },
          color: WidgetStatePropertyAll(
            idx % 2 == 0 ? UIConstants.tableRowEven(isDarkTheme) : UIConstants.tableRowOdd(isDarkTheme),
          ),
          cells: [
          _hashCell(_str(activity, 'activityHash'), isDarkTheme),
          _copyableCell(_str(activity, 'activityId'), isDarkTheme),
          _operationBadgeCell(_str(activity, 'operation'), _str(activity, 'operationName'), isDarkTheme),
          _amountCell(_str(activity, 'amount'), isDarkTheme),
          _copyableCell(_str(activity, 'senderAccount'), isDarkTheme),
          _copyableCell(fromAccount, isDarkTheme),
          _copyableCell(toAccount, isDarkTheme),
          _copyableCell(fromVault, isDarkTheme),
          _copyableCell(_str(activity, 'toVault'), isDarkTheme),
          _copyableCell(fromStash, isDarkTheme),
          _copyableCell(toStash, isDarkTheme),
          _copyableCell(_str(activity, 'contractAddr'), isDarkTheme),
          _copyableCell(_str(activity, 'contractType'), isDarkTheme),
          _copyableCell(_str(activity, 'timestamp'), isDarkTheme, noTruncate: true),
          _copyableCell(_str(activity, 'createdAt'), isDarkTheme, noTruncate: true),
          _copyableTextCell(_str(activity, 'data'), isDarkTheme),
        ]);
      }).toList(),
    );
  }

  /// Extract string value from activity map
  String _str(Map<String, dynamic> map, String key1, [String? key2]) {
    final val = map[key1] ?? (key2 != null ? map[key2] : null);
    if (val == null) return '-';
    return val.toString().isEmpty ? '-' : val.toString();
  }

  /// Format amount with divisibility (default 2 for most currencies)
  String _formatAmount(String rawAmount, [int decimals = 2]) {
    if (rawAmount == '-' || rawAmount.isEmpty) return rawAmount;
    try {
      final value = double.parse(rawAmount);
      if (decimals <= 0) return rawAmount;
      double divisor = 1;
      for (var i = 0; i < decimals; i++) {
        divisor *= 10;
      }
      return (value / divisor).toStringAsFixed(decimals);
    } catch (_) {
      return rawAmount;
    }
  }

  /// Max column width for cell content
  static const double _defaultMaxCellWidth = 140;
  static const double _wideMaxCellWidth = 200;
  static const int _truncateThreshold = 20;

  /// Truncate long values showing start...end
  /// Eth addresses (0x + 40 hex chars) get special short form: 0x1234...abcd
  String _truncate(String value, [int maxLen = _truncateThreshold]) {
    if (value == '-') return value;
    // Eth address: 0x followed by 40 hex chars = 42 total
    if (value.startsWith('0x') && value.length == 42) {
      return '${value.substring(0, 6)}...${value.substring(value.length - 4)}';
    }
    // General long hex/addresses starting with 0x
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

  /// Hash icon cell - shows # icon, copies full hash on click
  DataCell _hashCell(String hash, bool isDarkTheme) {
    if (hash == '-') return _copyableCell(hash, isDarkTheme);
    return DataCell(
      Tooltip(
        message: hash,
        waitDuration: const Duration(milliseconds: 300),
        child: InkWell(
          onTap: () => _copyToClipboard(hash),
          child: Icon(
            Icons.tag,
            size: 16,
            color: UIConstants.commandColor(isDarkTheme),
          ),
        ),
      ),
    );
  }

  /// Operation badge with color coding
  DataCell _operationBadgeCell(String operation, String operationName, bool isDarkTheme) {
    final display = operationName != '-' ? operationName : operation;
    final fullValue = operationName != '-' ? '$operationName ($operation)' : operation;
    final op = operationName.toUpperCase();

    Color bgColor;
    if (op.contains('DEPOSIT') || op.contains('MINT')) {
      bgColor = UIConstants.colorAccept;
    } else if (op.contains('WITHDRAW') || op.contains('BURN') || op.contains('REDEEM')) {
      bgColor = Colors.red;
    } else if (op.contains('TRANSFER') || op.contains('MOVE')) {
      bgColor = Colors.blue;
    } else if (op.contains('SETTLE') || op.contains('DELIVERY')) {
      bgColor = Colors.teal;
    } else if (op.contains('LOCK') || op.contains('FREEZE')) {
      bgColor = Colors.orange;
    } else if (op.contains('UNLOCK') || op.contains('UNFREEZE')) {
      bgColor = Colors.cyan;
    } else if (op.contains('CREATE') || op.contains('ISSUE')) {
      bgColor = Colors.purple;
    } else {
      bgColor = UIConstants.textHint(isDarkTheme);
    }

    return DataCell(
      Tooltip(
        message: fullValue,
        waitDuration: const Duration(milliseconds: 300),
        child: InkWell(
          onTap: () => _copyToClipboard(fullValue),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: bgColor, width: 0.5),
            ),
            child: Text(
              display,
              style: TextStyle(color: bgColor, fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  /// Amount cell with color (green for positive, red for negative)
  DataCell _amountCell(String rawAmount, bool isDarkTheme) {
    final formatted = _formatAmount(rawAmount);
    if (formatted == '-') return _copyableCell(formatted, isDarkTheme);
    try {
      final value = double.parse(rawAmount);
      final color = value >= 0 ? UIConstants.colorAccept : Colors.red;
      return _copyableCell(formatted, isDarkTheme, textColor: color);
    } catch (_) {
      return _copyableCell(formatted, isDarkTheme);
    }
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
                _fetchActivities();
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
