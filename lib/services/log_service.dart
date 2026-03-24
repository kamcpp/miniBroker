import 'dart:io';
import 'package:path/path.dart';
import '../utils/config_rc_manager.dart';

/// Simple file + console logging service.
///
/// Buffers log lines before the broker name is known, then flushes to
/// `{configDir}/broker-{brokerName}.log` once [init] is called.
///
/// Usage:
///   - All `print()` calls are intercepted automatically via a Zone in main().
///   - Call [LogService.instance.init(brokerName)] once the broker name is known.
///   - The log file is plain text, one timestamped line per entry.
class LogService {
  LogService._();
  static final LogService instance = LogService._();

  final List<String> _buffer = [];
  IOSink? _sink;
  String? _logPath;

  /// Whether the file sink is ready.
  bool get isInitialized => _sink != null;

  /// Path to the current log file (null before init).
  String? get logPath => _logPath;

  /// Initialize file logging for a specific broker.
  /// Call this after the config directory and broker name are known.
  void init(String brokerName) {
    if (_sink != null) return; // already initialized

    try {
      final configDir = ConfigRcManager.getCurrentConfigDir();
      final dir = Directory(configDir);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      _logPath = join(configDir, 'broker-$brokerName.log');
      final file = File(_logPath!);
      _sink = file.openWrite(mode: FileMode.append);

      // Write session header
      _sink!.writeln('');
      _sink!.writeln('═══════════════════════════════════════════════════════');
      _sink!.writeln('  Session started: ${DateTime.now().toIso8601String()}');
      _sink!.writeln('  Broker: $brokerName');
      _sink!.writeln('═══════════════════════════════════════════════════════');

      // Flush buffered lines
      for (final line in _buffer) {
        _sink!.writeln(line);
      }
      _buffer.clear();
    } catch (e) {
      // Can't write to file — keep buffering, don't crash
      _buffer.add(_formatLine('LogService init failed: $e'));
    }
  }

  /// Log a line. Written to file if initialized, buffered otherwise.
  /// Also always writes to the original stdout (console).
  void log(String message) {
    final line = _formatLine(message);
    if (_sink != null) {
      _sink!.writeln(line);
    } else {
      _buffer.add(line);
    }
  }

  String _formatLine(String message) {
    final now = DateTime.now();
    final ts = '${now.hour.toString().padLeft(2, '0')}'
        ':${now.minute.toString().padLeft(2, '0')}'
        ':${now.second.toString().padLeft(2, '0')}'
        '.${now.millisecond.toString().padLeft(3, '0')}';
    return '$ts  $message';
  }

  /// Flush and close the file sink.
  Future<void> dispose() async {
    try {
      await _sink?.flush();
      await _sink?.close();
    } catch (_) {}
    _sink = null;
    _logPath = null;
  }
}
