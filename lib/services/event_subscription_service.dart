import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';
import '../config/app_config.dart';
import '../generated/prtagent/v1/participant.pbgrpc.dart';
import '../generated/prtagent/v1/event.pb.dart';

/// Service that maintains a persistent gRPC stream subscription to SubscribeToEvents.
/// Prints received events to console and shows them as snackbar notifications.
class EventSubscriptionService {
  static final EventSubscriptionService _instance = EventSubscriptionService._internal();
  factory EventSubscriptionService() => _instance;
  EventSubscriptionService._internal();

  ClientChannel? _channel;
  StreamSubscription<Event>? _subscription;
  bool _isSubscribed = false;
  bool _shouldReconnect = true;
  Timer? _reconnectTimer;

  /// Global scaffold messenger key for showing notifications from the service
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Global navigator key for accessing the overlay
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get the overlay from the navigator's current route context.
  OverlayState? _getOverlay() {
    final navigator = navigatorKey.currentState;
    if (navigator == null) return null;
    // The overlay is inside the navigator — use the navigator's overlay directly
    return navigator.overlay;
  }

  bool get isSubscribed => _isSubscribed;

  /// Show a notification using the same overlay system as streaming events.
  /// Can be called from anywhere via EventSubscriptionService().notify(...)
  void notify({
    required String title,
    required String message,
    Color color = const Color(0xFF1565C0),
    IconData icon = Icons.info_outline,
    List<String> meta = const [],
  }) {
    _showCustomNotification(title, message, color, icon, meta);
  }

  void _showCustomNotification(String title, String message, Color color, IconData icon, List<String> meta) {
    final overlay = _getOverlay();
    if (overlay == null) return;

    _currentOverlay?.remove();
    _currentOverlay = null;
    _dismissTimer?.cancel();

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _NotificationOverlayWidget(
        color: color,
        icon: icon,
        typeStr: title,
        primaryMessage: message,
        meta: meta,
        eventId: '',
        onDismiss: () {
          _dismissTimer?.cancel();
          entry.remove();
          if (_currentOverlay == entry) _currentOverlay = null;
        },
        onHoverStart: () {
          _dismissTimer?.cancel();
        },
        onHoverEnd: () {
          _dismissTimer?.cancel();
          _dismissTimer = Timer(const Duration(seconds: 3), () {
            entry.remove();
            if (_currentOverlay == entry) _currentOverlay = null;
          });
        },
      ),
    );

    _currentOverlay = entry;
    overlay.insert(entry);

    _dismissTimer = Timer(const Duration(seconds: 5), () {
      entry.remove();
      if (_currentOverlay == entry) _currentOverlay = null;
    });
  }

  /// Start the event subscription. Call after gRPC connection is established.
  Future<void> subscribe() async {
    if (_isSubscribed) {
      print('📡 [EventSub] Already subscribed, skipping');
      return;
    }

    _shouldReconnect = true;
    await _connect();
  }

  Future<void> _connect() async {
    try {
      await _cleanup();

      _channel = ClientChannel(
        AppConfig.grpcHost,
        port: AppConfig.grpcPort,
        options: ChannelOptions(
          credentials: AppConfig.grpcUseSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
          keepAlive: const ClientKeepAliveOptions(
            pingInterval: Duration(seconds: 15),
            timeout: Duration(seconds: 5),
            permitWithoutCalls: true,
          ),
        ),
      );

      final callOptions = CallOptions(
        metadata: {
          if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty)
            'x-agora-participant-api-key': AppConfig.grpcApiKey!,
        },
      );

      final client = ParticipantServiceClient(_channel!);

      final request = EventSubscriptionParams(
        proposedSubscriptionId: 'mini_broker_${DateTime.now().millisecondsSinceEpoch}',
      );

      print('📡 [EventSub] Subscribing to events on ${AppConfig.grpcHost}:${AppConfig.grpcPort}...');

      final stream = client.subscribeToEvents(request, options: callOptions);

      _subscription = stream.listen(
        _onEvent,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      _isSubscribed = true;
      print('📡 [EventSub] ✅ Subscribed to events');
    } catch (e) {
      print('📡 [EventSub] ❌ Failed to subscribe: $e');
      _isSubscribed = false;
      _scheduleReconnect();
    }
  }

  /// Format event type enum to human-readable string
  String _formatEventType(EventTypeEnum type) {
    switch (type) {
      case EventTypeEnum.EVENT_TYPE_ENUM_NEWS: return 'News';
      case EventTypeEnum.EVENT_TYPE_ENUM_ANNOUNCEMENT: return 'Announcement';
      case EventTypeEnum.EVENT_TYPE_ENUM_MARKET_UPDATE: return 'Market Update';
      case EventTypeEnum.EVENT_TYPE_ENUM_TRADE_EXECUTION: return 'Trade Execution';
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_PLACED: return 'Order Placed';
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_CANCELLED: return 'Order Cancelled';
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_FILLED: return 'Order Filled';
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_EXPIRED: return 'Order Expired';
      case EventTypeEnum.EVENT_TYPE_ENUM_PRICE_UPDATE: return 'Price Update';
      case EventTypeEnum.EVENT_TYPE_ENUM_REGULATORY: return 'Regulatory';
      case EventTypeEnum.EVENT_TYPE_ENUM_SYSTEM: return 'System';
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_UPDATE: return 'Execution Update';
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_RESPONSE: return 'Execution Response';
      default: return type.name;
    }
  }

  /// Pick an icon for the event type
  IconData _eventIcon(EventTypeEnum type) {
    switch (type) {
      case EventTypeEnum.EVENT_TYPE_ENUM_TRADE_EXECUTION: return Icons.swap_horiz;
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_PLACED: return Icons.add_circle_outline;
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_CANCELLED: return Icons.cancel_outlined;
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_FILLED: return Icons.check_circle_outline;
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_EXPIRED: return Icons.timer_off;
      case EventTypeEnum.EVENT_TYPE_ENUM_PRICE_UPDATE: return Icons.trending_up;
      case EventTypeEnum.EVENT_TYPE_ENUM_MARKET_UPDATE: return Icons.bar_chart;
      case EventTypeEnum.EVENT_TYPE_ENUM_NEWS: return Icons.newspaper;
      case EventTypeEnum.EVENT_TYPE_ENUM_ANNOUNCEMENT: return Icons.campaign;
      case EventTypeEnum.EVENT_TYPE_ENUM_SYSTEM: return Icons.settings;
      case EventTypeEnum.EVENT_TYPE_ENUM_REGULATORY: return Icons.gavel;
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_UPDATE: return Icons.sync;
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_RESPONSE: return Icons.task_alt;
      default: return Icons.notifications_active;
    }
  }

  /// Pick a color for the event type
  Color _eventColor(EventTypeEnum type, {ExecutionUpdateEventTypeEnum? execUpdateType}) {
    switch (type) {
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_FILLED:
      case EventTypeEnum.EVENT_TYPE_ENUM_TRADE_EXECUTION:
        return const Color(0xFF2E7D32); // green — successful trades
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_CANCELLED:
        return const Color(0xFFE65100); // deep orange — user-initiated cancel
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_EXPIRED:
        return const Color(0xFFC62828); // red — expired
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_PLACED:
        return const Color(0xFF1565C0); // blue — new order
      case EventTypeEnum.EVENT_TYPE_ENUM_PRICE_UPDATE:
        return const Color(0xFF00838F); // teal — market data
      case EventTypeEnum.EVENT_TYPE_ENUM_MARKET_UPDATE:
        return const Color(0xFF0277BD); // light blue — market info
      case EventTypeEnum.EVENT_TYPE_ENUM_NEWS:
        return const Color(0xFF1565C0); // blue — informational
      case EventTypeEnum.EVENT_TYPE_ENUM_ANNOUNCEMENT:
        return const Color(0xFF6A1B9A); // purple — important notice
      case EventTypeEnum.EVENT_TYPE_ENUM_REGULATORY:
        return const Color(0xFFBF360C); // deep orange — compliance/regulatory
      case EventTypeEnum.EVENT_TYPE_ENUM_SYSTEM:
        return const Color(0xFF455A64); // blue-grey — system
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_UPDATE:
        // Sub-color by execution update type
        if (execUpdateType == ExecutionUpdateEventTypeEnum.EXECUTION_UPDATE_EVENT_TYPE_ENUM_EXECUTION_COMPLETED) {
          return const Color(0xFF2E7D32); // green — completed
        }
        if (execUpdateType == ExecutionUpdateEventTypeEnum.EXECUTION_UPDATE_EVENT_TYPE_ENUM_NEW_EXECUTION_FLOW) {
          return const Color(0xFF1565C0); // blue — new flow started
        }
        return const Color(0xFF4527A0); // purple — progress
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_RESPONSE:
        return const Color(0xFF4527A0); // purple — response data
      default:
        return const Color(0xFF546E7A); // grey-blue — unknown
    }
  }

  /// Decode blob data to a displayable UTF-8 string
  String _decodeBlobData(BlobEvent blob) {
    final data = blob.data.data;
    final encoding = blob.data.encoding.toLowerCase();
    final structType = blob.data.structType;

    if (data.isEmpty) return '(empty blob)';

    // Try to decode based on declared encoding
    if (encoding == 'base64' || encoding == 'b64') {
      try {
        final bytes = base64.decode(data);
        return utf8.decode(bytes, allowMalformed: true);
      } catch (_) {
        // Fall through to raw display
      }
    }

    if (encoding == 'hex') {
      try {
        final bytes = <int>[];
        for (var i = 0; i + 1 < data.length; i += 2) {
          bytes.add(int.parse(data.substring(i, i + 2), radix: 16));
        }
        return utf8.decode(bytes, allowMalformed: true);
      } catch (_) {
        // Fall through to raw display
      }
    }

    // For utf8, plain, json, or unknown encoding — data is already a string
    final prefix = structType.isNotEmpty ? '[$structType] ' : '';
    // Truncate long strings for notification display
    if (data.length > 200) {
      return '$prefix${data.substring(0, 200)}...';
    }
    return '$prefix$data';
  }

  /// Format execution response type to readable name
  String _formatResponseType(ExecutionResponseEvent er) {
    final which = er.whichResponse();
    switch (which) {
      case ExecutionResponseEvent_Response.getInvestorList: return 'Investor List';
      case ExecutionResponseEvent_Response.getInvestorInfoBatch: return 'Investor Info';
      case ExecutionResponseEvent_Response.getInvestorSecurityHoldings: return 'Security Holdings';
      case ExecutionResponseEvent_Response.getInvestorCashHoldings: return 'Cash Holdings';
      case ExecutionResponseEvent_Response.getInvestorOrders: return 'Investor Orders';
      case ExecutionResponseEvent_Response.getInvestorTrades: return 'Investor Trades';
      case ExecutionResponseEvent_Response.getInvestorTransactions: return 'Investor Transactions';
      case ExecutionResponseEvent_Response.getVenueList: return 'Venue List';
      case ExecutionResponseEvent_Response.getVenueCalendar: return 'Venue Calendar';
      case ExecutionResponseEvent_Response.getOrderFees: return 'Order Fees';
      case ExecutionResponseEvent_Response.getParticipantInfo: return 'Participant Info';
      case ExecutionResponseEvent_Response.getParticipantOrders: return 'Participant Orders';
      case ExecutionResponseEvent_Response.getParticipantTrades: return 'Participant Trades';
      case ExecutionResponseEvent_Response.getParticipantSettlements: return 'Participant Settlements';
      case ExecutionResponseEvent_Response.getParticipantHoldings: return 'Participant Holdings';
      case ExecutionResponseEvent_Response.notSet: return '';
      default: return which.name;
    }
  }

  /// Format execution update type to readable string
  String _formatExecUpdateType(ExecutionUpdateEventTypeEnum type) {
    switch (type) {
      case ExecutionUpdateEventTypeEnum.EXECUTION_UPDATE_EVENT_TYPE_ENUM_NEW_EXECUTION_FLOW:
        return 'New Flow';
      case ExecutionUpdateEventTypeEnum.EXECUTION_UPDATE_EVENT_TYPE_ENUM_FLOW_PROGRESS_REPORT:
        return 'Progress';
      case ExecutionUpdateEventTypeEnum.EXECUTION_UPDATE_EVENT_TYPE_ENUM_EXECUTION_COMPLETED:
        return 'Completed';
      default:
        return type.name;
    }
  }

  void _onEvent(Event event) {
    final typeStr = _formatEventType(event.type);
    final eventId = event.id;
    final topic = event.topic;
    ExecutionUpdateEventTypeEnum? execUpdateType;

    print('📡 [EventSub] Event received: id=$eventId, type=$typeStr, topic=$topic');

    // Primary message — the main content shown prominently
    String primaryMessage = '';
    // Metadata lines — smaller supporting info
    final meta = <String>[];

    if (topic.isNotEmpty) meta.add('Topic: $topic');

    // Display names / descriptions are primary content
    if (event.displayNames.isNotEmpty) {
      final displayName = event.displayNames['en'] ?? event.displayNames.values.first;
      if (displayName.isNotEmpty) primaryMessage = displayName;
    }
    if (event.descriptions.isNotEmpty) {
      final desc = event.descriptions['en'] ?? event.descriptions.values.first;
      if (desc.isNotEmpty) {
        if (primaryMessage.isEmpty) {
          primaryMessage = desc;
        } else {
          meta.insert(0, desc);
        }
      }
    }

    if (event.hasExecutionUpdate()) {
      final eu = event.executionUpdate;
      execUpdateType = eu.eventType;
      print('📡 [EventSub]   ExecutionUpdate: refExecId=${eu.refExecutionId}, '
          'type=${eu.eventType.name}, step=${eu.currentStepNr}/${eu.totalNrOfSteps}, msg=${eu.msg}');
      // msg and stepDescription are the primary content
      if (eu.msg.isNotEmpty && primaryMessage.isEmpty) primaryMessage = eu.msg;
      if (eu.stepDescription.isNotEmpty) {
        if (primaryMessage.isEmpty) {
          primaryMessage = eu.stepDescription;
        } else if (eu.stepDescription != primaryMessage) {
          meta.add(eu.stepDescription);
        }
      }
      if (eu.msg.isNotEmpty && primaryMessage != eu.msg) meta.add(eu.msg);
      final updateTypeStr = _formatExecUpdateType(eu.eventType);
      meta.add('Status: $updateTypeStr');
      if (eu.refExecutionId.isNotEmpty) meta.add('Exec: ${eu.refExecutionId}');
      if (eu.currentStepNr.isNotEmpty && eu.totalNrOfSteps.isNotEmpty) {
        final pct = eu.progressPercentage.isNotEmpty ? ' (${eu.progressPercentage}%)' : '';
        meta.add('Step ${eu.currentStepNr}/${eu.totalNrOfSteps}$pct');
      }
      if (eu.tags.isNotEmpty) meta.add('Tags: ${eu.tags.join(', ')}');
    } else if (event.hasExecutionResponse()) {
      final er = event.executionResponse;
      print('📡 [EventSub]   ExecutionResponse: refExecId=${er.refExecutionId}, '
          'response=${er.whichResponse().name}');
      final responseType = _formatResponseType(er);
      if (responseType.isNotEmpty && primaryMessage.isEmpty) primaryMessage = responseType;
      if (responseType.isNotEmpty && primaryMessage != responseType) meta.add('Data: $responseType');
      if (er.refExecutionId.isNotEmpty) meta.add('Exec: ${er.refExecutionId}');
      if (er.tags.isNotEmpty) meta.add('Tags: ${er.tags.join(', ')}');
    } else if (event.hasBlob()) {
      final blobStr = _decodeBlobData(event.blob);
      print('📡 [EventSub]   BlobEvent: $blobStr');
      primaryMessage = blobStr;
    }

    // Labels as metadata
    if (event.labels.isNotEmpty) {
      for (final entry in event.labels.entries) {
        meta.add('${entry.key}: ${entry.value}');
      }
    }

    if (event.metadata.isNotEmpty) {
      print('📡 [EventSub]   metadata: ${event.metadata}');
    }

    _showNotification(event.type, typeStr, eventId, primaryMessage, meta, execUpdateType: execUpdateType);
  }

  void _onError(Object error) {
    print('📡 [EventSub] ❌ Stream error: $error');
    _isSubscribed = false;
    _scheduleReconnect();
  }

  void _onDone() {
    print('📡 [EventSub] Stream closed');
    _isSubscribed = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (!_shouldReconnect) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      print('📡 [EventSub] Attempting reconnect...');
      _connect();
    });
  }

  OverlayEntry? _currentOverlay;
  Timer? _dismissTimer;

  void _showNotification(EventTypeEnum type, String typeStr, String eventId, String primaryMessage, List<String> meta, {ExecutionUpdateEventTypeEnum? execUpdateType}) {
    final overlay = _getOverlay();
    if (overlay == null) return;

    _currentOverlay?.remove();
    _currentOverlay = null;
    _dismissTimer?.cancel();

    final color = _eventColor(type, execUpdateType: execUpdateType);
    final icon = _eventIcon(type);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _NotificationOverlayWidget(
        color: color,
        icon: icon,
        typeStr: typeStr,
        primaryMessage: primaryMessage,
        meta: meta,
        eventId: eventId,
        onDismiss: () {
          _dismissTimer?.cancel();
          entry.remove();
          if (_currentOverlay == entry) _currentOverlay = null;
        },
        onHoverStart: () {
          _dismissTimer?.cancel();
        },
        onHoverEnd: () {
          _dismissTimer?.cancel();
          _dismissTimer = Timer(const Duration(seconds: 3), () {
            entry.remove();
            if (_currentOverlay == entry) _currentOverlay = null;
          });
        },
      ),
    );

    _currentOverlay = entry;
    overlay.insert(entry);

    // Auto-dismiss after 5 seconds (hover will pause this)
    _dismissTimer = Timer(const Duration(seconds: 5), () {
      entry.remove();
      if (_currentOverlay == entry) _currentOverlay = null;
    });
  }

  Future<void> _cleanup() async {
    await _subscription?.cancel();
    _subscription = null;
    await _channel?.shutdown();
    _channel = null;
    _isSubscribed = false;
  }

  /// Stop the subscription and prevent reconnection.
  Future<void> unsubscribe() async {
    print('📡 [EventSub] Unsubscribing...');
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _cleanup();
    print('📡 [EventSub] ✅ Unsubscribed');
  }
}

/// Overlay widget for a notification toast with hover-pause behavior.
class _NotificationOverlayWidget extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String typeStr;
  final String primaryMessage;
  final List<String> meta;
  final String eventId;
  final VoidCallback onDismiss;
  final VoidCallback onHoverStart;
  final VoidCallback onHoverEnd;

  const _NotificationOverlayWidget({
    required this.color,
    required this.icon,
    required this.typeStr,
    required this.primaryMessage,
    required this.meta,
    required this.eventId,
    required this.onDismiss,
    required this.onHoverStart,
    required this.onHoverEnd,
  });

  @override
  State<_NotificationOverlayWidget> createState() => _NotificationOverlayWidgetState();
}

class _NotificationOverlayWidgetState extends State<_NotificationOverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  String? _copiedText;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _copyText(String text) {
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text));
    setState(() => _copiedText = text);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _copiedText = null);
    });
  }

  Widget _copyableText(String text, TextStyle style) {
    final isCopied = _copiedText == text;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _copyText(text),
      child: Tooltip(
        message: 'Click to copy',
        waitDuration: const Duration(milliseconds: 400),
        child: Text(
          isCopied ? 'Copied!' : text,
          style: isCopied ? style.copyWith(color: Colors.white, fontStyle: FontStyle.italic) : style,
          softWrap: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      bottom: 20,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: MouseRegion(
          onEnter: (_) => widget.onHoverStart(),
          onExit: (_) => widget.onHoverEnd(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 380),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(widget.icon, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event type header
                        _copyableText(
                          widget.typeStr,
                          const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: Colors.white70,
                            letterSpacing: 0.5,
                          ),
                        ),
                        // Primary message — large and prominent
                        if (widget.primaryMessage.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          _copyableText(
                            widget.primaryMessage,
                            const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                        ],
                        // Metadata — smaller
                        if (widget.meta.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          for (final line in widget.meta)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: _copyableText(
                                line,
                                const TextStyle(fontSize: 10, color: Colors.white54, height: 1.2),
                              ),
                            ),
                        ],
                        // Event ID — tiny
                        const SizedBox(height: 2),
                        _copyableText(
                          widget.eventId,
                          const TextStyle(fontSize: 8, color: Colors.white30),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Close button
                  GestureDetector(
                    onTap: widget.onDismiss,
                    child: const Icon(Icons.close, color: Colors.white54, size: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final eventSubscriptionService = EventSubscriptionService();
