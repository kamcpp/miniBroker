# miniBroker gRPC Integration

This document explains how to use the generated gRPC client code for the miniBroker Flutter application.

## Overview

This project includes generated Dart gRPC client code from the trading daemon proto files, providing access to:

- **Account Service**: Account management, deposits, withdrawals, portfolio tracking
- **Market Service**: Market data, order creation, order management
- **Security Service**: Real-time quotes, OHLC data, orderbook, trade history
- **Agent Service**: Server connectivity, participant info, event streaming

## Generated Files

The proto files have been compiled into Dart classes located in:
```
lib/generated/qomet/agora/daemons/prtagent/v1/
├── account.pb.dart         # Account message types
├── account.pbgrpc.dart     # Account service client
├── agent.pb.dart           # Agent message types  
├── agent.pbgrpc.dart       # Agent service client
├── common.pb.dart          # Common message types
├── security.pb.dart      # Security message types
├── security.pbgrpc.dart  # Security service client
├── market.pb.dart          # Market message types
└── market.pbgrpc.dart      # Market service client
```

## Service Wrapper Classes

High-level service classes are provided for easier usage:

- `lib/services/grpc_client.dart` - Main gRPC client and connection manager
- `lib/services/account_service.dart` - Account operations
- `lib/services/market_service.dart` - Market and order operations
- `lib/services/security_service.dart` - Market data and quotes
- `lib/services/agent_service.dart` - Server communication and events

## Quick Start

### 1. Connect to Server

```dart
import 'package:mini_broker/services/grpc_client.dart';

// Connect to the trading server
await grpcClient.connect(
  host: 'your-server-host.com',
  port: 9090,
  useSecure: true, // Use TLS in production
  timeout: Duration(seconds: 10),
);
```

### 2. Test Connection

```dart
import 'package:mini_broker/services/agent_service.dart';

// Ping the server
final response = await AgentService.ping();
print('Server response: ${response.pongString}');
```

### 3. Account Operations

```dart
import 'package:mini_broker/services/account_service.dart';

// Create account
final newAccount = await AccountService.createAccount(
  externalAccountId: 'user_123',
);

// Get account info
final accountInfo = await AccountService.getAccountInfo(
  accountId: newAccount.newAccountId,
);

// Deposit cash
await AccountService.depositCash(
  accountId: accountId,
  currencyAssetId: 'USD',
  amount: '1000.00',
);
```

### 4. Market Data

```dart
import 'package:mini_broker/services/security_service.dart';

// Get latest quote
final quote = await SecurityService.getLatestQuote(
  securityRegexes: ['AAPL'],
);

// Stream live quotes
final quoteStream = SecurityService.fetchLiveQuotes(
  securityRegexes: ['AAPL', 'GOOGL'],
  updateIntervalMs: 1000,
);

await for (final quote in quoteStream) {
  print('Price update: ${quote.quote.amount}');
}
```

### 5. Order Management

```dart
import 'package:mini_broker/services/market_service.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/common.pb.dart';

// Create limit order
final orderResponse = await MarketService.createOrder(
  accountId: 'your_account_id',
  securityId: 'AAPL',
  orderType: 'LIMIT',
  side: OrderSide.ORDER_SIDE__BUY,
  quantity: '100',
  price: '150.00',
  participantOrderId: 'order_${DateTime.now().millisecondsSinceEpoch}',
);

// Cancel order
await MarketService.cancelOrder(
  proposedOrderId: orderResponse.proposedOrderId,
  reason: 'User cancellation',
);
```

### 6. Event Streaming

```dart
import 'package:mini_broker/services/agent_service.dart';

// Subscribe to trading events
final subscriptionId = AgentService.generateSubscriptionId();
final eventStream = AgentService.subscribeToEvents(
  subscriptionId: subscriptionId,
  topics: ['market_updates', 'order_events'],
);

await for (final event in eventStream) {
  print('Event: ${event.type} - ${event.data}');
}
```

## Development Workflow

### Regenerating Proto Files

If the proto files are updated, regenerate the Dart code:

```bash
./generate_proto.sh
```

This script will:
1. Check for required tools (protoc, protoc-gen-dart)
2. Compile all proto files to Dart
3. Place generated files in `lib/generated/`

### Dependencies

The following dependencies are added to `pubspec.yaml`:

```yaml
dependencies:
  grpc: ^3.2.4
  protobuf: ^3.1.0

dev_dependencies:
  protoc_plugin: ^21.1.2
```

## Error Handling

The gRPC client includes error handling utilities:

```dart
import 'package:grpc/grpc.dart';
import 'package:mini_broker/services/grpc_client.dart';

try {
  // Your gRPC call
  final response = await someGrpcCall();
} catch (e) {
  if (e is GrpcError) {
    final userFriendlyMessage = grpcClient.handleGrpcError(e);
    print('Error: $userFriendlyMessage');
  }
}
```

## Configuration

### Connection Settings

Update the connection parameters in your app:

```dart
// For development (with simulated participant agent)
await grpcClient.connect(
  host: 'localhost',
  port: 50051,
  useSecure: false,
);

// For production
await grpcClient.connect(
  host: 'api.yourtrading.com',
  port: 443,
  useSecure: true,
);
```

### Timeouts and Keep-Alive

The client is configured with:
- Keep-alive: 30 seconds
- Default timeout: Based on operation
- Automatic reconnection: Not implemented (manual reconnect required)

## Examples

See `lib/examples/grpc_usage_example.dart` for comprehensive usage examples including:
- Basic connectivity
- Account management
- Market data retrieval
- Order operations
- Event streaming

## Troubleshooting

### Common Issues

1. **Connection Failed**: Check host, port, and network connectivity
2. **Permission Denied**: Verify authentication/authorization
3. **Timeout**: Increase timeout duration or check server responsiveness
4. **Proto Compilation**: Ensure protoc and protoc-gen-dart are installed

### Debug Mode

Enable debug logging:

```dart
// Add this for detailed gRPC logs
import 'dart:developer' as developer;

developer.log('gRPC operation started', name: 'grpc');
```

## Production Considerations

1. **Security**: Always use TLS in production (`useSecure: true`)
2. **Error Handling**: Implement comprehensive error handling
3. **Timeouts**: Configure appropriate timeouts for each operation
4. **Retries**: Implement retry logic for transient failures
5. **Connection Pooling**: Consider connection pooling for high-frequency operations
6. **Authentication**: Implement proper authentication mechanisms

## Support

For issues with the gRPC integration:
1. Check the generated proto files are up to date
2. Verify server connectivity and authentication
3. Review the example code for proper usage patterns
4. Check gRPC and protobuf package compatibility