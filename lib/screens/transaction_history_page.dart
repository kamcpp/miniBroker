import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../utils/menu_items_helper.dart';
import '../config/app_config.dart';
import '../config/ui_constants.dart';
import '../widgets/base_page.dart';
import '../widgets/styled_data_table.dart';
import '../generated/prtagent/v1/investor.pbgrpc.dart';
import '../generated/common.pb.dart' as common_pb;
import '../generated/fin/trading.pb.dart' as fin_pb;
import '../services/page_state_service.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  // Data
  List<fin_pb.Transaction> _transactions = [];
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
  final _assetFilterController = TextEditingController();

  static const _pageId = 'transaction_history';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'search': _searchController.text,
      'assetFilter': _assetFilterController.text,
      'currentPage': _currentPage,
      'pageSize': _pageSize,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _searchController.text = state['search'] ?? '';
      _assetFilterController.text = state['assetFilter'] ?? '';
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 20;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTransactions();
    });
  }

  @override
  void dispose() {
    _saveState();
    _searchController.dispose();
    _assetFilterController.dispose();
    super.dispose();
  }

  Future<void> _fetchTransactions() async {
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

      final authService = Provider.of<AuthService>(context, listen: false);
      final investorId = authService.username;

      final request = GetInvestorTransactionsRequest(
        proposedExecutionId: 'get_investor_transactions_${DateTime.now().millisecondsSinceEpoch}',
        investorIid: investorId,
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
      );

      // Apply optional asset filter
      final assetFilter = _assetFilterController.text.trim();
      if (assetFilter.isNotEmpty) {
        request.assetIds.add(assetFilter);
      }

      print('[TransactionHistory] Calling InvestorService.GetInvestorTransactions via native gRPC');
      final response = await client.getInvestorTransactions(request, options: callOptions);

      if (!mounted) return;

      final transactions = response.transactions;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0
          ? (totalCount / _pageSize).ceil().clamp(1, 999999)
          : (transactions.length == _pageSize ? _currentPage + 1 : _currentPage);

      print('[TransactionHistory] Got ${transactions.length} transactions, totalCount=$totalCount, totalPages=$totalPages');

      setState(() {
        _transactions = transactions.toList();
        _totalCount = totalCount > 0 ? totalCount : transactions.length;
        _totalPages = totalPages;
        _isLoading = false;
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      print('[TransactionHistory] gRPC error: code=${e.code}, message=${e.message}');
      setState(() {
        _errorMessage = 'gRPC error ${e.code}: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      print('[TransactionHistory] Error: $e');
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
    _fetchTransactions();
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
    });
    _fetchTransactions();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _assetFilterController.clear();
      _currentPage = 1;
    });
    _fetchTransactions();
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

  /// Clean the TRANSACTION_TYPE_ENUM_ prefix from the enum name
  String _cleanTransactionType(fin_pb.TransactionTypeEnum type) {
    final name = type.name;
    const prefix = 'TRANSACTION_TYPE_ENUM_';
    if (name.startsWith(prefix)) {
      return name.substring(prefix.length);
    }
    return name;
  }

  /// Format a proto timestamp (common.Time) to a readable string
  String _formatTimestamp(dynamic timestamp) {
    try {
      final millis = timestamp.utcUnixEpochTsMillis;
      if (millis == null || millis.toString().isEmpty || millis.toString() == '0') {
        return timestamp.toString().isNotEmpty ? timestamp.toString() : '-';
      }
      final ms = int.tryParse(millis.toString());
      if (ms != null && ms > 0) {
        final dt = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
        return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
            '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
      }
      return millis.toString();
    } catch (_) {
      return timestamp.toString().isNotEmpty ? timestamp.toString() : '-';
    }
  }

  String _safeStr(String value) {
    if (value.isEmpty) return '-';
    // Replace zero addresses with N/A
    if (value.startsWith('0x') && value.replaceAll('0', '').replaceAll('x', '').isEmpty) return 'N/A';
    return value;
  }

  /// Descale an amount using divisibility (e.g., 45000 with divis 2 = 450.00)
  String _descaleAmount(String rawAmount, String assetIid) {
    if (rawAmount == '-' || rawAmount.isEmpty) return '-';
    final raw = int.tryParse(rawAmount);
    if (raw == null) return rawAmount;
    // Try to determine divisibility from asset name
    final divis = _guessDivisibility(assetIid);
    if (divis == 0) return rawAmount;
    final divisor = List.generate(divis, (_) => 10).fold<int>(1, (a, b) => a * b);
    return (raw / divisor).toStringAsFixed(divis);
  }

  int _guessDivisibility(String assetIid) {
    final upper = assetIid.toUpperCase();
    if (upper.contains('EUR') || upper.contains('USD') || upper.contains('GBP') || upper.contains('CHF')) return 2;
    if (upper.contains('JPY') || upper.contains('KRW')) return 0;
    if (upper.contains('BHD') || upper.contains('KWD') || upper.contains('OMR')) return 3;
    return 2; // default
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

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;
    final backgroundColor = UIConstants.pageBackground(isDarkTheme);

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'transaction_history'),
      content: Container(
        color: backgroundColor,
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title row
            _buildTitleRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),

            // Filters
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
                                  child: SelectableText(
                                    _errorMessage!,
                                    style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: UIConstants.spacingMd),
                              SizedBox(
                                height: UIConstants.buttonHeightStandard * 0.7,
                                child: ElevatedButton(
                                  onPressed: _fetchTransactions,
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
          'Transaction History',
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
            onPressed: _isLoading ? null : _fetchTransactions,
            icon: const Icon(Icons.refresh, size: 16),
            label: Text('Refresh', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)),
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
          width: 180,
          height: UIConstants.buttonHeightStandard * 0.7,
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
          width: 150,
          height: UIConstants.buttonHeightStandard * 0.7,
          child: TextField(
            controller: _assetFilterController,
            style: textStyle,
            decoration: inputDecoration.copyWith(
              hintText: 'Asset filter',
              hintStyle: hintStyle,
            ),
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
    if (_transactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions found.',
          style: TextStyle(
            color: UIConstants.textSecondary(isDarkTheme),
            fontSize: UIConstants.fontSizeSm,
          ),
        ),
      );
    }

    return _buildTransactionsTable(isDarkTheme);
  }

  Widget _buildTransactionsTable(bool isDarkTheme) {
    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: [
        StyledColumn(label: 'ID', flex: 1),
        StyledColumn(label: 'Type', flex: 2),
        StyledColumn(label: 'Operation', flex: 1),
        StyledColumn(label: 'Account', flex: 2),
        StyledColumn(label: 'From', flex: 2),
        StyledColumn(label: 'To', flex: 2),
        StyledColumn(label: 'Asset', flex: 2),
        StyledColumn(label: 'Amount', flex: 2),
        StyledColumn(label: 'Reference', flex: 2),
        StyledColumn(label: 'Ref Type', flex: 1),
        StyledColumn(label: 'Timestamp', flex: 2),
      ],
      rows: _transactions.asMap().entries.map((entry) {
        final idx = entry.key;
        final tx = entry.value;

        final transactionId = _safeStr(tx.transactionId);
        final type = _cleanTransactionType(tx.type);
        final operation = _safeStr(tx.operation);
        final accountIid = _safeStr(tx.accountIid);
        final fromAccountIid = _safeStr(tx.fromAccountIid);
        final toAccountIid = _safeStr(tx.toAccountIid);
        final assetIid = _safeStr(tx.assetIid);
        final amount = _descaleAmount(tx.amount, tx.assetIid);
        final referenceId = _safeStr(tx.referenceId);
        final referenceType = _safeStr(tx.referenceType);
        final timestamp = _formatTimestamp(tx.timestamp);

        return StyledRow(
          selected: _selectedRowIndex == idx,
          onTap: () {
            setState(() => _selectedRowIndex = _selectedRowIndex == idx ? null : idx);
          },
          cells: [
            _copyableCell(transactionId, isDarkTheme),
            _typeBadgeCell(type, isDarkTheme),
            _copyableCell(operation, isDarkTheme),
            _copyableCell(accountIid, isDarkTheme),
            _copyableCell(fromAccountIid, isDarkTheme),
            _copyableCell(toAccountIid, isDarkTheme),
            _copyableCell(assetIid, isDarkTheme),
            _amountCell(amount, isDarkTheme),
            _copyableCell(referenceId, isDarkTheme),
            _copyableCell(referenceType, isDarkTheme),
            _copyableCell(timestamp, isDarkTheme, noTruncate: true),
          ],
        );
      }).toList(),
      rowsPerPage: _pageSize,
      currentPage: _currentPage,
      totalPages: _totalPages,
      onPageChanged: _goToPage,
    );
  }

  Widget _copyableCell(String value, bool isDarkTheme, {Color? textColor, bool noTruncate = false}) {
    final display = noTruncate ? value : _truncate(value);
    final needsTooltip = display != value;

    return Tooltip(
      message: needsTooltip ? value : '',
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(value),
        child: Text(
          display,
          style: TextStyle(
            color: textColor ?? UIConstants.textPrimary(isDarkTheme),
            fontSize: UIConstants.fontSizeSm,
            fontWeight: textColor != null ? FontWeight.w600 : null,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  /// Type badge with color coding based on transaction type
  Widget _typeBadgeCell(String type, bool isDarkTheme) {
    final upper = type.toUpperCase();

    Color bgColor;
    if (upper.contains('DEPOSIT')) {
      bgColor = UIConstants.colorAccept;
    } else if (upper.contains('WITHDRAW')) {
      bgColor = Colors.red;
    } else if (upper.contains('BUY')) {
      bgColor = Colors.blue;
    } else if (upper.contains('SELL')) {
      bgColor = Colors.orange;
    } else if (upper.contains('FEE')) {
      bgColor = Colors.purple;
    } else if (upper.contains('SETTLEMENT')) {
      bgColor = Colors.teal;
    } else if (upper.contains('TRANSFER')) {
      bgColor = Colors.cyan;
    } else {
      bgColor = UIConstants.textHint(isDarkTheme);
    }

    return Tooltip(
      message: type,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(type),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: bgColor, width: 0.5),
          ),
          child: Text(
            type,
            style: TextStyle(color: bgColor, fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  /// Amount cell with color (green for positive, red for negative)
  Widget _amountCell(String rawAmount, bool isDarkTheme) {
    if (rawAmount == '-') return _copyableCell(rawAmount, isDarkTheme);
    try {
      final value = double.parse(rawAmount);
      final color = value >= 0 ? UIConstants.colorAccept : Colors.red;
      return _copyableCell(rawAmount, isDarkTheme, textColor: color);
    } catch (_) {
      return _copyableCell(rawAmount, isDarkTheme);
    }
  }
}
