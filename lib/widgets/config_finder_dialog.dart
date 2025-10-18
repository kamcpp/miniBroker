import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import '../services/theme_service.dart';
import '../utils/config_rc_manager.dart';
import '../utils/broker_config_helper.dart';
import 'create_broker_config_dialog.dart';
import 'edit_broker_config_dialog.dart';
import 'duplicate_config_dialog.dart';

/// Config Finder Dialog - main entry point for config management
class ConfigFinderDialog extends StatefulWidget {
  const ConfigFinderDialog({super.key});

  @override
  State<ConfigFinderDialog> createState() => _ConfigFinderDialogState();
}

class _ConfigFinderDialogState extends State<ConfigFinderDialog> {
  late String _configDir;
  late TextEditingController _configDirController;
  List<String> _configFiles = [];
  String? _selectedConfig;
  bool _isLoading = true;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _initializeConfigFinder();
  }

  void _initializeConfigFinder() {
    // Initialize RC file and get config directory
    _configDir = ConfigRcManager.initializeRcFile();
    _configDirController = TextEditingController(text: _configDir);

    // Load config files
    _loadConfigFiles();
  }

  void _loadConfigFiles() {
    setState(() {
      _isLoading = true;
    });

    final files = BrokerConfigHelper.findAllConfigFiles(configDir: _configDir);

    setState(() {
      _configFiles = files;
      _isLoading = false;

      // Auto-select if only one config
      if (_configFiles.length == 1) {
        _selectedConfig = _configFiles.first;
      }
    });
  }

  Future<void> _changeConfigDir() async {
    final newDir = _configDirController.text.trim();

    if (newDir.isEmpty) {
      _showError('Config directory cannot be empty');
      return;
    }

    if (newDir == _configDir) {
      return; // No change
    }

    // Validate directory
    try {
      final directory = Directory(newDir);
      if (!directory.existsSync()) {
        // Ask user if they want to create it
        final create = await _showConfirmDialog(
          'Directory does not exist',
          'The directory "$newDir" does not exist. Create it?',
        );

        if (!create) {
          _configDirController.text = _configDir; // Revert
          return;
        }
      }

      // Update config directory
      final success = ConfigRcManager.updateConfigDir(newDir);

      if (success) {
        setState(() {
          _configDir = newDir;
          _selectedConfig = null;
        });

        _loadConfigFiles();

        // Show restart prompt
        _showRestartDialog();
      } else {
        _showError('Failed to update config directory');
        _configDirController.text = _configDir; // Revert
      }
    } catch (e) {
      _showError('Invalid directory path: $e');
      _configDirController.text = _configDir; // Revert
    }
  }

  Future<void> _createNewConfig() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => CreateBrokerConfigDialog(configDir: _configDir),
    );

    if (result != null) {
      // Reload config files
      _loadConfigFiles();

      // Auto-select the newly created config
      final brokerName = result['brokerName'] as String;
      final fileName = BrokerConfigHelper.getConfigFileName(brokerName);
      setState(() {
        _selectedConfig = fileName;
      });
    }
  }

  Future<void> _editConfig(String fileName) async {
    // Load existing config
    final config = BrokerConfigHelper.readConfigFile(fileName, configDir: _configDir);
    if (config == null) {
      _showError('Failed to load config file');
      return;
    }

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => EditBrokerConfigDialog(
        configDir: _configDir,
        fileName: fileName,
        existingConfig: config,
      ),
    );

    if (result == true) {
      // Reload config files to refresh summary
      _loadConfigFiles();
    }
  }

  Future<void> _duplicateConfig(String fileName) async {
    // Load existing config
    final config = BrokerConfigHelper.readConfigFile(fileName, configDir: _configDir);
    if (config == null) {
      _showError('Failed to load config file');
      return;
    }

    final existingBrokerName = BrokerConfigHelper.getBrokerNameFromFileName(fileName);

    // Show dialog to get new broker name
    final newBrokerName = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => DuplicateConfigDialog(
        originalName: existingBrokerName ?? 'unknown',
      ),
    );

    if (newBrokerName != null && newBrokerName.isNotEmpty) {
      // Get config values
      final grpcConfig = config['grpc'] as Map<String, dynamic>?;
      final participantConfig = config['participant'] as Map<String, dynamic>?;

      // Create new config with same values but new name
      final success = BrokerConfigHelper.createConfigFile(
        brokerName: newBrokerName,
        grpcHost: grpcConfig?['host'] as String? ?? 'localhost',
        grpcPort: grpcConfig?['port'] as int? ?? 50051,
        apiKey: participantConfig?['apiKey'] as String? ?? '',
        participantId: participantConfig?['participantId'] as String?,
        participantName: participantConfig?['name'] as String?,
        configDir: _configDir,
      );

      if (success) {
        // Reload and select the new config
        _loadConfigFiles();
        final newFileName = BrokerConfigHelper.getConfigFileName(newBrokerName);
        setState(() {
          _selectedConfig = newFileName;
        });
      } else {
        _showError('Failed to duplicate config. A broker with this name may already exist.');
      }
    }
  }

  Future<void> _deleteConfig(String fileName, String brokerName) async {
    // Show confirmation dialog
    final confirmed = await _showDeleteConfirmDialog(brokerName);

    if (!confirmed) {
      return;
    }

    try {
      final filePath = path.join(_configDir, fileName);
      final file = File(filePath);

      if (file.existsSync()) {
        file.deleteSync();

        // Clear selection if deleted config was selected
        if (_selectedConfig == fileName) {
          setState(() {
            _selectedConfig = null;
          });
        }

        // Reload config list
        _loadConfigFiles();
      } else {
        _showError('Config file not found');
      }
    } catch (e) {
      _showError('Failed to delete config: $e');
    }
  }

  Future<bool> _showDeleteConfirmDialog(String brokerName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        final themeService = Provider.of<ThemeService>(context, listen: false);
        final isDarkTheme = themeService.isDarkTheme;
        final textColor = isDarkTheme ? Colors.white : Colors.black;

        return AlertDialog(
          backgroundColor: isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
          title: Text(
            'Delete Configuration',
            style: TextStyle(color: textColor),
          ),
          content: Text(
            'Are you sure you want to delete "$brokerName"? This action cannot be undone.',
            style: TextStyle(color: textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  Future<bool> _showConfirmDialog(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  void _showRestartDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Restart Required'),
        content: const Text(
          'Config directory has been changed. The application needs to restart to apply changes.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              exit(0); // Exit app (will be relaunched by user)
            },
            child: const Text('Restart Now'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _configDirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    final backgroundColor = isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white;
    final surfaceColor = isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[100]!;
    final hoverColor = isDarkTheme ? const Color(0xFF3d3d3d) : Colors.grey[200]!;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final hintColor = isDarkTheme ? Colors.grey[400]! : Colors.grey[600]!;
    final primaryColor = isDarkTheme ? const Color(0xFF6b9eff) : const Color(0xFF1a1754);
    final selectedColor = isDarkTheme ? const Color(0xFF00b8fb) : const Color(0xFF1a1754);

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 700,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.folder_special, color: primaryColor, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Broker Configuration Finder',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Config Directory Section
            Text(
              'Configuration Directory',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _configDirController,
                    style: TextStyle(color: textColor, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Config directory path',
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: surfaceColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _changeConfigDir,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.save, size: 18),
                  label: const Text('Change'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Changes to config directory require app restart',
              style: TextStyle(color: hintColor, fontSize: 12),
            ),
            const SizedBox(height: 24),

            // Broker Configs Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Broker Configurations',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                TextButton.icon(
                  onPressed: _createNewConfig,
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                  ),
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: const Text('Create New'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Config Files List
            Flexible(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : _configFiles.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: hintColor!.withOpacity(0.3),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 48,
                                  color: hintColor,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No broker configurations found',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Click "Create New" to add your first broker',
                                  style: TextStyle(
                                    color: hintColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _configFiles.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 1,
                              color: isDarkTheme
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                            ),
                            itemBuilder: (context, index) {
                              final fileName = _configFiles[index];
                              final brokerName = BrokerConfigHelper
                                      .getBrokerNameFromFileName(fileName) ??
                                  fileName;
                              final isSelected = _selectedConfig == fileName;
                              final isHovered = _hoveredIndex == index;

                              // Load config summary
                              final config = BrokerConfigHelper.readConfigFile(
                                fileName,
                                configDir: _configDir,
                              );
                              final grpcConfig = config?['grpc'] as Map<String, dynamic>?;
                              final participantConfig = config?['participant'] as Map<String, dynamic>?;
                              final appConfig = config?['app'] as Map<String, dynamic>?;

                              final host = grpcConfig?['host'] as String? ?? 'N/A';
                              final port = grpcConfig?['port']?.toString() ?? 'N/A';
                              final participantId = participantConfig?['participantId'] as String? ?? 'N/A';
                              final apiKey = participantConfig?['apiKey'] as String? ?? '';
                              final apiKeyPreview = apiKey.length > 8
                                  ? '${apiKey.substring(0, 4)}...${apiKey.substring(apiKey.length - 4)}'
                                  : (apiKey.isNotEmpty ? '***' : 'N/A');
                              final environment = appConfig?['environment'] as String? ?? 'N/A';

                              final summary = '$host:$port • $participantId • API: $apiKeyPreview • $environment';

                              return MouseRegion(
                                onEnter: (_) =>
                                    setState(() => _hoveredIndex = index),
                                onExit: (_) =>
                                    setState(() => _hoveredIndex = null),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedConfig = fileName;
                                    });
                                  },
                                  onDoubleTap: () {
                                    // Double-click to launch immediately
                                    Navigator.of(context).pop(fileName);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? selectedColor.withOpacity(0.1)
                                          : (isHovered
                                              ? hoverColor
                                              : Colors.transparent),
                                      border: isSelected
                                          ? Border.all(
                                              color: selectedColor,
                                              width: 2,
                                            )
                                          : null,
                                      borderRadius: index == 0
                                          ? const BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            )
                                          : index == _configFiles.length - 1
                                              ? const BorderRadius.vertical(
                                                  bottom: Radius.circular(12),
                                                )
                                              : null,
                                    ),
                                    child: Row(
                                      children: [
                                        // Radio indicator
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isSelected
                                                  ? selectedColor
                                                  : hintColor,
                                              width: 2,
                                            ),
                                            color: isSelected
                                                ? selectedColor
                                                : Colors.transparent,
                                          ),
                                          child: isSelected
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 16),

                                        // Broker info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                brokerName,
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                summary,
                                                style: TextStyle(
                                                  color: hintColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Action buttons
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Edit button
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit_outlined,
                                                size: 18,
                                                color: hintColor,
                                              ),
                                              tooltip: 'Edit config',
                                              onPressed: () => _editConfig(fileName),
                                            ),
                                            // Duplicate button
                                            IconButton(
                                              icon: Icon(
                                                Icons.content_copy,
                                                size: 18,
                                                color: hintColor,
                                              ),
                                              tooltip: 'Duplicate config',
                                              onPressed: () => _duplicateConfig(fileName),
                                            ),
                                            // Delete button
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete_outline,
                                                size: 18,
                                                color: Colors.red[400],
                                              ),
                                              tooltip: 'Delete config',
                                              onPressed: () => _deleteConfig(fileName, brokerName),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),

            if (_configFiles.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tip: Double-click a configuration to launch immediately',
                        style: TextStyle(
                          color:
                              isDarkTheme ? Colors.blue[200] : primaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => exit(0),
                  style: TextButton.styleFrom(
                    foregroundColor: hintColor,
                  ),
                  child: const Text('Exit'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _selectedConfig != null
                      ? () => Navigator.of(context).pop(_selectedConfig)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: hintColor?.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Launch',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}