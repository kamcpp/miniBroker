import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/auth_service.dart';
import '../services/grpcurl_helper.dart';
import '../utils/menu_items_helper.dart';
import '../config/ui_constants.dart';
import '../widgets/base_page.dart';

class InvestorInfoPage extends StatefulWidget {
  const InvestorInfoPage({super.key});

  @override
  State<InvestorInfoPage> createState() => _InvestorInfoPageState();
}

class _InvestorInfoPageState extends State<InvestorInfoPage> {
  Map<String, dynamic>? _investorData;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInvestorInfo();
    });
  }

  Future<void> _fetchInvestorInfo() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // The logged-in username IS the investor ID (external_investor_id)
      final authService = Provider.of<AuthService>(context, listen: false);
      final investorId = authService.username;

      if (investorId.isEmpty) {
        setState(() {
          _error = 'No logged-in user found';
          _isLoading = false;
        });
        return;
      }

      final result = await GrpcurlHelper.getInvestorInfoBatch(
        investorIids: [investorId],
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _investorData = result['output'] as Map<String, dynamic>? ?? {};
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = result['output']?['error'] ?? 'Unknown error';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _copyToClipboard(String value) {
    Clipboard.setData(ClipboardData(text: value));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied: $value', style: const TextStyle(fontSize: 12)),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          width: 300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;
    final backgroundColor = isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[50]!;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'investor_info'),
      content: Container(
        color: backgroundColor,
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with refresh button
            Row(
              children: [
                Text(
                  'Investor Info',
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: UIConstants.fontSizeLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: UIConstants.buttonHeightStandard,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _fetchInvestorInfo,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: Text('Refresh', style: TextStyle(fontSize: UIConstants.fontSizeSm)),
                    style: UIConstants.buttonStyle(UIConstants.colorCommand),
                  ),
                ),
              ],
            ),
            SizedBox(height: UIConstants.spacingMd),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: _buildInvestorInfoSection(isDarkTheme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestorInfoSection(bool isDarkTheme) {
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final labelColor = isDarkTheme ? Colors.grey[400]! : Colors.grey[600]!;
    final cardColor = isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[100]!;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return InkWell(
        onTap: () => _copyToClipboard(_error!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(_error!, style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm))),
            const SizedBox(width: 4),
            Icon(Icons.copy, size: 10, color: Colors.red[300]),
          ],
        ),
      );
    }

    if (_investorData == null) {
      return Text('No investor data', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm));
    }

    // New proto: response has investor_infos (list of InvestorInfo with investor + account_relations)
    // Fallback to old 'investors' field for backwards compatibility
    final investorInfos = _investorData!['investorInfos'] as List<dynamic>? ??
        _investorData!['investor_infos'] as List<dynamic>? ??
        _investorData!['investors'] as List<dynamic>? ?? [];
    final responseFields = Map<String, dynamic>.from(_investorData!);
    responseFields.remove('investorInfos');
    responseFields.remove('investor_infos');
    responseFields.remove('investors');

    final widgets = <Widget>[];

    // Response-level fields (ref_execution_id, metadata, etc.)
    if (responseFields.isNotEmpty) {
      widgets.add(
        Container(
          width: double.infinity,
          padding: UIConstants.paddingStandard,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDarkTheme ? Colors.white12 : Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Response Details', style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.bold)),
              SizedBox(height: UIConstants.spacingXs),
              ..._buildDynamicFields(responseFields, labelColor, textColor, isDarkTheme),
            ],
          ),
        ),
      );
      widgets.add(SizedBox(height: UIConstants.spacingSm));
    }

    // Investor data
    if (investorInfos.isEmpty) {
      widgets.add(Text('No investor found in response', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm)));
    } else {
      for (var i = 0; i < investorInfos.length; i++) {
        // Each entry is an InvestorInfo with 'investor' and 'account_relations' fields,
        // or directly an Investor object (old format)
        final entry = investorInfos[i] as Map<String, dynamic>? ?? {};
        final investor = entry.containsKey('investor')
            ? entry  // new format: render the whole InvestorInfo (investor + account_relations)
            : entry; // old format: the entry IS the investor
        final title = investorInfos.length == 1 ? 'Investor Information' : 'Investor [${i + 1}]';
        widgets.add(
          Container(
            width: double.infinity,
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDarkTheme ? Colors.white12 : Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.bold)),
                SizedBox(height: UIConstants.spacingSm),
                ..._buildDynamicFields(investor, labelColor, textColor, isDarkTheme),
              ],
            ),
          ),
        );
        if (i < investorInfos.length - 1) {
          widgets.add(SizedBox(height: UIConstants.spacingSm));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// Recursively render all fields from a dynamic JSON object
  List<Widget> _buildDynamicFields(
    Map<String, dynamic> data,
    Color labelColor,
    Color textColor,
    bool isDarkTheme, {
    String prefix = '',
  }) {
    final widgets = <Widget>[];

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      final displayKey = _formatFieldName(key);
      final fullLabel = prefix.isNotEmpty ? '$prefix > $displayKey' : displayKey;

      if (value == null) continue;

      if (value is String || value is num || value is bool) {
        // Try to parse strings that look like JSON objects/arrays
        if (value is String && value.trimLeft().startsWith('{')) {
          try {
            final parsed = jsonDecode(value);
            if (parsed is Map<String, dynamic>) {
              widgets.add(
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: _buildNestedSection(fullLabel, parsed, labelColor, textColor, isDarkTheme),
                ),
              );
              continue;
            }
          } catch (_) {
            // Not valid JSON, render as string below
          }
        }
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: _infoField(fullLabel, value.toString(), labelColor, textColor),
          ),
        );
      } else if (value is List) {
        if (value.isEmpty) continue;
        if (value.first is Map) {
          for (var i = 0; i < value.length; i++) {
            final item = value[i] as Map<String, dynamic>;
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: _buildNestedSection(
                  '$fullLabel [${i + 1}]',
                  item,
                  labelColor,
                  textColor,
                  isDarkTheme,
                ),
              ),
            );
          }
        } else {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: _infoField(fullLabel, value.map((e) => e.toString()).join(', '), labelColor, textColor),
            ),
          );
        }
      } else if (value is Map) {
        final map = value as Map<String, dynamic>;
        if (map.isEmpty) continue;
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: _buildNestedSection(fullLabel, map, labelColor, textColor, isDarkTheme),
          ),
        );
      }
    }

    return widgets;
  }

  /// Render a nested object as a labeled sub-section
  Widget _buildNestedSection(
    String title,
    Map<String, dynamic> data,
    Color labelColor,
    Color textColor,
    bool isDarkTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.bold)),
        SizedBox(height: UIConstants.spacingXs),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Wrap(
            spacing: UIConstants.spacingXl,
            runSpacing: UIConstants.spacingXs,
            children: data.entries.where((e) => e.value != null).map((e) {
              final v = e.value;
              if (v is Map) {
                return _buildNestedSection(
                  _formatFieldName(e.key),
                  v as Map<String, dynamic>,
                  labelColor,
                  textColor,
                  isDarkTheme,
                );
              } else if (v is List) {
                if (v.isEmpty) return const SizedBox.shrink();
                if (v.first is Map) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < v.length; i++)
                        _buildNestedSection(
                          '${_formatFieldName(e.key)} [${i + 1}]',
                          v[i] as Map<String, dynamic>,
                          labelColor,
                          textColor,
                          isDarkTheme,
                        ),
                    ],
                  );
                }
                return _infoField(_formatFieldName(e.key), v.map((x) => x.toString()).join(', '), labelColor, textColor);
              }
              // Try to parse strings that look like JSON objects
              if (v is String && v.trimLeft().startsWith('{')) {
                try {
                  final parsed = jsonDecode(v);
                  if (parsed is Map<String, dynamic>) {
                    return _buildNestedSection(
                      _formatFieldName(e.key),
                      parsed,
                      labelColor,
                      textColor,
                      isDarkTheme,
                    );
                  }
                } catch (_) {}
              }
              return _infoField(_formatFieldName(e.key), v.toString(), labelColor, textColor);
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Convert snake_case or camelCase field names to readable labels
  String _formatFieldName(String name) {
    var result = name.replaceAllMapped(RegExp(r'_([a-z])'), (m) => ' ${m.group(1)!.toUpperCase()}');
    result = result.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m.group(1)} ${m.group(2)}');
    if (result.isNotEmpty) {
      result = result[0].toUpperCase() + result.substring(1);
    }
    return result;
  }

  Widget _infoField(String label, String value, Color labelColor, Color textColor) {
    return InkWell(
      onTap: () => _copyToClipboard(value),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: labelColor, fontSize: 10)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.copy, size: 10, color: labelColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
