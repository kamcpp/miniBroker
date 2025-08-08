import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'services/fix_dictionary_parser.dart';
import 'services/auth_service.dart';
import 'models/fix_definitions.dart';
import 'config/environment_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'mini Broker V1.0',
        debugShowCheckedModeBanner: false, // Remove DEBUG banner
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1a1754)),
          useMaterial3: true,
          // Add scrollbar theme to make scrollbars visible
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

class _AppInitializerState extends State<AppInitializer> {
  late Future<InitData> _initFuture;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _initFuture = _initializeApp(authService);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return FutureBuilder<InitData>(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading configurations and FIX dictionary...'),
                    ],
                  ),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Configuration Error',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Please ensure Config.json is placed beside the mini Broker.app bundle.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            
            // Check authentication state
            if (!authService.isLoggedIn) {
              return const LoginPage();
            }
            
            return ChangeNotifierProvider(
              create: (_) => FixDictionaryProvider(snapshot.data?.fixDictionary ?? {}),
              child: const HomePage(),
            );
          },
        );
      },
    );
  }

  Future<InitData> _initializeApp(AuthService authService) async {
    try {
      // Initialize authentication service
      await authService.init();
      
      await EnvironmentConfig.loadConfigurations();
      final fixDictionaryData = await _parseFixDictionary();
      return InitData(fixDictionary: fixDictionaryData);
    } catch (e) {
      throw Exception('Failed to load configurations: $e\n\n'
          'Please ensure Config.json is placed beside the mini Broker.app bundle.\n'
          'For development builds, place it in the same directory as the .app file.');
    }
  }

  Future<Map<String, FixMessageDefinition>> _parseFixDictionary() async {
    try {
      final String xmlContent = await rootBundle.loadString('assets/FIX42.xml');
      return FixDictionaryParser.parseDictionary(xmlContent);
    } catch (e) {
      print('Error loading FIX dictionary: $e');
      return <String, FixMessageDefinition>{};
    }
  }
}

class InitData {
  final Map<String, FixMessageDefinition> fixDictionary;
  
  InitData({required this.fixDictionary});
}

class FixDictionaryProvider extends ChangeNotifier {
  final Map<String, FixMessageDefinition> _dictionary;

  FixDictionaryProvider(this._dictionary);

  Map<String, FixMessageDefinition> get dictionary => _dictionary;

  FixMessageDefinition? getMessageDefinition(String msgType) {
    return _dictionary[msgType];
  }
}
