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
import '../../generated/prtagent/v1/investor.pbgrpc.dart';
import '../../generated/prtagent/v1/investor.pb.dart';
import '../../generated/common.pb.dart' as common_pb;
import '../../services/page_state_service.dart';


class InvestorsPage extends StatefulWidget {
  const InvestorsPage({super.key});

  @override
  State<InvestorsPage> createState() => _InvestorsPageState();
}

class _InvestorsPageState extends State<InvestorsPage> {
  static const double _commandButtonHeight = UIConstants.buttonHeightStandard * 0.7;

  // Data
  List<Map<String, dynamic>> _investors = [];
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

  static const _pageId = 'investors';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'search': _searchController.text,
      'currentPage': _currentPage,
      'pageSize': _pageSize,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _searchController.text = state['search'] ?? '';
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 20;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInvestors();
    });
  }

  @override
  void dispose() {
    _saveState();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchInvestors() async {
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

      final client = InvestorServiceClient(channel);

      final request = GetInvestorListRequest(
        proposedExecutionId: 'get_investors_${DateTime.now().millisecondsSinceEpoch}',
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
      );

      // Apply search as external_investor_id filter
      final search = _searchController.text.trim();
      if (search.isNotEmpty) {
        request.externalInvestorId = search;
      }

      final response = await client.getInvestorList(request, options: callOptions);

      if (!mounted) return;

      final investors = response.investors;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0
          ? (totalCount / _pageSize).ceil().clamp(1, 999999)
          : (investors.length == _pageSize ? _currentPage + 1 : _currentPage);

      final investorMaps = investors.map((inv) => <String, dynamic>{
        'iid': inv.iid,
        'externalInvestorId': inv.externalInvestorId,
        'investorStatus': _cleanEnum(inv.investorStatus.name),
        'types': inv.types.map((t) => _cleanEnum(t.name)).join(', '),
        'displayNames': inv.displayNames.entries.map((e) => '${e.key}: ${e.value}').join(', '),
        'labels': inv.labels.entries.map((e) => '${e.key}: ${e.value}').join(', '),
        'tags': inv.tags.join(', '),
        'metadata': inv.metadata.entries.map((e) => '${e.key}: ${e.value}').join(', '),
      }).toList();

      setState(() {
        _investors = investorMaps;
        _totalCount = totalCount > 0 ? totalCount : investors.length;
        _totalPages = totalPages;
        _isLoading = false;
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'gRPC error ${e.code}: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    } finally {
      await channel?.shutdown();
    }
  }

  static String _cleanEnum(String raw) {
    const prefixes = [
      'INVESTOR_STATUS_ENUM_',
      'INVESTOR_TYPE_ENUM_',
    ];
    String cleaned = raw;
    for (final prefix in prefixes) {
      if (cleaned.startsWith(prefix)) {
        cleaned = cleaned.substring(prefix.length);
        break;
      }
    }
    return cleaned.replaceAll('_', ' ');
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() => _currentPage = page);
    _fetchInvestors();
  }

  void _applyFilters() {
    setState(() => _currentPage = 1);
    _fetchInvestors();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _currentPage = 1;
    });
    _fetchInvestors();
  }

  // Export
  static const _exportColumns = [
    'iid', 'externalInvestorId', 'investorStatus', 'types',
    'displayNames', 'labels', 'tags',
  ];
  static const _exportHeaders = [
    'IID', 'External Investor ID', 'Status', 'Types',
    'Display Names', 'Labels', 'Tags',
  ];

  Future<void> _exportInvestors(String format) async {
    if (_investors.isEmpty) return;
    try {
      setState(() => _isLoading = true);
      if (!mounted) return;
      setState(() => _isLoading = false);

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final defaultName = 'investors_$timestamp';

      switch (format) {
        case 'csv':
          await _exportCSV(defaultName, _investors);
          break;
        case 'json':
          await _exportJSON(defaultName, _investors);
          break;
        case 'excel':
          await _exportExcel(defaultName, _investors);
          break;
        case 'pdf':
          await _exportPDF(defaultName, _investors);
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

  String _str(Map<String, dynamic> map, String key) {
    final val = map[key];
    if (val == null) return '-';
    return val.toString().isEmpty ? '-' : val.toString();
  }

  List<List<String>> _buildExportRows(List<Map<String, dynamic>> data) {
    final rows = <List<String>>[_exportHeaders];
    for (final inv in data) {
      rows.add(_exportColumns.map((col) => _str(inv, col)).toList());
    }
    return rows;
  }

  Future<String?> _pickSaveLocation(String defaultName, String extension) async {
    return await FilePicker.platform.saveFile(
      dialogTitle: 'Export Investors',
      fileName: '$defaultName.$extension',
    );
  }

  Future<void> _exportCSV(String name, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(name, 'csv');
    if (path == null) return;
    final csv = const ListToCsvConverter().convert(_buildExportRows(data));
    await File(path).writeAsString(csv);
    _showExportSuccess(path, data.length);
  }

  Future<void> _exportJSON(String name, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(name, 'json');
    if (path == null) return;
    final jsonList = data.map((inv) {
      final map = <String, String>{};
      for (int i = 0; i < _exportColumns.length; i++) {
        map[_exportHeaders[i]] = _str(inv, _exportColumns[i]);
      }
      return map;
    }).toList();
    await File(path).writeAsString(const JsonEncoder.withIndent('  ').convert(jsonList));
    _showExportSuccess(path, data.length);
  }

  Future<void> _exportExcel(String name, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(name, 'xlsx');
    if (path == null) return;
    final excel = xl.Excel.createExcel();
    final sheet = excel['Investors'];
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
    if (bytes != null) await File(path).writeAsBytes(bytes);
    _showExportSuccess(path, data.length);
  }

  Future<void> _exportPDF(String name, List<Map<String, dynamic>> data) async {
    final path = await _pickSaveLocation(name, 'pdf');
    if (path == null) return;
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a3.landscape,
      margin: const pw.EdgeInsets.all(20),
      header: (ctx) => pw.Text(
        'Investors - Exported ${DateTime.now().toIso8601String().split('T').first} (${data.length} records)',
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      ),
      build: (ctx) => [
        pw.TableHelper.fromTextArray(
          headerStyle: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
          cellStyle: const pw.TextStyle(fontSize: 5),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          data: _buildExportRows(data),
        ),
      ],
    ));
    await File(path).writeAsBytes(await pdf.save());
    _showExportSuccess(path, data.length);
  }

  void _showExportSuccess(String path, int count) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Exported $count investors to: $path', style: const TextStyle(fontSize: 12)),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(label: 'Open Folder', onPressed: () => Process.run('open', [File(path).parent.path])),
    ));
  }

  void _copyToClipboard(String value) {
    if (value.isEmpty || value == '-') return;
    Clipboard.setData(ClipboardData(text: value));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied: $value', style: const TextStyle(fontSize: 12)),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        width: 250,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;
    final backgroundColor = UIConstants.pageBackground(isDarkTheme);

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'investors'),
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
                      ? Center(child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.red),
                            SizedBox(height: UIConstants.spacingMd),
                            InkWell(
                              onTap: () => _copyToClipboard(_errorMessage!),
                              child: SelectableText(_errorMessage!,
                                style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: UIConstants.spacingMd),
                            SizedBox(
                              height: _commandButtonHeight,
                              child: ElevatedButton(
                                onPressed: _fetchInvestors,
                                style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
                                  minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
                                ),
                                child: Text('Retry', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
                              ),
                            ),
                          ],
                        ))
                      : _investors.isEmpty
                          ? Center(child: Text('No investors found.',
                              style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm)))
                          : _buildTable(isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(bool isDarkTheme) {
    return Row(children: [
      Text('Investors', style: TextStyle(
        color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeLg, fontWeight: FontWeight.bold,
      )),
      const Spacer(),
      if (_totalCount > 0)
        Padding(padding: const EdgeInsets.only(right: 12), child: Text(
          '$_totalCount total',
          style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
        )),
      SizedBox(
        height: _commandButtonHeight,
        child: ElevatedButton.icon(
          onPressed: _isLoading ? null : _fetchInvestors,
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
          onSelected: _investors.isEmpty ? null : (format) => _exportInvestors(format),
          enabled: _investors.isNotEmpty,
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
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.download, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text('Export', style: TextStyle(fontSize: UIConstants.fontSizeSm, color: Colors.white)),
              const Icon(Icons.arrow_drop_down, size: 16, color: Colors.white),
            ]),
          ),
        ),
      ),
    ]);
  }

  Widget _buildFiltersRow(bool isDarkTheme) {
    final textStyle = TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm);
    final hintStyle = TextStyle(color: UIConstants.textHint(isDarkTheme), fontSize: UIConstants.fontSizeSm);
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius)),
      contentPadding: UIConstants.textFieldContentPadding,
      isDense: true,
    );

    return Row(children: [
      SizedBox(
        width: 250,
        height: UIConstants.buttonHeightStandard,
        child: TextField(
          controller: _searchController,
          style: textStyle,
          decoration: inputDecoration.copyWith(
            hintText: 'Search by investor ID...',
            hintStyle: hintStyle,
            prefixIcon: Icon(Icons.search, size: 16, color: UIConstants.textHint(isDarkTheme)),
            prefixIconConstraints: const BoxConstraints(minWidth: 32),
          ),
          onSubmitted: (_) => _applyFilters(),
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
        height: _commandButtonHeight,
        child: TextButton(
          onPressed: _resetFilters,
          child: Text('Reset', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
        ),
      ),
    ]);
  }

  Widget _buildTable(bool isDarkTheme) {
    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: const [
        StyledColumn(label: 'IID', flex: 2),
        StyledColumn(label: 'External Investor ID', flex: 2),
        StyledColumn(label: 'Status', flex: 1),
        StyledColumn(label: 'Types', flex: 2),
        StyledColumn(label: 'Display Names', flex: 2),
        StyledColumn(label: 'Labels', flex: 2),
        StyledColumn(label: 'Tags', flex: 2),
        StyledColumn(label: 'Metadata', flex: 3),
      ],
      rows: _investors.asMap().entries.map((entry) {
        final idx = entry.key;
        final inv = entry.value;
        final status = _str(inv, 'investorStatus');
        return StyledRow(
          selected: _selectedRowIndex == idx,
          onTap: () => setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx),
          cells: [
            _copyableCell(_str(inv, 'iid'), isDarkTheme),
            _copyableCell(_str(inv, 'externalInvestorId'), isDarkTheme),
            _statusBadge(status, isDarkTheme),
            _copyableCell(_str(inv, 'types'), isDarkTheme),
            _copyableCell(_str(inv, 'displayNames'), isDarkTheme),
            _copyableCell(_str(inv, 'labels'), isDarkTheme),
            _copyableCell(_str(inv, 'tags'), isDarkTheme),
            _copyableCell(_str(inv, 'metadata'), isDarkTheme),
          ],
        );
      }).toList(),
      rowsPerPage: _pageSize,
      currentPage: _currentPage,
      totalPages: _totalPages,
      onPageChanged: _goToPage,
    );
  }

  static const int _truncateThreshold = 20;

  String _truncate(String value, [int maxLen = _truncateThreshold]) {
    if (value == '-') return value;
    if (value.startsWith('0x') && value.length > 14) {
      return '${value.substring(0, 6)}...${value.substring(value.length - 4)}';
    }
    if (value.length <= maxLen) return value;
    final keep = (maxLen - 3) ~/ 2;
    return '${value.substring(0, keep)}...${value.substring(value.length - keep)}';
  }

  Widget _copyableCell(String value, bool isDarkTheme, {bool noTruncate = false}) {
    final display = noTruncate ? value : _truncate(value);
    final needsTooltip = display != value;
    return Tooltip(
      message: needsTooltip ? value : '',
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(value),
        child: Text(display,
          style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _statusBadge(String status, bool isDarkTheme) {
    final s = status.toUpperCase();
    Color color;
    if (s.contains('ACTIVE') || s.contains('REGISTERED')) {
      color = UIConstants.colorAccept;
    } else if (s.contains('PENDING')) {
      color = Colors.blue;
    } else if (s.contains('SUSPENDED') || s.contains('BLOCKED')) {
      color = Colors.red;
    } else if (s.contains('UNKNOWN')) {
      color = UIConstants.textHint(isDarkTheme);
    } else {
      color = UIConstants.textSecondary(isDarkTheme);
    }
    return Tooltip(
      message: status,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(status),
        child: Text(s, style: TextStyle(color: color, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
