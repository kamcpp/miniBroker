import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/trading_page.dart';
import 'screens/portfolio_page.dart';
import 'screens/login_page.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';
import 'services/real_grpc_client.dart';
import 'config/app_config.dart';
import 'utils/config_validator.dart';

void main() {
  // Add comprehensive error handling to catch ALL unhandled exceptions
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    print('❌ CRITICAL: Unhandled exception caught by main zone guard: $error');
    print('❌ CRITICAL: Stack trace: $stack');
    // Don't rethrow - just log and continue
  });
  
  // Also set Flutter-specific error handler
  FlutterError.onError = (FlutterErrorDetails details) {
    print('❌ CRITICAL: Flutter framework error: ${details.exception}');
    print('❌ CRITICAL: Flutter stack trace: ${details.stack}');
    // Don't crash - just log
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
      ],
      child: MaterialApp(
        title: 'mini Broker V1.0',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1a1754)),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.grey[400]),
            trackColor: WidgetStateProperty.all(Colors.grey[200]),
            trackBorderColor: WidgetStateProperty.all(Colors.grey[300]),
            thickness: WidgetStateProperty.all(8.0),
            radius: const Radius.circular(4.0),
          ),
        ),
        home: const AppInitializer(),
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> with SingleTickerProviderStateMixin {
  late Future<void> _initFuture;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _initFuture = _initializeApp(authService);
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return FutureBuilder<void>(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Stack(
                  children: [
                    // Background image
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/chart-background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Semi-transparent overlay for fading
                    Container(
                      color: const Color(0xFF1a1754).withOpacity(0.9), // 90% fade with dark blue
                    ),
                    // Main content
                    Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular progress indicator around the logo
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      // Logo in the center
                      Container(
                        width: 120,
                        height: 120,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                    ),
                  ],
                ),
              );
            }
            
            // Check authentication state
            if (!authService.isLoggedIn) {
              // Start fade animation when showing login page
              _fadeController.forward();
              return Container(
                color: const Color(0xFF1a1754), // Match login page background
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const LoginPage(),
                ),
              );
            }
            
            return const PortfolioPage();
          },
        );
      },
    );
  }

  Future<void> _initializeApp(AuthService authService) async {
    try {
      // FIRST: Validate that the config file exists
      final configValidation = ConfigValidator.validateConfig();

      if (!configValidation.isValid) {
        // Show error dialog and stop initialization
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showConfigErrorDialog(configValidation.errorMessage ?? 'Configuration file missing');
          });
        }
        throw Exception('Configuration file validation failed');
      }

      // Initialize authentication service
      await authService.init();

      // Initialize gRPC connection (re-enabled with fixes)
      await _initializeGrpcConnection();

      // Add any other initialization here if needed
      await Future.delayed(const Duration(milliseconds: 500)); // Brief delay for smooth UX
    } catch (e) {
      throw Exception('Failed to initialize application: $e');
    }
  }

  Future<void> _initializeGrpcConnection() async {
    try {
      await realGrpcClient.connect(
        host: AppConfig.grpcHost,
        port: AppConfig.grpcPort,
        useSecure: false,
      );
      print('✅ Real gRPC client connected to simprtagent server');
    } catch (e) {
      print('⚠️ Failed to connect to real gRPC server: $e');
      // Continue with app initialization even if gRPC connection fails
      // The app can still function with local features
    }
  }

  /// Show error dialog when config file is missing
  void _showConfigErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot dismiss this dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red[400],
                size: 32,
              ),
              const Expanded(
                child: Text(
                  'Configuration Error',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Exit the application
                exit(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Exit Application',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}