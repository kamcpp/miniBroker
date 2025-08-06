import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'services/fix_dictionary_parser.dart';
import 'models/fix_definitions.dart';
import 'config/environment_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIXYL Quick V1.0',
      debugShowCheckedModeBanner: false, // Remove DEBUG banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      home: FutureBuilder<InitData>(
        future: _initializeApp(),
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
                child: Text('Error during initialization: ${snapshot.error}'),
              ),
            );
          }
          
          return ChangeNotifierProvider(
            create: (_) => FixDictionaryProvider(snapshot.data?.fixDictionary ?? {}),
            child: const HomePage(),
          );
        },
      ),
    );
  }

  Future<InitData> _initializeApp() async {
    try {
      // Load configurations first
      await EnvironmentConfig.loadConfigurations();
      
      // Load FIX dictionary
      final xmlString = await rootBundle.loadString('assets/FIX42.xml');
      final fixDictionary = FixDictionaryParser.parseDictionary(xmlString);
      
      return InitData(fixDictionary: fixDictionary);
    } catch (e) {
      print('Error during app initialization: $e');
      throw e;
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
