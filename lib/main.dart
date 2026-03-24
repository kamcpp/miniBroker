import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'screens/securities_page.dart';
import 'screens/role_selection_page.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';
import 'services/real_grpc_client.dart';
import 'config/app_config.dart';
import 'config/ui_constants.dart';
import 'utils/broker_config_helper.dart';
import 'utils/config_rc_manager.dart';
import 'widgets/config_finder_dialog.dart';
import 'services/event_subscription_service.dart';

Future<void> main() async {
  // Replace the red error screen with a subtle dark error widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    print('❌ CRITICAL: Widget error: ${details.exception}');
    print('❌ CRITICAL: Flutter stack trace: ${details.stack}');
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF1A1A2E),
      child: const Center(
        child: Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
      ),
    );
  };

  // Set Flutter-specific error handler
  FlutterError.onError = (FlutterErrorDetails details) {
    print('❌ CRITICAL: Flutter framework error: ${details.exception}');
    print('❌ CRITICAL: Flutter stack trace: ${details.stack}');
    // Don't crash - just log
  };

  // Load version from pubspec.yaml
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    AppConfig.appVersion = packageInfo.version;
    AppConfig.appFullVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
    print('📦 App version: ${AppConfig.appFullVersion}');
  } catch (e) {
    print('⚠️ Could not load package info: $e');
  }

  // Add comprehensive error handling to catch ALL unhandled exceptions
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    print('❌ CRITICAL: Unhandled exception caught by main zone guard: $error');
    print('❌ CRITICAL: Stack trace: $stack');
    // Don't rethrow - just log and continue
  });
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
        navigatorKey: eventSubscriptionService.navigatorKey,
        scaffoldMessengerKey: eventSubscriptionService.scaffoldMessengerKey,
        title: '${AppConfig.appName}-v${AppConfig.appVersion}',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: UIConstants.colorCommand),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.grey[400]),
            trackColor: WidgetStateProperty.all(Colors.grey[200]),
            trackBorderColor: WidgetStateProperty.all(Colors.grey[300]),
            thickness: WidgetStateProperty.all(8.0),
            radius: const Radius.circular(4.0),
          ),
          snackBarTheme: SnackBarThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
            ),
            behavior: SnackBarBehavior.floating,
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
            ),
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
  bool _needsConfigSelection = false;
  bool _configCheckDone = false;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _initFuture = _checkConfigAndInitialize(authService);

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
    // Show Config Finder dialog if needed - don't show login form behind it
    if (_needsConfigSelection && _configCheckDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final result = await showDialog<String>(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          builder: (context) => const ConfigFinderDialog(),
        );

        if (result != null) {
          // Config was selected, restart initialization
          setState(() {
            _needsConfigSelection = false;
            _configCheckDone = false;
            final authService = Provider.of<AuthService>(context, listen: false);
            _initFuture = _initializeWithConfig(authService, result);
          });
        }
      });

      // Return a simple background while config dialog is shown
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/chart-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: UIConstants.colorCommand.withOpacity(0.9),
          ),
        ),
      );
    }

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
                      color: UIConstants.colorCommand.withOpacity(0.9), // 90% fade with dark blue
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

            // Check for initialization errors
            if (snapshot.hasError) {
              print('❌ Initialization error: ${snapshot.error}');
              // Show error but don't exit - let user see the error
              return Scaffold(
                backgroundColor: UIConstants.colorCommand,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 64,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Initialization Failed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            // Restart initialization
                            setState(() {
                              final authService = Provider.of<AuthService>(context, listen: false);
                              _initFuture = _checkConfigAndInitialize(authService);
                            });
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Check authentication state
            if (!authService.isLoggedIn) {
              // Start fade animation when showing login page
              _fadeController.forward();
              return Container(
                color: UIConstants.colorCommand, // Match login page background
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const RoleSelectionPage(),
                ),
              );
            }

            return const SecuritiesPage();
          },
        );
      },
    );
  }

  /// First pass - check if config selection is needed
  Future<void> _checkConfigAndInitialize(AuthService authService) async {
    try {
      // Initialize RC file and get config directory
      final configDir = ConfigRcManager.initializeRcFile();
      print('✅ Config directory: $configDir');

      // Always show Config Finder dialog to let user select config
      setState(() {
        _needsConfigSelection = true;
        _configCheckDone = true;
      });
      // Suspend here - dialog will be shown in build()
      return;
    } catch (e) {
      throw Exception('Failed to check configuration: $e');
    }
  }

  /// Initialize app with selected config file
  Future<void> _initializeWithConfig(AuthService authService, String configFileName) async {
    try {
      final configDir = ConfigRcManager.getCurrentConfigDir();

      // Load the selected config file
      final config = BrokerConfigHelper.readConfigFile(
        configFileName,
        configDir: configDir,
      );

      if (config == null) {
        throw Exception('Failed to read config file: $configFileName');
      }

      // Extract and store broker name
      final brokerName = BrokerConfigHelper.getBrokerNameFromFileName(configFileName);
      if (brokerName != null) {
        AppConfig.selectedBrokerName = brokerName;
        print('✅ Selected broker: $brokerName');
      }

      print('✅ Loaded config: $configFileName');

      // Initialize authentication service
      await authService.init();

      // Initialize gRPC connection with config from file
      await _initializeGrpcConnection(config);

      // Add any other initialization here if needed
      await Future.delayed(const Duration(milliseconds: 500)); // Brief delay for smooth UX
    } catch (e) {
      throw Exception('Failed to initialize application: $e');
    }
  }

  Future<void> _initializeGrpcConnection(Map<String, dynamic> config) async {
    try {
      // Extract gRPC settings from config
      final grpcConfig = config['grpc'] as Map<String, dynamic>?;
      final host = grpcConfig?['host'] as String? ?? AppConfig.grpcHost;
      final port = grpcConfig?['port'] as int? ?? AppConfig.grpcPort;
      final useSecure = grpcConfig?['useSecure'] as bool? ?? false;

      // Extract API key from participant config
      final participantConfig = config['participant'] as Map<String, dynamic>?;
      final apiKey = participantConfig?['apiKey'] as String?;

      // Update AppConfig so GrpcHelper and other components use the correct host/port
      AppConfig.grpcHost = host;
      AppConfig.grpcPort = port;
      AppConfig.grpcUseSecure = useSecure;
      AppConfig.grpcApiKey = apiKey;
      print('✅ Updated AppConfig: gRPC server set to $host:$port');
      if (apiKey != null && apiKey.isNotEmpty) {
        print('✅ API key loaded from config: ${apiKey.substring(0, 20)}...');
      } else {
        print('⚠️  No API key found in config');
      }

      await realGrpcClient.connect(
        host: host,
        port: port,
        useSecure: useSecure,
      );
      print('✅ Real gRPC client connected to $host:$port');

      // Start event subscription
      eventSubscriptionService.subscribe();
    } catch (e) {
      print('⚠️ Failed to connect to real gRPC server: $e');
      // Continue with app initialization even if gRPC connection fails
      // The app can still function with local features
    }
  }
}