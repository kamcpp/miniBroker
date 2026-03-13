import 'dart:async';
import 'package:flutter/material.dart';
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

  bool get isSubscribed => _isSubscribed;

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
  Color _eventColor(EventTypeEnum type) {
    switch (type) {
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_FILLED:
      case EventTypeEnum.EVENT_TYPE_ENUM_TRADE_EXECUTION:
        return const Color(0xFF2E7D32); // green
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_CANCELLED:
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_EXPIRED:
        return const Color(0xFFC62828); // red
      case EventTypeEnum.EVENT_TYPE_ENUM_ORDER_PLACED:
        return const Color(0xFF1565C0); // blue
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_UPDATE:
      case EventTypeEnum.EVENT_TYPE_ENUM_EXECUTION_RESPONSE:
        return const Color(0xFF4527A0); // purple
      case EventTypeEnum.EVENT_TYPE_ENUM_SYSTEM:
        return const Color(0xFF455A64); // grey
      default:
        return const Color(0xFF1565C0); // blue
    }
  }

  void _onEvent(Event event) {
    final typeStr = _formatEventType(event.type);
    final eventId = event.id;
    final topic = event.topic;

    print('📡 [EventSub] Event received: id=$eventId, type=$typeStr, topic=$topic');

    // Build detail lines
    final details = <String>[];

    if (topic.isNotEmpty) details.add('Topic: $topic');

    if (event.hasExecutionUpdate()) {
      final eu = event.executionUpdate;
      print('📡 [EventSub]   ExecutionUpdate: refExecId=${eu.refExecutionId}, '
          'type=${eu.eventType.name}, step=${eu.currentStepNr}/${eu.totalNrOfSteps}, msg=${eu.msg}');
      if (eu.refExecutionId.isNotEmpty) details.add('Exec: ${eu.refExecutionId}');
      if (eu.stepDescription.isNotEmpty) details.add(eu.stepDescription);
      if (eu.msg.isNotEmpty) details.add(eu.msg);
      if (eu.currentStepNr.isNotEmpty && eu.totalNrOfSteps.isNotEmpty) {
        final pct = eu.progressPercentage.isNotEmpty ? ' (${eu.progressPercentage}%)' : '';
        details.add('Step ${eu.currentStepNr}/${eu.totalNrOfSteps}$pct');
      }
    } else if (event.hasExecutionResponse()) {
      final er = event.executionResponse;
      print('📡 [EventSub]   ExecutionResponse: refExecId=${er.refExecutionId}, '
          'response=${er.whichResponse().name}');
      if (er.refExecutionId.isNotEmpty) details.add('Exec: ${er.refExecutionId}');
      final responseName = er.whichResponse().name;
      if (responseName != 'notSet') details.add('Response: $responseName');
    } else if (event.hasBlob()) {
      print('📡 [EventSub]   BlobEvent');
      details.add('Blob data received');
    }

    // Add labels if present
    if (event.labels.isNotEmpty) {
      for (final entry in event.labels.entries) {
        details.add('${entry.key}: ${entry.value}');
      }
    }

    // Log metadata
    if (event.metadata.isNotEmpty) {
      print('📡 [EventSub]   metadata: ${event.metadata}');
    }

    _showNotification(event.type, typeStr, eventId, details);
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

  void _showNotification(EventTypeEnum type, String typeStr, String eventId, List<String> details) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    final color = _eventColor(type);
    final icon = _eventIcon(type);

    // Get screen width to calculate right margin for left-alignment
    final screenWidth = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.width;
    final snackWidth = 360.0;
    final rightMargin = (screenWidth - snackWidth - 20).clamp(20.0, screenWidth);

    messenger.showSnackBar(
      SnackBar(
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeStr,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),
                    ),
                    for (final line in details)
                      Text(
                        line,
                        style: const TextStyle(fontSize: 11, color: Colors.white70),
                        softWrap: true,
                      ),
                    Text(
                      eventId,
                      style: const TextStyle(fontSize: 9, color: Colors.white38),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 5),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: rightMargin),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
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

final eventSubscriptionService = EventSubscriptionService();
