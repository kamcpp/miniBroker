import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/trading_page.dart';
import 'screens/portfolio_page.dart';
import 'screens/login_page.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';

void main() {
  runApp(const MyApp());
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
                backgroundColor: const Color(0xFF1a1754), // Match login page background
                body: Center(
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
              );
            }
            
            // Check authentication state
            if (!authService.isLoggedIn) {
              // Start fade animation when showing login page
              _fadeController.forward();
              return FadeTransition(
                opacity: _fadeAnimation,
                child: const LoginPage(),
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
      // Initialize authentication service
      await authService.init();
      
      // Add any other initialization here if needed
      await Future.delayed(const Duration(milliseconds: 500)); // Brief delay for smooth UX
    } catch (e) {
      throw Exception('Failed to initialize application: $e');
    }
  }
}