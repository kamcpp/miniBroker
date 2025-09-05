// Example usage of the generated gRPC services
// This file demonstrates how to use the trading services in your Flutter app

import 'dart:async';
import 'package:mini_broker/services/grpc_client.dart';
import 'package:mini_broker/services/account_service.dart';
import 'package:mini_broker/services/agent_service.dart';
import 'package:mini_broker/services/market_service.dart';
import 'package:mini_broker/services/instrument_service.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/common.pb.dart';

class TradingExample {
  /// Example: Connect to the trading server and perform basic operations
  static Future<void> basicTradingExample() async {
    try {
      // 1. Connect to the gRPC server
      print('🔄 Connecting to trading server...');
      await grpcClient.connect(
        host: 'localhost', // Replace with your server host
        port: 50051,       // Simulated participant agent port
        useSecure: false,  // Set to true for production
        timeout: Duration(seconds: 10),
      );
      
      print('✅ Connected successfully!');

      // 2. Test connection with ping
      final pingResponse = await AgentService.ping(
        stringToBePonged: 'Hello from Flutter!',
      );
      print('🏓 Ping response: ${pingResponse.pongString}');

      // 3. Get participant info
      final participantInfo = await AgentService.getParticipantInfo();
      print('👤 Participant ID: ${participantInfo.identifier}');

      // 4. Get available markets
      final markets = await MarketService.getMarketList(pageSize: 10);
      print('🏪 Found ${markets.markets.length} markets');
      
      if (markets.markets.isNotEmpty) {
        final firstMarket = markets.markets.first;
        print('   First market: ${firstMarket.names.isNotEmpty ? firstMarket.names.first : firstMarket.identifiers.first}');
        
        // 5. Get instruments for the first market
        if (firstMarket.identifiers.isNotEmpty) {
          final instruments = await MarketService.getMarketInstrumentList(
            marketId: firstMarket.identifiers.first,
            pageSize: 5,
          );
          print('🎯 Found ${instruments.instruments.length} instruments in market');
        }
      }

      // 6. Get supported currencies
      final currencies = await AgentService.getSupportedCurrencies(pageSize: 10);
      print('💱 Supported currencies: ${currencies.currencies.length}');

    } catch (e) {
      print('❌ Error: $e');
      if (e is GrpcError) {
        print('   gRPC Error: ${grpcClient.handleGrpcError(e)}');
      }
    } finally {
      // Always disconnect when done
      await grpcClient.disconnect();
    }
  }

  /// Example: Account management operations
  static Future<void> accountManagementExample() async {
    try {
      await grpcClient.connect(
        host: 'localhost',
        port: 50051,
        useSecure: false,
      );

      // 1. Create a new account
      print('🆕 Creating new account...');
      final newAccountResponse = await AccountService.createAccount(
        externalAccountId: 'flutter_user_${DateTime.now().millisecondsSinceEpoch}',
        auxData: 'Created from Flutter app',
      );
      
      final accountId = newAccountResponse.newAccountId;
      print('✅ Account created: $accountId');

      // 2. Get account info
      final accountInfo = await AccountService.getAccountInfo(
        accountId: accountId,
      );
      print('ℹ️ Account info: ${accountInfo.account.externalId}');

      // 3. Get account list
      final accountList = await AccountService.getAccountList(pageSize: 5);
      print('📋 Total accounts: ${accountList.accounts.length}');

      // 4. Deposit some cash (example)
      try {
        await AccountService.depositCash(
          accountId: accountId,
          currencyAssetId: 'USD', // Replace with actual currency asset ID
          amount: '1000.00',
          auxData: 'Initial deposit from Flutter',
        );
        print('💰 Cash deposited successfully');
      } catch (e) {
        print('⚠️ Deposit failed (expected if currency not supported): $e');
      }

      // 5. Get cash holdings
      final cashHoldings = await AccountService.getAccountCashHoldings(
        accountId: accountId,
      );
      print('💵 Cash holdings: ${cashHoldings.cashHoldings.balances}');

    } catch (e) {
      print('❌ Account management error: $e');
    } finally {
      await grpcClient.disconnect();
    }
  }

  /// Example: Market data and quotes
  static Future<void> marketDataExample() async {
    try {
      await grpcClient.connect(
        host: 'localhost',
        port: 50051,
        useSecure: false,
      );

      // 1. Get instrument info
      final instruments = await InstrumentService.getInstrumentsInfo(
        pageSize: 10,
      );
      print('📊 Found ${instruments.instruments.length} instruments');

      if (instruments.instruments.isNotEmpty) {
        final firstInstrument = instruments.instruments.first;
        final instrumentSymbol = firstInstrument.zonedSymbols.isNotEmpty 
            ? firstInstrument.zonedSymbols.first.symbols.first.value
            : 'UNKNOWN';
        
        print('🎯 First instrument: $instrumentSymbol');

        // 2. Get latest quote
        try {
          final quote = await InstrumentService.getLatestQuote(
            instrumentRegexes: [instrumentSymbol],
          );
          print('💰 Latest quote: ${quote.quote.amount}');
        } catch (e) {
          print('⚠️ Quote fetch failed: $e');
        }

        // 3. Stream live quotes (uncomment to test streaming)
        /*
        print('📡 Starting live quote stream...');
        final quoteStream = InstrumentService.fetchLiveQuotes(
          instrumentRegexes: [instrumentSymbol],
          updateIntervalMs: 2000,
          maxDurationMs: 30000, // 30 seconds
        );
        
        int quoteCount = 0;
        await for (final quote in quoteStream) {
          print('📈 Live quote ${++quoteCount}: ${quote.quote.amount}');
          if (quoteCount >= 5) break; // Stop after 5 quotes
        }
        */
      }

    } catch (e) {
      print('❌ Market data error: $e');
    } finally {
      await grpcClient.disconnect();
    }
  }

  /// Example: Order management
  static Future<void> orderManagementExample() async {
    try {
      await grpcClient.connect(
        host: 'localhost',
        port: 50051,
        useSecure: false,
      );

      // This example assumes you have a valid account and instrument
      const accountId = 'your_account_id';
      const instrumentId = 'your_instrument_id';

      // 1. Get order fees
      try {
        final orderFees = await MarketService.getOrderFees(
          accountId: accountId,
          instrumentId: instrumentId,
          orderType: 'LIMIT',
          side: OrderSide.ORDER_SIDE__BUY,
          quantity: '10',
          price: '100.00',
        );
        print('💸 Order fees: ${orderFees.feeStructure.totalEstimatedFee}');
      } catch (e) {
        print('⚠️ Fee calculation failed: $e');
      }

      // 2. Create a limit order
      try {
        final orderResponse = await MarketService.createOrder(
          accountId: accountId,
          instrumentId: instrumentId,
          orderType: 'LIMIT',
          side: OrderSide.ORDER_SIDE__BUY,
          quantity: '10',
          price: '100.00',
          participantOrderId: 'flutter_order_${DateTime.now().millisecondsSinceEpoch}',
          timeInForce: 'GTC',
        );
        print('📝 Order created: ${orderResponse.proposedOrderId}');
        
        // 3. Cancel the order
        await MarketService.cancelOrder(
          proposedOrderId: orderResponse.proposedOrderId,
          reason: 'Test cancellation from Flutter',
        );
        print('❌ Order cancelled');
        
      } catch (e) {
        print('⚠️ Order operations failed (expected without valid account/instrument): $e');
      }

      // 4. Get account orders
      try {
        final accountOrders = await AccountService.getAccountOrders(
          accountId: accountId,
          pageSize: 10,
        );
        print('📋 Account has ${accountOrders.orders.length} orders');
      } catch (e) {
        print('⚠️ Failed to get account orders: $e');
      }

    } catch (e) {
      print('❌ Order management error: $e');
    } finally {
      await grpcClient.disconnect();
    }
  }

  /// Example: Event streaming
  static Future<void> eventStreamingExample() async {
    try {
      await grpcClient.connect(
        host: 'localhost',
        port: 50051,
        useSecure: false,
      );

      // Subscribe to events
      final subscriptionId = AgentService.generateSubscriptionId(prefix: 'flutter');
      print('📡 Subscribing to events with ID: $subscriptionId');

      final eventStream = AgentService.subscribeToEvents(
        subscriptionId: subscriptionId,
        topics: ['market_updates', 'order_events'],
        typeRegex: 'ORDER_.*|TRADE_.*',
      );

      // Listen to events for 30 seconds
      print('👂 Listening for events...');
      int eventCount = 0;
      final timeout = Timer(Duration(seconds: 30), () {
        print('⏰ Event streaming timeout');
      });

      await for (final event in eventStream) {
        eventCount++;
        print('📬 Event ${eventCount}: ${event.type} - ${event.topic}');
        
        if (eventCount >= 10) {
          timeout.cancel();
          break;
        }
      }

    } catch (e) {
      print('❌ Event streaming error: $e');
    } finally {
      await grpcClient.disconnect();
    }
  }
}

// Helper function to run all examples
Future<void> runAllExamples() async {
  print('🚀 Starting gRPC Trading Examples\n');
  
  print('=== Basic Trading Example ===');
  await TradingExample.basicTradingExample();
  
  print('\n=== Account Management Example ===');
  await TradingExample.accountManagementExample();
  
  print('\n=== Market Data Example ===');
  await TradingExample.marketDataExample();
  
  print('\n=== Order Management Example ===');
  await TradingExample.orderManagementExample();
  
  print('\n=== Event Streaming Example ===');
  await TradingExample.eventStreamingExample();
  
  print('\n✅ All examples completed!');
}

// Uncomment to run examples:
// void main() async {
//   await runAllExamples();
// }