import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';
import '../../services/theme_service.dart';
import '../../utils/menu_items_helper.dart';
import '../../config/app_config.dart';
import '../../config/ui_constants.dart';
import '../../widgets/base_page.dart';
import '../../widgets/styled_data_table.dart';
import '../../generated/prtagent/v1/admin.pbgrpc.dart';
import '../../generated/prtagent/v1/admin.pb.dart' as saga_pb;
import '../../generated/common.pb.dart' as common_pb;
import '../../services/page_state_service.dart';


class WorkflowsPage extends StatefulWidget {
  const WorkflowsPage({super.key});

  @override
  State<WorkflowsPage> createState() => _WorkflowsPageState();
}

class _WorkflowsPageState extends State<WorkflowsPage> {
  static const double _commandButtonHeight = UIConstants.buttonHeightStandard * 0.7;

  // View modes
  static const String _viewList = 'list';
  static const String _viewDetail = 'detail';
  static const String _viewTree = 'tree';

  // Data
  List<saga_pb.SagaInstance> _sagas = [];
  saga_pb.SagaDetail? _selectedSagaDetail;
  saga_pb.SagaDetail? _sagaTree;
  List<saga_pb.SagaStepInstance> _orderedSteps = [];

  // Loading state
  bool _isLoading = false;
  String? _errorMessage;

  // View
  String _viewMode = _viewList;
  List<String> _breadcrumbs = []; // saga instance IDs for back navigation

  // Pagination
  int _currentPage = 1;
  int _pageSize = 35;
  int _totalPages = 1;

  // Filters
  final _stateFilterController = TextEditingController();
  final _templateFilterController = TextEditingController();
  final _submitterFilterController = TextEditingController();

  // Expanded step indices (for execution history)
  final Set<int> _expandedSteps = {};

  // Expanded tree nodes
  final Set<String> _expandedTreeNodes = {};

  // State color mapping
  static const _sagaStateColors = <String, Color>{
    'CREATED': Colors.grey,
    'PENDING': Colors.grey,
    'RUNNING': UIConstants.colorPrimary,
    'IN_PROGRESS': UIConstants.colorPrimary,
    'COMMITTED': UIConstants.colorAccept,
    'COMPLETED': UIConstants.colorAccept,
    'SUCCEEDED': UIConstants.colorAccept,
    'FAILED': UIConstants.colorReject,
    'COMPENSATING': UIConstants.colorWarning,
    'COMPENSATED': Color(0xFFE65100),
    'BLOCKED': Color(0xFFD84315),
    'CANCELLED': Color(0xFF757575),
  };

  static const _sagaStateIcons = <String, IconData>{
    'CREATED': Icons.schedule,
    'PENDING': Icons.schedule,
    'RUNNING': Icons.play_circle_outline,
    'IN_PROGRESS': Icons.play_circle_outline,
    'COMMITTED': Icons.check_circle_outline,
    'COMPLETED': Icons.check_circle_outline,
    'SUCCEEDED': Icons.check_circle_outline,
    'FAILED': Icons.error_outline,
    'COMPENSATING': Icons.undo,
    'COMPENSATED': Icons.undo,
    'BLOCKED': Icons.block,
    'CANCELLED': Icons.cancel_outlined,
  };

  static const _stateFilterOptions = <String, String>{
    '': 'All States',
    'CREATED': 'Created',
    'PENDING': 'Pending',
    'RUNNING': 'Running',
    'IN_PROGRESS': 'In Progress',
    'COMPLETED': 'Completed',
    'SUCCEEDED': 'Succeeded',
    'FAILED': 'Failed',
    'COMPENSATING': 'Compensating',
    'COMPENSATED': 'Compensated',
    'CANCELLED': 'Cancelled',
  };

  static const _pageId = 'workflows';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'stateFilter': _stateFilterController.text,
      'templateFilter': _templateFilterController.text,
      'submitterFilter': _submitterFilterController.text,
      'currentPage': _currentPage,
      'pageSize': _pageSize,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _stateFilterController.text = state['stateFilter'] ?? '';
      _templateFilterController.text = state['templateFilter'] ?? '';
      _submitterFilterController.text = state['submitterFilter'] ?? '';
      _currentPage = state['currentPage'] ?? 1;
      _pageSize = state['pageSize'] ?? 35;
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSagas();
    });
  }

  @override
  void dispose() {
    _saveState();
    _stateFilterController.dispose();
    _templateFilterController.dispose();
    _submitterFilterController.dispose();
    super.dispose();
  }

  // ============================================================================
  // gRPC calls
  // ============================================================================

  Future<ClientChannel> _createChannel() async {
    return ClientChannel(
      AppConfig.grpcHost,
      port: AppConfig.grpcPort,
      options: ChannelOptions(
        credentials: AppConfig.grpcUseSecure
            ? const ChannelCredentials.secure()
            : const ChannelCredentials.insecure(),
      ),
    );
  }

  CallOptions _callOptions() {
    return CallOptions(
      metadata: {
        if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty)
          'x-agora-participant-api-key': AppConfig.grpcApiKey!,
      },
      timeout: const Duration(minutes: 2),
    );
  }

  Future<void> _fetchSagas() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ClientChannel? channel;
    try {
      channel = await _createChannel();
      final client = AdminServiceClient(channel);

      final request = saga_pb.ListSagasRequest(
        proposedExecutionId: 'list_sagas_${DateTime.now().millisecondsSinceEpoch}',
        pagination: common_pb.PaginationParams(
          pageNr: _currentPage,
          pageSize: _pageSize,
        ),
      );

      // Apply filters
      final stateFilter = _stateFilterController.text.trim();
      if (stateFilter.isNotEmpty) request.state = stateFilter;
      final templateFilter = _templateFilterController.text.trim();
      if (templateFilter.isNotEmpty) request.sagaTemplateId = templateFilter;
      final submitterFilter = _submitterFilterController.text.trim();
      if (submitterFilter.isNotEmpty) request.sagaSubmitterId = submitterFilter;

      print('📋 [Workflows] Calling ListSagas page=$_currentPage, pageSize=$_pageSize');
      final response = await client.listSagas(request, options: _callOptions());

      if (!mounted) return;

      final sagas = response.sagas;
      final totalCount = response.paginationInfo.totalCount.toInt();
      final totalPages = totalCount > 0
          ? (totalCount / _pageSize).ceil().clamp(1, 999999)
          : (sagas.length == _pageSize ? _currentPage + 1 : _currentPage);

      print('📋 [Workflows] Got ${sagas.length} sagas, totalCount=$totalCount, totalPages=$totalPages');

      setState(() {
        _sagas = sagas;
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

  Future<void> _fetchSagaDetail(String sagaInstanceId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _expandedSteps.clear();
    });

    ClientChannel? channel;
    try {
      channel = await _createChannel();
      final client = AdminServiceClient(channel);

      final request = saga_pb.GetSagaRequest(
        proposedExecutionId: 'get_saga_${DateTime.now().millisecondsSinceEpoch}',
        sagaInstanceId: sagaInstanceId,
      );

      print('📋 [Workflows] Calling GetSaga id=$sagaInstanceId');
      final response = await client.getSaga(request, options: _callOptions());

      if (!mounted) return;

      setState(() {
        _selectedSagaDetail = response.saga;
        _orderedSteps = _orderSteps(response.saga.steps);
        _viewMode = _viewDetail;
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

  Future<void> _fetchSagaTree(String sagaInstanceId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _expandedTreeNodes.clear();
    });

    ClientChannel? channel;
    try {
      channel = await _createChannel();
      final client = AdminServiceClient(channel);

      final request = saga_pb.GetSagaTreeRequest(
        proposedExecutionId: 'get_saga_tree_${DateTime.now().millisecondsSinceEpoch}',
        sagaInstanceId: sagaInstanceId,
      );

      print('📋 [Workflows] Calling GetSagaTree id=$sagaInstanceId');
      final response = await client.getSagaTree(request, options: _callOptions());

      if (!mounted) return;

      setState(() {
        _sagaTree = response.saga;
        _expandedTreeNodes.add(response.saga.saga.instanceId);
        _viewMode = _viewTree;
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

  // ============================================================================
  // Step ordering
  // ============================================================================

  List<saga_pb.SagaStepInstance> _orderSteps(List<saga_pb.SagaStepInstance> steps) {
    if (steps.isEmpty) return [];

    final byId = <String, saga_pb.SagaStepInstance>{};
    for (final s in steps) {
      byId[s.instanceId] = s;
    }

    // Find head: step with no previous
    saga_pb.SagaStepInstance? head;
    for (final s in steps) {
      if (s.previousSagaStepInstanceId.isEmpty) {
        head = s;
        break;
      }
    }

    if (head == null) return steps; // fallback to original order

    final ordered = <saga_pb.SagaStepInstance>[head];
    var current = head;
    final visited = <String>{head.instanceId};
    while (current.nextSagaStepInstanceId.isNotEmpty) {
      final next = byId[current.nextSagaStepInstanceId];
      if (next == null || visited.contains(next.instanceId)) break;
      ordered.add(next);
      visited.add(next.instanceId);
      current = next;
    }

    // Add any steps not in the chain
    for (final s in steps) {
      if (!visited.contains(s.instanceId)) {
        ordered.add(s);
      }
    }

    return ordered;
  }

  // ============================================================================
  // Navigation
  // ============================================================================

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() => _currentPage = page);
    _fetchSagas();
  }

  void _applyFilters() {
    setState(() => _currentPage = 1);
    _fetchSagas();
  }

  void _resetFilters() {
    setState(() {
      _stateFilterController.clear();
      _templateFilterController.clear();
      _submitterFilterController.clear();
      _currentPage = 1;
    });
    _fetchSagas();
  }

  void _navigateToDetail(String sagaInstanceId) {
    if (_viewMode == _viewDetail && _selectedSagaDetail != null) {
      _breadcrumbs.add(_selectedSagaDetail!.saga.instanceId);
    }
    _fetchSagaDetail(sagaInstanceId);
  }

  void _navigateBack() {
    if (_breadcrumbs.isNotEmpty) {
      final prevId = _breadcrumbs.removeLast();
      _fetchSagaDetail(prevId);
    } else {
      setState(() {
        _viewMode = _viewList;
        _selectedSagaDetail = null;
        _sagaTree = null;
        _orderedSteps = [];
        _breadcrumbs = [];
      });
    }
  }

  void _navigateBackToDetail() {
    setState(() {
      _viewMode = _viewDetail;
      _sagaTree = null;
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      UIConstants.successSnackBar('Copied to clipboard'),
    );
  }

  // ============================================================================
  // Helpers
  // ============================================================================

  Color _stateColor(String state) {
    final cleaned = _cleanState(state).toUpperCase();
    return _sagaStateColors[cleaned] ?? Colors.grey;
  }

  IconData _stateIcon(String state) {
    final cleaned = _cleanState(state).toUpperCase();
    return _sagaStateIcons[cleaned] ?? Icons.help_outline;
  }

  String _formatTimestamp(int ts) {
    if (ts == 0) return '-';
    // Try both seconds and milliseconds
    final ms = ts > 9999999999 ? ts : ts * 1000;
    final dt = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true).toLocal();
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} ${_pad(dt.hour)}:${_pad(dt.minute)}:${_pad(dt.second)}';
  }

  String _formatTime(int ts) {
    if (ts == 0) return '-';
    final ms = ts > 9999999999 ? ts : ts * 1000;
    final dt = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true).toLocal();
    return '${_pad(dt.hour)}:${_pad(dt.minute)}:${_pad(dt.second)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  String _truncateId(String id, [int maxLen = 12]) {
    if (id.length <= maxLen) return id;
    return '${id.substring(0, maxLen)}...';
  }

  // ============================================================================
  // Build
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;
    final backgroundColor = UIConstants.pageBackground(isDarkTheme);

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'workflows'),
      content: Container(
        color: backgroundColor,
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleRow(isDarkTheme),
            SizedBox(height: UIConstants.spacingMd),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? _buildErrorView(isDarkTheme)
                      : _buildCurrentView(isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(bool isDarkTheme) {
    final title = _viewMode == _viewList
        ? 'Workflows'
        : _viewMode == _viewDetail
            ? 'Saga Detail'
            : 'Saga Tree';

    return Row(
      children: [
        if (_viewMode != _viewList) ...[
          InkWell(
            onTap: _viewMode == _viewTree ? _navigateBackToDetail : _navigateBack,
            child: Icon(Icons.arrow_back, color: UIConstants.textPrimary(isDarkTheme), size: UIConstants.iconSizeLg),
          ),
          SizedBox(width: UIConstants.spacingMd),
        ],
        Text(
          title,
          style: TextStyle(
            color: UIConstants.textPrimary(isDarkTheme),
            fontSize: UIConstants.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (_viewMode == _viewDetail && _breadcrumbs.isNotEmpty) ...[
          SizedBox(width: UIConstants.spacingMd),
          Text(
            '(depth: ${_breadcrumbs.length})',
            style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
          ),
        ],
        const Spacer(),
        if (_viewMode == _viewDetail && _selectedSagaDetail != null)
          SizedBox(
            height: _commandButtonHeight,
            child: ElevatedButton.icon(
              onPressed: () => _fetchSagaTree(_selectedSagaDetail!.saga.instanceId),
              style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
                minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
              ),
              icon: Icon(Icons.account_tree, size: UIConstants.iconSizeSm),
              label: Text('View Full Tree', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            ),
          ),
        if (_viewMode == _viewDetail)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SizedBox(
              height: _commandButtonHeight,
              child: ElevatedButton.icon(
                onPressed: () => _fetchSagaDetail(_selectedSagaDetail!.saga.instanceId),
                style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
                  minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
                ),
                icon: Icon(Icons.refresh, size: UIConstants.iconSizeSm),
                label: Text('Refresh', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorView(bool isDarkTheme) {
    return Center(
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
          SizedBox(height: UIConstants.spacingMd),
          SizedBox(
            height: _commandButtonHeight,
            child: ElevatedButton(
              onPressed: _viewMode == _viewList ? _fetchSagas : () => _fetchSagaDetail(_selectedSagaDetail?.saga.instanceId ?? ''),
              style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
                minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
              ),
              child: Text('Retry', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentView(bool isDarkTheme) {
    switch (_viewMode) {
      case _viewDetail:
        return _buildSagaDetailView(isDarkTheme);
      case _viewTree:
        return _buildSagaTreeView(isDarkTheme);
      default:
        return _buildSagaListView(isDarkTheme);
    }
  }

  // ============================================================================
  // View 1: Saga List
  // ============================================================================

  Widget _buildSagaListView(bool isDarkTheme) {
    return Column(
      children: [
        _buildFiltersRow(isDarkTheme),
        SizedBox(height: UIConstants.spacingMd),
        Expanded(child: _buildSagaTable(isDarkTheme)),
      ],
    );
  }

  Widget _buildFiltersRow(bool isDarkTheme) {
    String? selectedState = _stateFilterController.text.isEmpty ? '' : _stateFilterController.text;
    if (!_stateFilterOptions.containsKey(selectedState)) {
      selectedState = '';
    }

    return Container(
      padding: UIConstants.paddingCompact,
      decoration: BoxDecoration(
        color: UIConstants.filterBarBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
      ),
      child: Wrap(
        spacing: UIConstants.spacingMd,
        runSpacing: UIConstants.spacingXs,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // State dropdown
          SizedBox(
            width: 140,
            height: _commandButtonHeight,
            child: DropdownButtonFormField<String>(
              value: selectedState,
              items: _stateFilterOptions.entries.map((e) => DropdownMenuItem(
                value: e.key,
                child: Text(e.value, style: TextStyle(fontSize: UIConstants.fontSizeSm, color: UIConstants.textPrimary(isDarkTheme))),
              )).toList(),
              onChanged: (v) => setState(() => _stateFilterController.text = v ?? ''),
              decoration: UIConstants.appInputDecoration(isDark: isDarkTheme, hintText: 'State'),
              dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
              isDense: true,
              style: TextStyle(fontSize: UIConstants.fontSizeSm, color: UIConstants.textPrimary(isDarkTheme)),
            ),
          ),
          // Template ID
          SizedBox(
            width: 160,
            height: _commandButtonHeight,
            child: TextField(
              controller: _templateFilterController,
              style: TextStyle(fontSize: UIConstants.fontSizeSm, color: UIConstants.textPrimary(isDarkTheme)),
              decoration: UIConstants.appInputDecoration(isDark: isDarkTheme, hintText: 'Template ID'),
              onSubmitted: (_) => _applyFilters(),
            ),
          ),
          // Submitter ID
          SizedBox(
            width: 160,
            height: _commandButtonHeight,
            child: TextField(
              controller: _submitterFilterController,
              style: TextStyle(fontSize: UIConstants.fontSizeSm, color: UIConstants.textPrimary(isDarkTheme)),
              decoration: UIConstants.appInputDecoration(isDark: isDarkTheme, hintText: 'Submitter ID'),
              onSubmitted: (_) => _applyFilters(),
            ),
          ),
          // Fetch button
          SizedBox(
            height: _commandButtonHeight,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: UIConstants.buttonStyle(UIConstants.commandColor(isDarkTheme)).copyWith(
                minimumSize: WidgetStatePropertyAll(Size(0, _commandButtonHeight)),
              ),
              child: Text('Fetch', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            ),
          ),
          // Clear button
          SizedBox(
            height: _commandButtonHeight,
            child: TextButton(
              onPressed: _resetFilters,
              style: UIConstants.cancelTextButtonStyle(isDarkTheme),
              child: Text('Clear', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
            ),
          ),
        ],
      ),
    );
  }

  final Set<String> _expandedParents = {};

  Widget _buildSagaTable(bool isDarkTheme) {
    final cellStyle = StyledDataTable.cellStyle(isDarkTheme);
    final childStyle = cellStyle.copyWith(color: UIConstants.textSecondary(isDarkTheme));

    // Separate root sagas (depth 0) and children (depth > 0)
    final roots = <saga_pb.SagaInstance>[];
    final childrenByRoot = <String, List<saga_pb.SagaInstance>>{};

    for (final saga in _sagas) {
      if (saga.sagaDepth == 0) {
        roots.add(saga);
      } else {
        final rootId = saga.rootSagaInstanceId.isNotEmpty ? saga.rootSagaInstanceId : saga.instanceId;
        childrenByRoot.putIfAbsent(rootId, () => []).add(saga);
      }
    }

    // Sort roots descending by created time
    roots.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Build rows: parent, then its children if expanded
    final rows = <StyledRow>[];
    for (final root in roots) {
      final children = childrenByRoot[root.instanceId] ?? [];
      final hasChildren = children.isNotEmpty;
      final isExpanded = _expandedParents.contains(root.instanceId);

      // Parent row
      rows.add(StyledRow(
        onTap: () => _navigateToDetail(root.instanceId),
        cells: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasChildren)
                InkWell(
                  onTap: () => setState(() {
                    if (isExpanded) {
                      _expandedParents.remove(root.instanceId);
                    } else {
                      _expandedParents.add(root.instanceId);
                    }
                  }),
                  child: Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 16,
                    color: UIConstants.textSecondary(isDarkTheme),
                  ),
                )
              else
                SizedBox(width: 16),
              SizedBox(width: 4),
              Flexible(child: _copyableText(_truncateId(root.instanceId), root.instanceId, cellStyle, isDarkTheme)),
            ],
          ),
          _copyableText(root.sagaTemplateId, root.sagaTemplateId, cellStyle, isDarkTheme),
          _copyableText(_truncateId(root.sagaSubmitterId), root.sagaSubmitterId, cellStyle, isDarkTheme),
          _stateChip(root.state, compact: true),
          if (hasChildren)
            Text('${children.length}', style: TextStyle(color: UIConstants.colorPrimary, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w500))
          else
            Text('-', style: cellStyle),
          root.compensationReason.isNotEmpty
              ? _reasonCell(root.compensationReason, isDarkTheme)
              : Text('-', style: cellStyle),
          _copyableText(_formatTimestamp(root.createdAt.toInt()), _formatTimestamp(root.createdAt.toInt()), cellStyle, isDarkTheme),
          _copyableText(_formatTimestamp(root.updatedAt.toInt()), _formatTimestamp(root.updatedAt.toInt()), cellStyle, isDarkTheme),
        ],
      ));

      // Child rows (if expanded)
      if (isExpanded) {
        for (final child in children) {
          rows.add(StyledRow(
            onTap: () => _navigateToDetail(child.instanceId),
            cells: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.subdirectory_arrow_right, size: 12, color: UIConstants.textHint(isDarkTheme)),
                  SizedBox(width: 4),
                  Flexible(child: _copyableText(_truncateId(child.instanceId), child.instanceId, childStyle, isDarkTheme)),
                ],
              ),
              _copyableText(child.sagaTemplateId, child.sagaTemplateId, childStyle, isDarkTheme),
              _copyableText(_truncateId(child.sagaSubmitterId), child.sagaSubmitterId, childStyle, isDarkTheme),
              _stateChip(child.state, compact: true),
              Text('', style: childStyle),
              child.compensationReason.isNotEmpty
                  ? _reasonCell(child.compensationReason, isDarkTheme)
                  : Text('-', style: childStyle),
              _copyableText(_formatTimestamp(child.createdAt.toInt()), _formatTimestamp(child.createdAt.toInt()), childStyle, isDarkTheme),
              _copyableText(_formatTimestamp(child.updatedAt.toInt()), _formatTimestamp(child.updatedAt.toInt()), childStyle, isDarkTheme),
            ],
          ));
        }
      }
    }

    // Also show orphan children (depth > 0 but parent not in current page)
    for (final entry in childrenByRoot.entries) {
      if (!roots.any((r) => r.instanceId == entry.key)) {
        for (final child in entry.value) {
          rows.add(StyledRow(
            onTap: () => _navigateToDetail(child.instanceId),
            cells: [
              _copyableText(_truncateId(child.instanceId), child.instanceId, childStyle, isDarkTheme),
              _copyableText(child.sagaTemplateId, child.sagaTemplateId, childStyle, isDarkTheme),
              _copyableText(_truncateId(child.sagaSubmitterId), child.sagaSubmitterId, childStyle, isDarkTheme),
              _stateChip(child.state, compact: true),
              Text('', style: childStyle),
              child.compensationReason.isNotEmpty
                  ? _reasonCell(child.compensationReason, isDarkTheme)
                  : Text('-', style: childStyle),
              _copyableText(_formatTimestamp(child.createdAt.toInt()), _formatTimestamp(child.createdAt.toInt()), childStyle, isDarkTheme),
              _copyableText(_formatTimestamp(child.updatedAt.toInt()), _formatTimestamp(child.updatedAt.toInt()), childStyle, isDarkTheme),
            ],
          ));
        }
      }
    }

    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: const [
        StyledColumn(label: 'Instance ID', flex: 2),
        StyledColumn(label: 'Template', flex: 2),
        StyledColumn(label: 'Submitter', flex: 2),
        StyledColumn(label: 'State', flex: 1),
        StyledColumn(label: 'Children', flex: 1),
        StyledColumn(label: 'Reason', flex: 2),
        StyledColumn(label: 'Created', flex: 2),
        StyledColumn(label: 'Updated', flex: 2),
      ],
      rows: rows,
      rowsPerPage: _pageSize,
      onPageChanged: _goToPage,
      onPageSizeChanged: (newSize) {
        setState(() {
          _pageSize = newSize;
          _currentPage = 1;
        });
        _fetchSagas();
      },
      totalPages: _totalPages,
      currentPage: _currentPage,
    );
  }

  // ============================================================================
  // View 2: Saga Detail (Step Pipeline)
  // ============================================================================

  Widget _buildSagaDetailView(bool isDarkTheme) {
    final detail = _selectedSagaDetail;
    if (detail == null) return const SizedBox.shrink();

    final saga = detail.saga;
    final summary = detail.stepSummary;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saga info header
          _buildSagaInfoCard(saga, summary, isDarkTheme),
          SizedBox(height: UIConstants.spacingLg),

          // Input data
          ...[
            Text('Input', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.w500)),
            SizedBox(height: UIConstants.spacingMd),
            Container(
              width: double.infinity,
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: UIConstants.cardBackground(isDarkTheme),
                borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
                border: Border.all(color: UIConstants.borderColor(isDarkTheme)),
              ),
              child: InkWell(
                onTap: () => _copyToClipboard(saga.inputData),
                child: SelectableText(
                  saga.inputData.isNotEmpty ? saga.inputData : '{}',
                  style: TextStyle(
                    color: UIConstants.textPrimary(isDarkTheme),
                    fontSize: UIConstants.fontSizeSm,
                    fontFamily: 'monospace',
                    height: 1.4,
                  ),
                ),
              ),
            ),
            SizedBox(height: UIConstants.spacingLg),
          ],

          // Progress bar
          if (summary.total > 0) ...[
            _buildProgressBar(summary, isDarkTheme),
            SizedBox(height: UIConstants.spacingLg),
          ],

          // Step pipeline
          if (_orderedSteps.isNotEmpty) ...[
            Text('Steps', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.w500)),
            SizedBox(height: UIConstants.spacingMd),
            _buildStepPipeline(isDarkTheme),
          ],

          // Child sagas (from SagaDetail.childSagas, not the deprecated childSagaInstanceIds)
          if (detail.childSagas.isNotEmpty) ...[
            SizedBox(height: UIConstants.spacingLg),
            Text('Child Sagas', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.w500)),
            SizedBox(height: UIConstants.spacingMd),
            _buildChildSagaDetailChips(detail.childSagas, isDarkTheme),
          ],
        ],
      ),
    );
  }

  Widget _buildSagaInfoCard(saga_pb.SagaInstance saga, saga_pb.SagaStepSummary summary, bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: UIConstants.cardBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
        border: Border.all(color: UIConstants.borderColor(isDarkTheme)),
      ),
      child: Wrap(
        spacing: UIConstants.spacingXl,
        runSpacing: UIConstants.spacingMd,
        children: [
          _infoItem('Instance ID', saga.instanceId, isDarkTheme),
          _infoItem('Template', saga.sagaTemplateId, isDarkTheme),
          _infoItem('Submitter', saga.sagaSubmitterId, isDarkTheme),
          _stateChip(saga.state),
          _infoItem('Depth', '${saga.sagaDepth}', isDarkTheme),
          if (saga.rootSagaInstanceId.isNotEmpty && saga.rootSagaInstanceId != saga.instanceId)
            _infoItem('Root', _truncateId(saga.rootSagaInstanceId), isDarkTheme),
          _infoItem('Steps', '${summary.completed}/${summary.total} done', isDarkTheme),
          if (summary.failed > 0) _infoItem('Failed', '${summary.failed}', isDarkTheme),
          _infoItem('Created', _formatTimestamp(saga.createdAt.toInt()), isDarkTheme),
          if (saga.compensationReason.isNotEmpty)
            _infoItem('Compensation Reason', saga.compensationReason, isDarkTheme),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value, bool isDarkTheme) {
    return Tooltip(
      message: 'Click to copy',
      child: InkWell(
        onTap: () => _copyToClipboard(value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
            SizedBox(height: 1),
            Text(value, style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm)),
          ],
        ),
      ),
    );
  }

  /// Copyable text widget — tap to copy full value, show truncated display.
  Widget _reasonCell(String reason, bool isDarkTheme) {
    return Tooltip(
      message: 'Click to view full reason',
      child: InkWell(
        onTap: () => _showReasonDialog(reason, isDarkTheme),
        child: Text(
          reason.length > 30 ? '${reason.substring(0, 27)}...' : reason,
          style: TextStyle(
            color: UIConstants.colorWarning,
            fontSize: UIConstants.fontSizeSm,
            decoration: TextDecoration.underline,
            decorationColor: UIConstants.colorWarning,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _showReasonDialog(String reason, bool isDarkTheme) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: UIConstants.dialogBackground(isDarkTheme),
        shape: UIConstants.dialogShape(isDarkTheme) as RoundedRectangleBorder,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(maxHeight: 400),
          padding: UIConstants.paddingComfortable,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: UIConstants.colorWarning, size: 20),
                  const SizedBox(width: UIConstants.spacingSm),
                  Expanded(
                    child: Text(
                      'Compensation Reason',
                      style: TextStyle(
                        color: UIConstants.textPrimary(isDarkTheme),
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, color: UIConstants.textSecondary(isDarkTheme), size: 18),
                    tooltip: 'Copy to clipboard',
                    onPressed: () {
                      _copyToClipboard(reason);
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: UIConstants.textSecondary(isDarkTheme), size: 18),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: UIConstants.spacingMd),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: UIConstants.paddingStandard,
                  decoration: BoxDecoration(
                    color: UIConstants.dialogSurface(isDarkTheme),
                    borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      reason,
                      style: TextStyle(
                        color: UIConstants.textPrimary(isDarkTheme),
                        fontSize: UIConstants.fontSizeSm,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _copyableText(String display, String fullValue, TextStyle style, bool isDarkTheme) {
    return Tooltip(
      message: fullValue,
      waitDuration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => _copyToClipboard(fullValue),
        child: Text(display, style: style, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildProgressBar(saga_pb.SagaStepSummary summary, bool isDarkTheme) {
    final total = summary.total;
    if (total == 0) return const SizedBox.shrink();

    final completedFrac = summary.completed / total;
    final failedFrac = summary.failed / total;
    final pendingFrac = 1.0 - completedFrac - failedFrac;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: UIConstants.borderColor(isDarkTheme),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Row(
              children: [
                if (completedFrac > 0) Expanded(flex: (completedFrac * 100).round(), child: Container(color: UIConstants.colorAccept)),
                if (failedFrac > 0) Expanded(flex: (failedFrac * 100).round(), child: Container(color: UIConstants.colorReject)),
                if (pendingFrac > 0) Expanded(flex: (pendingFrac * 100).round(), child: Container(color: Colors.transparent)),
              ],
            ),
          ),
        ),
        SizedBox(height: UIConstants.spacingXs),
        Row(
          children: [
            _progressLabel('${summary.completed} completed', UIConstants.colorAccept, isDarkTheme),
            SizedBox(width: UIConstants.spacingLg),
            _progressLabel('${summary.pending} pending', Colors.grey, isDarkTheme),
            if (summary.failed > 0) ...[
              SizedBox(width: UIConstants.spacingLg),
              _progressLabel('${summary.failed} failed', UIConstants.colorReject, isDarkTheme),
            ],
            // Show byState counts if there are states beyond the standard 3
            if (summary.byState.isNotEmpty) ...[
              SizedBox(width: UIConstants.spacingLg),
              ...summary.byState.entries.where((e) => !['COMPLETED', 'PENDING', 'FAILED'].contains(e.key.toUpperCase())).map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _progressLabel('${e.value} ${e.key.toLowerCase()}', _stateColor(e.key), isDarkTheme),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _progressLabel(String text, Color color, bool isDarkTheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 4),
        Text(text, style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
      ],
    );
  }

  Widget _buildStepPipeline(bool isDarkTheme) {
    return Column(
      children: List.generate(_orderedSteps.length, (index) {
        final step = _orderedSteps[index];
        final isLast = index == _orderedSteps.length - 1;
        final isExpanded = _expandedSteps.contains(index);

        return Column(
          children: [
            _buildStepCard(step, index, isExpanded, isDarkTheme),
            if (!isLast) _buildConnector(isDarkTheme),
          ],
        );
      }),
    );
  }

  Widget _buildStepCard(saga_pb.SagaStepInstance step, int index, bool isExpanded, bool isDarkTheme) {
    final stateColor = _stateColor(step.state);
    final stateIconData = _stateIcon(step.state);
    final hasHistory = step.executionHistory.isNotEmpty;
    final hasError = step.executionError.isNotEmpty;

    return InkWell(
      onTap: hasHistory || hasError ? () => setState(() {
        if (isExpanded) {
          _expandedSteps.remove(index);
        } else {
          _expandedSteps.add(index);
        }
      }) : null,
      child: Container(
        decoration: BoxDecoration(
          color: UIConstants.cardBackground(isDarkTheme),
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
          border: Border.all(color: UIConstants.borderColor(isDarkTheme)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colored left border
            Container(
              width: 4,
              constraints: BoxConstraints(minHeight: isExpanded ? 80 : 40),
              decoration: BoxDecoration(
                color: stateColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(UIConstants.borderRadiusMd),
                  bottomLeft: Radius.circular(UIConstants.borderRadiusMd),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step header row
                    Row(
                      children: [
                        Icon(stateIconData, color: stateColor, size: UIConstants.iconSizeMd),
                        SizedBox(width: UIConstants.spacingMd),
                        Expanded(
                          child: _copyableText(
                            step.sagaStepTemplateId.isNotEmpty ? step.sagaStepTemplateId : 'Step ${index + 1}',
                            step.sagaStepTemplateId,
                            TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w500),
                            isDarkTheme,
                          ),
                        ),
                        _stateChip(step.state, compact: true),
                        if (hasHistory) ...[
                          SizedBox(width: UIConstants.spacingSm),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: UIConstants.borderColor(isDarkTheme),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('${step.executionHistory.length}x', style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
                          ),
                        ],
                        if (hasHistory || hasError) ...[
                          SizedBox(width: UIConstants.spacingSm),
                          Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: UIConstants.textSecondary(isDarkTheme), size: UIConstants.iconSizeMd),
                        ],
                      ],
                    ),
                    // Expanded execution history
                    if (isExpanded) ...[
                      SizedBox(height: UIConstants.spacingMd),
                      if (hasError)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: UIConstants.colorReject.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
                          ),
                          child: InkWell(
                            onTap: () => _copyToClipboard(step.executionError),
                            child: SelectableText('Error: ${step.executionError}', style: TextStyle(color: UIConstants.colorReject, fontSize: UIConstants.fontSizeXs)),
                          ),
                        ),
                      if (step.resultData.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: UIConstants.colorAccept.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
                          ),
                          child: InkWell(
                            onTap: () => _copyToClipboard(step.resultData),
                            child: SelectableText('Result: ${step.resultData}', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeXs), maxLines: 3),
                          ),
                        ),
                      if (step.compensationResultData.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: UIConstants.colorWarning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
                          ),
                          child: InkWell(
                            onTap: () => _copyToClipboard(step.compensationResultData),
                            child: SelectableText('Compensation Result: ${step.compensationResultData}', style: TextStyle(color: UIConstants.colorWarning, fontSize: UIConstants.fontSizeXs), maxLines: 3),
                          ),
                        ),
                      ...step.executionHistory.asMap().entries.map(
                        (entry) => _buildExecutionLogEntry(entry.key, entry.value, isDarkTheme),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExecutionLogEntry(int index, saga_pb.SagaStepExecutionLog log, bool isDarkTheme) {
    final sentTs = log.executionRequestSentTs.toInt();
    final receivedTs = log.executionResultReceivedTs.toInt();
    final timeoutTs = log.executionTimeoutTs.toInt();
    final conclusionTs = log.logConclusionTs.toInt();

    // Calculate duration
    String duration = '';
    if (sentTs > 0) {
      final endTs = receivedTs > 0 ? receivedTs : (conclusionTs > 0 ? conclusionTs : (timeoutTs > 0 ? timeoutTs : 0));
      if (endTs > 0) {
        final diffMs = (endTs - sentTs).abs();
        // Handle both seconds and milliseconds
        final durationMs = diffMs > 9999999999 ? diffMs : diffMs * 1000;
        final secs = durationMs / 1000.0;
        duration = '(${secs.toStringAsFixed(1)}s)';
      }
    }

    final hasError = log.executionError.isNotEmpty;
    final isCompensation = log.isCompensation;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
        ),
        child: Row(
          children: [
            Text(
              'Attempt ${index + 1}',
              style: TextStyle(
                color: isCompensation ? UIConstants.colorWarning : UIConstants.textSecondary(isDarkTheme),
                fontSize: UIConstants.fontSizeXs,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: UIConstants.spacingMd),
            if (sentTs > 0)
              Text('Sent ${_formatTime(sentTs)}', style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
            if (sentTs > 0 && (receivedTs > 0 || timeoutTs > 0))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.arrow_forward, size: 10, color: UIConstants.textHint(isDarkTheme)),
              ),
            if (receivedTs > 0)
              Text('Received ${_formatTime(receivedTs)}', style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
            if (receivedTs == 0 && timeoutTs > 0)
              Text('Timeout ${_formatTime(timeoutTs)}', style: TextStyle(color: UIConstants.colorWarning, fontSize: UIConstants.fontSizeXs)),
            if (duration.isNotEmpty) ...[
              SizedBox(width: UIConstants.spacingSm),
              Text(duration, style: TextStyle(color: UIConstants.textHint(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
            ],
            if (hasError) ...[
              SizedBox(width: UIConstants.spacingSm),
              Flexible(
                child: InkWell(
                  onTap: () => _copyToClipboard(log.executionError),
                  child: Tooltip(
                    message: log.executionError,
                    child: Text(log.executionError, style: TextStyle(color: UIConstants.colorReject, fontSize: UIConstants.fontSizeXs), overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ],
            if (isCompensation) ...[
              SizedBox(width: UIConstants.spacingSm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: UIConstants.colorWarning.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('compensation', style: TextStyle(color: UIConstants.colorWarning, fontSize: 9)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnector(bool isDarkTheme) {
    return SizedBox(
      height: 24,
      child: Column(
        children: [
          Expanded(
            child: Container(width: 2, color: UIConstants.borderColor(isDarkTheme)),
          ),
          Icon(Icons.arrow_drop_down, size: 14, color: UIConstants.borderColor(isDarkTheme)),
        ],
      ),
    );
  }

  Widget _buildChildSagaDetailChips(List<saga_pb.SagaDetail> childSagas, bool isDarkTheme) {
    return Wrap(
      spacing: UIConstants.spacingMd,
      runSpacing: UIConstants.spacingXs,
      children: childSagas.map((child) {
        final label = child.saga.sagaTemplateId.isNotEmpty
            ? child.saga.sagaTemplateId
            : _truncateId(child.saga.instanceId);
        final stateColor = _stateColor(child.saga.state);
        return ActionChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(fontSize: UIConstants.fontSizeXs, color: UIConstants.textPrimary(isDarkTheme))),
              SizedBox(width: 4),
              _stateChip(child.saga.state, compact: true),
            ],
          ),
          avatar: Icon(Icons.subdirectory_arrow_right, size: 14, color: stateColor),
          backgroundColor: UIConstants.cardBackground(isDarkTheme),
          side: BorderSide(color: UIConstants.borderColor(isDarkTheme)),
          onPressed: () => _navigateToDetail(child.saga.instanceId),
        );
      }).toList(),
    );
  }

  // ============================================================================
  // View 3: Saga Tree
  // ============================================================================

  Widget _buildSagaTreeView(bool isDarkTheme) {
    final tree = _sagaTree;
    if (tree == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      child: _buildTreeNode(tree, 0, isDarkTheme, isLast: true, prefix: []),
    );
  }

  Widget _buildTreeNode(saga_pb.SagaDetail detail, int depth, bool isDarkTheme, {required bool isLast, required List<bool> prefix}) {
    final saga = detail.saga;
    final summary = detail.stepSummary;
    final hasChildren = detail.childSagas.isNotEmpty;
    final isExpanded = _expandedTreeNodes.contains(saga.instanceId);
    final steps = _orderSteps(detail.steps);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tree node row
        InkWell(
          onTap: () {
            setState(() {
              if (isExpanded) {
                _expandedTreeNodes.remove(saga.instanceId);
              } else {
                _expandedTreeNodes.add(saga.instanceId);
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: depth * 24.0),
            child: Row(
              children: [
                // Tree branch lines
                if (depth > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      isLast ? '└─' : '├─',
                      style: TextStyle(color: UIConstants.borderColor(isDarkTheme), fontSize: UIConstants.fontSizeSm, fontFamily: 'monospace'),
                    ),
                  ),
                // Expand/collapse icon
                if (hasChildren || steps.isNotEmpty)
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: UIConstants.iconSizeMd,
                    color: UIConstants.textSecondary(isDarkTheme),
                  )
                else
                  SizedBox(width: UIConstants.iconSizeMd),
                SizedBox(width: UIConstants.spacingXs),
                // Saga info
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: UIConstants.cardBackground(isDarkTheme),
                      borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
                      border: Border.all(color: UIConstants.borderColor(isDarkTheme)),
                    ),
                    child: Row(
                      children: [
                        Icon(_stateIcon(saga.state), color: _stateColor(saga.state), size: UIConstants.iconSizeSm),
                        SizedBox(width: UIConstants.spacingSm),
                        Expanded(
                          child: _copyableText(
                            saga.sagaTemplateId.isNotEmpty ? saga.sagaTemplateId : _truncateId(saga.instanceId),
                            saga.instanceId,
                            TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w500),
                            isDarkTheme,
                          ),
                        ),
                        SizedBox(width: UIConstants.spacingMd),
                        _stateChip(saga.state, compact: true),
                        if (summary.total > 0) ...[
                          SizedBox(width: UIConstants.spacingMd),
                          Text(
                            '[${summary.completed}/${summary.total}]',
                            style: TextStyle(
                              color: summary.failed > 0
                                  ? UIConstants.colorReject
                                  : summary.completed == summary.total
                                      ? UIConstants.colorAccept
                                      : UIConstants.textSecondary(isDarkTheme),
                              fontSize: UIConstants.fontSizeXs,
                            ),
                          ),
                        ],
                        if (hasChildren) ...[
                          SizedBox(width: UIConstants.spacingSm),
                          Icon(Icons.account_tree, size: 12, color: UIConstants.textHint(isDarkTheme)),
                          Text(' ${detail.childSagas.length}', style: TextStyle(color: UIConstants.textHint(isDarkTheme), fontSize: UIConstants.fontSizeXs)),
                        ],
                        SizedBox(width: UIConstants.spacingSm),
                        InkWell(
                          onTap: () => _navigateToDetail(saga.instanceId),
                          child: Icon(Icons.open_in_new, size: 12, color: UIConstants.colorPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expanded: compact step pipeline
        if (isExpanded && steps.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: (depth + 1) * 24.0 + 20),
            child: _buildCompactStepPipeline(steps, isDarkTheme),
          ),

        // Children
        if (isExpanded && hasChildren)
          ...List.generate(detail.childSagas.length, (i) {
            final childPrefix = [...prefix, !isLast];
            return _buildTreeNode(
              detail.childSagas[i],
              depth + 1,
              isDarkTheme,
              isLast: i == detail.childSagas.length - 1,
              prefix: childPrefix,
            );
          }),
      ],
    );
  }

  Widget _buildCompactStepPipeline(List<saga_pb.SagaStepInstance> steps, bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 4),
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: steps.map((step) {
          final color = _stateColor(step.state);
          return Tooltip(
            message: '${step.sagaStepTemplateId}: ${step.state}',
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Icon(_stateIcon(step.state), size: 9, color: color),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================================
  // Shared widgets
  // ============================================================================

  /// Clean enum prefix: SAGA_STATE_ENUM_COMMITTED → COMMITTED
  String _cleanState(String state) {
    if (state.isEmpty) return 'UNKNOWN';
    // Remove common prefixes
    final cleaned = state
        .replaceFirst(RegExp(r'^SAGA_STATE_ENUM_'), '')
        .replaceFirst(RegExp(r'^SAGA_STEP_STATE_ENUM_'), '')
        .replaceFirst(RegExp(r'^STEP_STATE_'), '');
    return cleaned;
  }

  static const _shortStateLabels = <String, String>{
    'COMMITTED': 'COMM',
    'COMPENSATED': 'COMP',
    'BLOCKED': 'BLCK',
    'COMPENSATING': 'CMPG',
    'IN_PROGRESS': 'PROG',
  };

  Widget _stateChip(String state, {bool compact = false}) {
    final cleaned = _cleanState(state);
    final color = _stateColor(cleaned);
    final label = compact ? (_shortStateLabels[cleaned.toUpperCase()] ?? cleaned) : cleaned;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 5 : 8,
        vertical: compact ? 1 : 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(compact ? 4 : 8),
        border: Border.all(color: color.withOpacity(0.4), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: compact ? UIConstants.fontSizeXs : UIConstants.fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
