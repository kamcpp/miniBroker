import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/theme_service.dart';
import '../../services/auth_service.dart';
import '../../services/database_helper.dart';
import '../../services/event_subscription_service.dart';
import '../../utils/menu_items_helper.dart';
import '../../config/ui_constants.dart';
import '../../widgets/base_page.dart';
import '../../widgets/detail_modal.dart';

class EventMessagesPage extends StatefulWidget {
  const EventMessagesPage({super.key});

  @override
  State<EventMessagesPage> createState() => _EventMessagesPageState();
}

class _EventMessagesPageState extends State<EventMessagesPage> {
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  int _totalCount = 0;
  int _pageNumber = 1;
  int _pageSize = 20;
  StreamSubscription<String>? _eventSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMessages();
    });
    // Auto-refresh when new events arrive
    _eventSub = EventSubscriptionService().onEvent.listen((_) {
      _fetchMessages();
    });
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final username = authService.username;
    if (username.isEmpty) return;

    setState(() => _isLoading = true);

    final messages = await DatabaseHelper().getEventMessages(
      username: username,
      pageSize: _pageSize,
      pageNumber: _pageNumber,
    );
    final count = await DatabaseHelper().getEventMessageCount(username);

    if (mounted) {
      setState(() {
        _messages = messages;
        _totalCount = count;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteMessage(int id) async {
    await DatabaseHelper().deleteEventMessage(id);
    _fetchMessages();
  }

  Future<void> _clearAll() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDark = themeService.isDarkTheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: UIConstants.dialogBackground(isDark),
        shape: UIConstants.dialogShape(isDark),
        title: Text('Clear All Events', style: TextStyle(color: UIConstants.textPrimary(isDark))),
        content: Text('Delete all $_totalCount event messages?', style: TextStyle(color: UIConstants.textSecondary(isDark))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: UIConstants.cancelTextButtonStyle(isDark),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: UIConstants.dangerButtonStyle(),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseHelper().clearEventMessages(authService.username);
      setState(() => _pageNumber = 1);
      _fetchMessages();
    }
  }

  void _showMessageDetail(Map<String, dynamic> msg, bool isDark) {
    // Parse event_data JSON
    Map<String, dynamic>? eventData;
    try {
      if (msg['event_data'] != null) {
        eventData = json.decode(msg['event_data'] as String) as Map<String, dynamic>;
      }
    } catch (_) {}

    final allFields = <String, String>{};
    allFields['ID'] = msg['id']?.toString() ?? '';
    allFields['Event ID'] = msg['event_id']?.toString() ?? '';
    allFields['Type'] = msg['event_type']?.toString() ?? '';
    allFields['Topic'] = msg['topic']?.toString() ?? '';
    allFields['Received At'] = _formatTimestamp(msg['received_at']);

    // Flatten event_data fields
    if (eventData != null) {
      for (final entry in eventData.entries) {
        final val = entry.value;
        if (val is Map || val is List) {
          allFields[entry.key] = const JsonEncoder.withIndent('  ').convert(val);
        } else {
          allFields[entry.key] = val?.toString() ?? '';
        }
      }
    }

    DetailModal.show(
      context,
      title: msg['event_type']?.toString() ?? 'Event',
      fields: allFields,
      isDarkTheme: isDark,
    );
  }

  String _formatTimestamp(dynamic ts) {
    if (ts == null) return 'N/A';
    try {
      final ms = ts is int ? ts : int.parse(ts.toString());
      final dt = DateTime.fromMillisecondsSinceEpoch(ms);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
    } catch (_) {
      return ts.toString();
    }
  }

  int get _totalPages => (_totalCount / _pageSize).ceil().clamp(1, 999999);

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDark = themeService.isDarkTheme;
    final menuItems = MenuItemsHelper.buildMenuItems(context, 'event_messages');

    return BasePage(
      menuItems: menuItems,
      content: Container(
        color: UIConstants.pageBackground(isDark),
        child: Column(
          children: [
            // Header bar
            Container(
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: UIConstants.tableHeaderBackground(isDark),
              ),
              child: Row(
                children: [
                  Icon(Icons.message, color: UIConstants.textPrimary(isDark), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Event Messages',
                    style: TextStyle(
                      fontSize: UIConstants.fontSizeMd,
                      fontWeight: UIConstants.fontWeightMedium,
                      color: UIConstants.textPrimary(isDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '($_totalCount total)',
                    style: TextStyle(
                      fontSize: UIConstants.fontSizeSm,
                      color: UIConstants.textSecondary(isDark),
                    ),
                  ),
                  const Spacer(),
                  // Page size selector
                  Text('Page size: ', style: TextStyle(fontSize: 11, color: UIConstants.textSecondary(isDark))),
                  DropdownButton<int>(
                    value: _pageSize,
                    underline: const SizedBox.shrink(),
                    dropdownColor: UIConstants.dropdownBackground(isDark),
                    iconEnabledColor: UIConstants.textSecondary(isDark),
                    items: [10, 20, 50, 100].map((s) => DropdownMenuItem(
                      value: s,
                      child: Text('$s', style: TextStyle(fontSize: 11, color: UIConstants.textPrimary(isDark))),
                    )).toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _pageSize = v;
                          _pageNumber = 1;
                        });
                        _fetchMessages();
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  // Pagination
                  IconButton(
                    icon: Icon(Icons.chevron_left, size: 18, color: _pageNumber > 1 ? UIConstants.textPrimary(isDark) : UIConstants.textHint(isDark)),
                    onPressed: _pageNumber > 1 ? () { setState(() => _pageNumber--); _fetchMessages(); } : null,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                  Text(
                    '$_pageNumber / $_totalPages',
                    style: TextStyle(fontSize: 11, color: UIConstants.textPrimary(isDark)),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, size: 18, color: _pageNumber < _totalPages ? UIConstants.textPrimary(isDark) : UIConstants.textHint(isDark)),
                    onPressed: _pageNumber < _totalPages ? () { setState(() => _pageNumber++); _fetchMessages(); } : null,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                  const SizedBox(width: 12),
                  // Refresh
                  IconButton(
                    icon: Icon(Icons.refresh, size: 18, color: UIConstants.textPrimary(isDark)),
                    tooltip: 'Refresh',
                    onPressed: _fetchMessages,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                  const SizedBox(width: 4),
                  // Clear all
                  if (_totalCount > 0)
                    IconButton(
                      icon: const Icon(Icons.delete_sweep, size: 18, color: Colors.red),
                      tooltip: 'Clear all events',
                      onPressed: _clearAll,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    ),
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(UIConstants.textPrimary(isDark))),
                      ),
                    ),
                ],
              ),
            ),
            // Table header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: UIConstants.visibleBorderColor(isDark))),
              ),
              child: Row(
                children: [
                  SizedBox(width: 150, child: Text('Time', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: UIConstants.textSecondary(isDark)))),
                  SizedBox(width: 140, child: Text('Type', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: UIConstants.textSecondary(isDark)))),
                  SizedBox(width: 140, child: Text('Topic', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: UIConstants.textSecondary(isDark)))),
                  Expanded(child: Text('Message', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: UIConstants.textSecondary(isDark)))),
                  SizedBox(width: 40, child: Text('', style: TextStyle(fontSize: 11))),
                ],
              ),
            ),
            // Table rows
            Expanded(
              child: _messages.isEmpty && !_isLoading
                  ? Center(
                      child: Text(
                        'No event messages',
                        style: TextStyle(color: UIConstants.textSecondary(isDark), fontSize: 12),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final eventType = msg['event_type']?.toString() ?? '';
                        final topic = msg['topic']?.toString() ?? '';
                        final primaryMsg = msg['primary_message']?.toString() ?? '';
                        // Collapse newlines and whitespace for single-line display
                        final displayMsg = primaryMsg.replaceAll(RegExp(r'\s+'), ' ').trim();

                        return InkWell(
                          onTap: () => _showMessageDetail(msg, isDark),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: UIConstants.borderColor(isDark))),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    _formatTimestamp(msg['received_at']),
                                    style: TextStyle(fontSize: 11, color: UIConstants.textSecondary(isDark)),
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    eventType,
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: UIConstants.textPrimary(isDark)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    topic,
                                    style: TextStyle(fontSize: 11, color: UIConstants.textSecondary(isDark)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    displayMsg,
                                    style: TextStyle(fontSize: 11, color: UIConstants.textPrimary(isDark)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                    icon: Icon(Icons.delete_outline, size: 14, color: Colors.red.shade300),
                                    tooltip: 'Delete',
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                                    onPressed: () => _deleteMessage(msg['id'] as int),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
