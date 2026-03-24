import 'dart:io';
import 'package:grpc/grpc.dart';
import '../config/app_config.dart';
import '../generated/prtagent/v1/agent.pbgrpc.dart';
import '../generated/prtagent/v1/participant.pbgrpc.dart';
import '../generated/prtagent/v1/investor.pbgrpc.dart';
import '../generated/prtagent/v1/trading.pbgrpc.dart';
import '../generated/prtagent/v1/admin.pbgrpc.dart';
import '../generated/prtagent/v1/market.pbgrpc.dart';
import '../generated/prtagent/v1/security_listing.pbgrpc.dart';
import '../generated/prtagent/v1/cash_token.pbgrpc.dart';
import '../generated/prtagent/v1/venue.pbgrpc.dart';

/// Singleton that manages a shared gRPC channel and provides service clients.
/// Eliminates the need for the external grpcurl binary.
class GrpcChannelManager {
  GrpcChannelManager._();
  static final GrpcChannelManager instance = GrpcChannelManager._();

  ClientChannel? _channel;

  /// Get or create the shared channel.
  ClientChannel get channel {
    if (_channel == null) {
      _channel = ClientChannel(
        AppConfig.grpcHost,
        port: AppConfig.grpcPort,
        options: ChannelOptions(
          credentials: AppConfig.grpcUseSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
        ),
      );
    }
    return _channel!;
  }

  /// Build CallOptions with API key header and optional timeout.
  CallOptions callOptions({Duration timeout = const Duration(minutes: 5)}) {
    return CallOptions(
      metadata: {
        if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty)
          'x-agora-participant-api-key': AppConfig.grpcApiKey!,
      },
      timeout: timeout,
    );
  }

  /// Tear down and recreate the channel (e.g., after config changes).
  Future<void> reconnect() async {
    await _channel?.shutdown();
    _channel = null;
  }

  /// Test server reachability via socket connection.
  Future<bool> testConnectivity() async {
    try {
      final socket = await Socket.connect(
        AppConfig.grpcHost,
        AppConfig.grpcPort,
        timeout: const Duration(seconds: 2),
      );
      await socket.close();
      return true;
    } catch (_) {
      return false;
    }
  }

  // ── Service client getters ──────────────────────────────────────────────

  AgentServiceClient get agentClient => AgentServiceClient(channel);
  ParticipantServiceClient get participantClient => ParticipantServiceClient(channel);
  InvestorServiceClient get investorClient => InvestorServiceClient(channel);
  TradingServiceClient get tradingClient => TradingServiceClient(channel);
  AdminServiceClient get adminClient => AdminServiceClient(channel);
  MarketServiceClient get marketClient => MarketServiceClient(channel);
  SecurityListingServiceClient get securityListingClient => SecurityListingServiceClient(channel);
  CashTokenServiceClient get cashTokenClient => CashTokenServiceClient(channel);
  VenueServiceClient get venueClient => VenueServiceClient(channel);
}
