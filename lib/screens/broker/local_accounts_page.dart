import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as xl;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import '../../services/theme_service.dart';
import '../../services/database_helper.dart';
import '../../services/grpc_helper.dart';
import '../../services/user_sync_service.dart';
import '../../utils/menu_items_helper.dart';
import '../../config/ui_constants.dart';
import '../../widgets/base_page.dart';
import '../../widgets/styled_data_table.dart';
import '../../services/page_state_service.dart';

class LocalAccountsPage extends StatefulWidget {
  const LocalAccountsPage({super.key});

  @override
  State<LocalAccountsPage> createState() => _LocalAccountsPageState();
}

class _LocalAccountsPageState extends State<LocalAccountsPage> {
  static const double _commandButtonHeight = UIConstants.buttonHeightStandard * 0.7;

  // Data
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _filteredUsers = [];
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
  String _sortBy = 'username';
  String _sortDirection = 'asc';

  // Services
  final _userSyncService = UserSyncService();
  final _databaseHelper = DatabaseHelper();

  static const _sortByOptions = <String, String>{
    '': 'Default',
    'username': 'Username',
    'created_at': 'Created At',
    'last_login': 'Last Login',
  };

  static const _pageId = 'local_accounts';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'search': _searchController.text,
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
      _sortBy = state['sortBy'] ?? 'username';
      _sortDirection = state['sortDirection'] ?? 'asc';
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 20;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUsers();
    });
  }

  @override
  void dispose() {
    _saveState();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final users = await _userSyncService.getSynchronizedUsers();

      if (!mounted) return;

      setState(() {
        _users = users;
        _applyLocalFilters();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _applyLocalFilters() {
    var filtered = List<Map<String, dynamic>>.from(_users);

    // Search filter
    final search = _searchController.text.trim().toLowerCase();
    if (search.isNotEmpty) {
      filtered = filtered.where((u) {
        final username = (u['username'] ?? '').toString().toLowerCase();
        final id = (u['id'] ?? '').toString();
        return username.contains(search) || id.contains(search);
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      int cmp;
      switch (_sortBy) {
        case 'created_at':
          cmp = _compareValues(a['created_at'], b['created_at']);
          break;
        case 'last_login':
          cmp = _compareValues(a['last_login'], b['last_login']);
          break;
        case 'username':
        default:
          cmp = (a['username'] ?? '').toString().compareTo((b['username'] ?? '').toString());
          break;
      }
      return _sortDirection == 'desc' ? -cmp : cmp;
    });

    _totalCount = filtered.length;
    _totalPages = (_totalCount / _pageSize).ceil().clamp(1, 999999);
    if (_currentPage > _totalPages) _currentPage = 1;

    // Paginate
    final start = (_currentPage - 1) * _pageSize;
    final end = (start + _pageSize).clamp(0, filtered.length);
    _filteredUsers = filtered.sublist(start, end);
  }

  int _compareValues(dynamic a, dynamic b) {
    if (a == null && b == null) return 0;
    if (a == null) return -1;
    if (b == null) return 1;
    return a.toString().compareTo(b.toString());
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() {
      _currentPage = page;
      _applyLocalFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
      _applyLocalFilters();
    });
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _sortBy = 'username';
      _sortDirection = 'asc';
      _currentPage = 1;
      _applyLocalFilters();
    });
  }

  DateTime? _parseUnixTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    int? unixTime;
    if (timestamp is int) {
      unixTime = timestamp;
    } else if (timestamp is String) {
      unixTime = int.tryParse(timestamp);
    }
    if (unixTime != null) {
      return DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    }
    if (timestamp is String) {
      return DateTime.tryParse(timestamp);
    }
    return null;
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  // ---- Change Password ----

  Future<void> _showChangePasswordDialog(String username) async {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        final themeService = Provider.of<ThemeService>(context);
        final isDark = themeService.isDarkTheme;
        return AlertDialog(
          backgroundColor: UIConstants.cardBackground(isDark),
          title: Text(
            'Change Password',
            style: TextStyle(color: UIConstants.textPrimary(isDark)),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'User: $username',
                  style: TextStyle(
                    color: UIConstants.textSecondary(isDark),
                    fontSize: UIConstants.fontSizeSm,
                  ),
                ),
                SizedBox(height: UIConstants.spacingMd),
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  style: TextStyle(color: UIConstants.textPrimary(isDark)),
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: UIConstants.textHint(isDark)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    if (value.length < 4) return 'At least 4 characters';
                    return null;
                  },
                ),
                SizedBox(height: UIConstants.spacingSm),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  style: TextStyle(color: UIConstants.textPrimary(isDark)),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: UIConstants.textHint(isDark)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value != newPasswordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel', style: TextStyle(color: UIConstants.textSecondary(isDark))),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(true);
                }
              },
              style: UIConstants.buttonStyle(UIConstants.commandColor(isDark)),
              child: const Text('Change'),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      final success = await _databaseHelper.updateUserPassword(
        username,
        newPasswordController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Password changed for "$username"' : 'Failed to change password',
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            width: 300,
          ),
        );
      }
    }

    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  // ---- Investor Info Dialog ----

  Future<void> _showInvestorInfoDialog(String username, bool isDarkTheme) async {
    showDialog(
      context: context,
      builder: (context) => _InvestorInfoDialog(
        investorId: username,
        isDarkTheme: isDarkTheme,
        onCopy: _copyToClipboard,
      ),
    );
  }

  // ---- Export ----

  static const _exportColumns = [
    'id', 'username', 'created_at', 'last_login',
  ];

  static const _exportHeaders = [
    'ID', 'Username', 'Created At', 'Last Login',
  ];

  String _exportValue(Map<String, dynamic> user, String col) {
    if (col == 'created_at' || col == 'last_login') {
      return _formatDate(_parseUnixTimestamp(user[col]));
    }
    final val = user[col];
    if (val == null) return '-';
    return val.toString().isEmpty ? '-' : val.toString();
  }

  Future<void> _exportUsers(String format) async {
    if (_users.isEmpty) return;

    try {
      setState(() => _isLoading = true);

      // Export all users matching current filters (not just current page)
      var data = List<Map<String, dynamic>>.from(_users);
      final search = _searchController.text.trim().toLowerCase();
      if (search.isNotEmpty) {
        data = data.where((u) {
          final username = (u['username'] ?? '').toString().toLowerCase();
          final id = (u['id'] ?? '').toString();
          return username.contains(search) || id.contains(search);
        }).toList();
      }
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (data.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No users to export')),
          );
        }
        return;
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final defaultName = 'local_accounts_$timestamp';

      switch (format) {
        case 'csv':
          await _exportCSV(defaultName, data);
          break;
        case 'json':
          await _exportJSON(defaultName, data);
          break;
        case 'excel':
          await _exportExcel(defaultName, data);
          break;
        case 'pdf':
          await _exportPDF(defaultName, data);
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
    for (final user in data) {
      rows.add(_exportColumns.map((col) => _exportValue(user, col)).toList());
    }
    return rows;
  }

  Future<String?> _pickSaveLocation(String defaultName, String extension) async {
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Local Accounts',
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
    final jsonList = data.map((user) {
      final map = <String, String>{};
      for (int i = 0; i < _exportColumns.length; i++) {
        map[_exportHeaders[i]] = _exportValue(user, _exportColumns[i]);
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
    final sheet = excel['Local Accounts'];
    excel.delete('Sheet1');
    for (int i = 0; i < _exportHeaders.length; i++) {
      sheet.cell(xl.CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = xl.TextCellValue(_exportHeaders[i]);
    }
    for (int r = 0; r < data.length; r++) {
      for (int c = 0; c < _exportColumns.length; c++) {
        sheet.cell(xl.CellIndex.indexByColumnRow(columnIndex: c, rowIndex: r + 1)).value =
            xl.TextCellValue(_exportValue(data[r], _exportColumns[c]));
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
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(20),
        header: (context) => pw.Text(
          'Local Accounts - Exported ${DateTime.now().toIso8601String().split('T').first} (${data.length} records)',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 7),
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
        content: Text('Exported $count local accounts to: $path', style: const TextStyle(fontSize: 12)),
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

  // ---- Build ----

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;
    final backgroundColor = UIConstants.pageBackground(isDarkTheme);

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'local_accounts'),
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
                              SizedBox(height: UIConstants.spacingMd),
                              SizedBox(
                                height: _commandButtonHeight,
                                child: ElevatedButton(
                                  onPressed: _fetchUsers,
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
          'Local Accounts',
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
            onPressed: _isLoading ? null : _fetchUsers,
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
            onSelected: _users.isEmpty ? null : (format) => _exportUsers(format),
            enabled: _users.isNotEmpty,
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
          width: 200,
          height: UIConstants.buttonHeightStandard,
          child: TextField(
            controller: _searchController,
            style: textStyle,
            decoration: inputDecoration.copyWith(
              hintText: 'Search username...',
              hintStyle: hintStyle,
              prefixIcon: Icon(Icons.search, size: 16, color: UIConstants.textHint(isDarkTheme)),
              prefixIconConstraints: const BoxConstraints(minWidth: 32),
            ),
            onSubmitted: (_) => _applyFilters(),
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
            onChanged: (value) => setState(() => _sortBy = value ?? 'username'),
          ),
        ),
        SizedBox(width: UIConstants.spacingXs),
        SizedBox(
          height: _commandButtonHeight,
          child: IconButton(
            icon: Icon(
              _sortDirection == 'asc' ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
              color: UIConstants.textPrimary(isDarkTheme),
            ),
            onPressed: () => setState(() => _sortDirection = _sortDirection == 'asc' ? 'desc' : 'asc'),
            tooltip: _sortDirection == 'asc' ? 'Ascending' : 'Descending',
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 32, minHeight: _commandButtonHeight),
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
      ],
    );
  }

  Widget _buildContent(bool isDarkTheme) {
    if (_filteredUsers.isEmpty) {
      return Center(
        child: Text(
          'No local accounts found.',
          style: TextStyle(
            color: UIConstants.textSecondary(isDarkTheme),
            fontSize: UIConstants.fontSizeSm,
          ),
        ),
      );
    }

    return _buildUsersTable(isDarkTheme);
  }

  Widget _buildUsersTable(bool isDarkTheme) {
    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: [
        StyledColumn(label: 'ID', flex: 1),
        StyledColumn(label: 'Username', flex: 2),
        StyledColumn(label: 'Created At', flex: 2),
        StyledColumn(label: 'Last Login', flex: 2),
        StyledColumn(label: 'Actions', flex: 1),
      ],
      rows: _filteredUsers.asMap().entries.map((entry) {
        final idx = entry.key;
        final user = entry.value;
        final username = (user['username'] ?? '-').toString();
        final id = (user['id'] ?? '-').toString();
        final createdAt = _formatDate(_parseUnixTimestamp(user['created_at']));
        final lastLogin = _formatDate(_parseUnixTimestamp(user['last_login']));

        return StyledRow(
          onTap: () {
            setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx);
          },
          selected: _selectedRowIndex == idx,
          cells: [
            _copyableCell(id, isDarkTheme),
            _copyableCell(username, isDarkTheme),
            _copyableCell(createdAt, isDarkTheme, noTruncate: true),
            _copyableCell(lastLogin, isDarkTheme, noTruncate: true),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Investor Info',
                  child: InkWell(
                    onTap: () => _showInvestorInfoDialog(username, isDarkTheme),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.info_outline, size: 18, color: UIConstants.commandColor(isDarkTheme)),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Tooltip(
                  message: 'Change Password',
                  child: InkWell(
                    onTap: () => _showChangePasswordDialog(username),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.lock_reset, size: 18, color: UIConstants.commandColor(isDarkTheme)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }).toList(),
      rowsPerPage: _pageSize,
      currentPage: _currentPage,
      totalPages: _totalPages,
      onPageChanged: _goToPage,
    );
  }

  static const double _defaultMaxCellWidth = 200;
  static const int _truncateThreshold = 25;

  String _truncate(String value, [int maxLen = _truncateThreshold]) {
    if (value.length <= maxLen || value == '-') return value;
    final keep = (maxLen - 3) ~/ 2;
    return '${value.substring(0, keep)}...${value.substring(value.length - keep)}';
  }

  Widget _copyableCell(String value, bool isDarkTheme, {double maxWidth = _defaultMaxCellWidth, bool noTruncate = false}) {
    final display = noTruncate ? value : _truncate(value);
    final needsTooltip = display != value;
    final child = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(
        display,
        style: StyledDataTable.cellStyle(isDarkTheme),
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

}

/// Dialog that fetches and displays investor info from prtagent
class _InvestorInfoDialog extends StatefulWidget {
  final String investorId;
  final bool isDarkTheme;
  final void Function(String) onCopy;

  const _InvestorInfoDialog({
    required this.investorId,
    required this.isDarkTheme,
    required this.onCopy,
  });

  @override
  State<_InvestorInfoDialog> createState() => _InvestorInfoDialogState();
}

class _InvestorInfoDialogState extends State<_InvestorInfoDialog> {
  Map<String, dynamic>? _data;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  Future<void> _fetchInfo() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await GrpcHelper.getInvestorInfoBatch(
        externalInvestorIds: [widget.investorId],
      ).timeout(
        const Duration(minutes: 2),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _data = result['output'] as Map<String, dynamic>? ?? {};
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = result['output']?['error']?.toString() ?? 'Could not retrieve investor info';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not retrieve investor info: $e';
        _isLoading = false;
      });
    }
  }

  void _copyToClipboard(String value) {
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
    final isDark = widget.isDarkTheme;
    final textColor = UIConstants.textPrimary(isDark);
    final labelColor = UIConstants.textSecondary(isDark);
    final cardColor = UIConstants.cardBackground(isDark);

    return AlertDialog(
      backgroundColor: UIConstants.cardBackground(isDark),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Investor: ${widget.investorId}',
              style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeMd),
            ),
          ),
          IconButton(
            icon: Icon(Icons.refresh, size: 18, color: labelColor),
            onPressed: _isLoading ? null : _fetchInfo,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: Icon(Icons.close, size: 18, color: labelColor),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close',
          ),
        ],
      ),
      content: SizedBox(
        width: 600,
        height: 500,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, size: 36, color: Colors.orange),
                        SizedBox(height: UIConstants.spacingSm),
                        Tooltip(
                          message: 'Click to copy',
                          child: InkWell(
                            onTap: () => _copyToClipboard(_error!),
                            child: SelectableText(
                              _error!,
                              style: TextStyle(color: Colors.orange, fontSize: UIConstants.fontSizeSm),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: _buildContent(isDark, textColor, labelColor, cardColor),
                  ),
      ),
    );
  }

  Widget _buildContent(bool isDark, Color textColor, Color labelColor, Color cardColor) {
    if (_data == null) {
      return Text('No data', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm));
    }

    final investorInfos = _data!['investorInfos'] as List<dynamic>? ??
        _data!['investor_infos'] as List<dynamic>? ??
        _data!['investors'] as List<dynamic>? ?? [];
    final responseFields = Map<String, dynamic>.from(_data!);
    responseFields.remove('investorInfos');
    responseFields.remove('investor_infos');
    responseFields.remove('investors');

    final widgets = <Widget>[];

    // Response-level fields
    if (responseFields.isNotEmpty) {
      widgets.add(
        Container(
          width: double.infinity,
          padding: UIConstants.paddingStandard,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: UIConstants.borderColor(isDark)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Response Details', style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.bold)),
              SizedBox(height: UIConstants.spacingXs),
              ..._buildDynamicFields(responseFields, labelColor, textColor, isDark),
            ],
          ),
        ),
      );
      widgets.add(SizedBox(height: UIConstants.spacingSm));
    }

    // Investor data
    if (investorInfos.isEmpty) {
      widgets.add(Text('No investor found in response', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm)));
    } else {
      for (var i = 0; i < investorInfos.length; i++) {
        final entry = _safeMap(investorInfos[i]);
        final title = investorInfos.length == 1 ? 'Investor Information' : 'Investor [${i + 1}]';
        widgets.add(
          Container(
            width: double.infinity,
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: UIConstants.borderColor(isDark)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.bold)),
                SizedBox(height: UIConstants.spacingSm),
                ..._buildDynamicFields(entry, labelColor, textColor, isDark),
              ],
            ),
          ),
        );
        if (i < investorInfos.length - 1) {
          widgets.add(SizedBox(height: UIConstants.spacingSm));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// Recursively render all fields from a dynamic JSON object
  List<Widget> _buildDynamicFields(
    Map<String, dynamic> data,
    Color labelColor,
    Color textColor,
    bool isDark, {
    String prefix = '',
  }) {
    final widgets = <Widget>[];

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      final displayKey = _formatFieldName(key);
      final fullLabel = prefix.isNotEmpty ? '$prefix > $displayKey' : displayKey;

      if (value == null) continue;

      if (value is String || value is num || value is bool) {
        if (value is String && value.trimLeft().startsWith('{')) {
          try {
            final parsed = jsonDecode(value);
            if (parsed is Map<String, dynamic>) {
              widgets.add(
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: _buildNestedSection(fullLabel, parsed, labelColor, textColor, isDark),
                ),
              );
              continue;
            }
          } catch (_) {}
        }
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: _infoField(fullLabel, value.toString(), labelColor, textColor),
          ),
        );
      } else if (value is List) {
        if (value.isEmpty) continue;
        if (value.first is Map) {
          for (var i = 0; i < value.length; i++) {
            final item = _safeMap(value[i]);
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: _buildNestedSection('$fullLabel [${i + 1}]', item, labelColor, textColor, isDark),
              ),
            );
          }
        } else {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: _infoField(fullLabel, value.map((e) => e.toString()).join(', '), labelColor, textColor),
            ),
          );
        }
      } else if (value is Map) {
        final map = _safeMap(value);
        if (map.isEmpty) continue;
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: _buildNestedSection(fullLabel, map, labelColor, textColor, isDark),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildNestedSection(
    String title,
    Map<String, dynamic> data,
    Color labelColor,
    Color textColor,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.bold)),
        SizedBox(height: UIConstants.spacingXs),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Wrap(
            spacing: UIConstants.spacingXl,
            runSpacing: UIConstants.spacingXs,
            children: data.entries.where((e) => e.value != null).map((e) {
              final v = e.value;
              if (v is Map) {
                return _buildNestedSection(_formatFieldName(e.key), _safeMap(v), labelColor, textColor, isDark);
              } else if (v is List) {
                if (v.isEmpty) return const SizedBox.shrink();
                if (v.first is Map) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < v.length; i++)
                        _buildNestedSection('${_formatFieldName(e.key)} [${i + 1}]', _safeMap(v[i]), labelColor, textColor, isDark),
                    ],
                  );
                }
                return _infoField(_formatFieldName(e.key), v.map((x) => x.toString()).join(', '), labelColor, textColor);
              }
              if (v is String && v.trimLeft().startsWith('{')) {
                try {
                  final parsed = jsonDecode(v);
                  if (parsed is Map<String, dynamic>) {
                    return _buildNestedSection(_formatFieldName(e.key), parsed, labelColor, textColor, isDark);
                  }
                } catch (_) {}
              }
              return _infoField(_formatFieldName(e.key), v.toString(), labelColor, textColor);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _safeMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return value.map((k, v) => MapEntry(k.toString(), v));
    return {};
  }

  String _formatFieldName(String name) {
    var result = name.replaceAllMapped(RegExp(r'_([a-z])'), (m) => ' ${m.group(1)!.toUpperCase()}');
    result = result.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m.group(1)} ${m.group(2)}');
    if (result.isNotEmpty) {
      result = result[0].toUpperCase() + result.substring(1);
    }
    return result;
  }

  Widget _infoField(String label, String value, Color labelColor, Color textColor) {
    return InkWell(
      onTap: () => _copyToClipboard(value),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: labelColor, fontSize: 10)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.copy, size: 10, color: labelColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
