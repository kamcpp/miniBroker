import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../services/theme_service.dart';
import '../../services/grpcurl_helper.dart';
import '../../utils/menu_items_helper.dart';
import '../../config/ui_constants.dart';
import '../../widgets/base_page.dart';

class BrokerInfoPage extends StatefulWidget {
  const BrokerInfoPage({super.key});

  @override
  State<BrokerInfoPage> createState() => _BrokerInfoPageState();
}

class _BrokerInfoPageState extends State<BrokerInfoPage> {
  Map<String, dynamic>? _participantData;
  Map<String, dynamic>? _holdingsData;
  bool _isLoadingInfo = false;
  bool _isLoadingHoldings = false;
  String? _errorInfo;
  String? _errorHoldings;

  // Cash token info keyed by IID: {currency, divisibility}
  Map<String, Map<String, String>> _cashTokenInfo = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    _fetchParticipantInfo();
    _fetchParticipantHoldings();
  }

  Future<void> _fetchParticipantInfo() async {
    setState(() {
      _isLoadingInfo = true;
      _errorInfo = null;
    });

    try {
      final result = await GrpcurlHelper.getParticipantInfo().timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _participantData = result['output'] as Map<String, dynamic>? ?? {};
          _isLoadingInfo = false;
        });
      } else {
        setState(() {
          _errorInfo = result['output']?['error'] ?? 'Unknown error';
          _isLoadingInfo = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorInfo = 'Error: $e';
        _isLoadingInfo = false;
      });
    }
  }

  Future<void> _fetchParticipantHoldings() async {
    setState(() {
      _isLoadingHoldings = true;
      _errorHoldings = null;
    });

    try {
      final result = await GrpcurlHelper.getParticipantHoldings().timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        final output = result['output'] as Map<String, dynamic>? ?? {};
        setState(() {
          _holdingsData = output;
        });
        // Resolve cash token info for holdings asset IDs
        await _fetchCashTokenInfo(output);
        if (!mounted) return;
        setState(() {
          _isLoadingHoldings = false;
        });
      } else {
        setState(() {
          _errorHoldings = result['output']?['error'] ?? 'Unknown error';
          _isLoadingHoldings = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorHoldings = 'Error: $e';
        _isLoadingHoldings = false;
      });
    }
  }

  Future<void> _fetchCashTokenInfo(Map<String, dynamic> holdingsOutput) async {
    final portfolio = holdingsOutput['portfolio'] as Map<String, dynamic>? ?? {};
    final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};
    if (holdings.isEmpty) return;

    final info = <String, Map<String, String>>{};

    // 1. Fetch ALL cash tokens and build a lookup
    try {
      final result = await GrpcurlHelper.getCashTokenList().timeout(
        const Duration(minutes: 2),
        onTimeout: () => {'success': false, 'output': {'error': 'Cash token list timed out'}},
      );

      if (result['success'] == true) {
        final output = result['output'] as Map<String, dynamic>? ?? {};
        final cashTokens = output['cashTokens'] as List<dynamic>? ??
            output['cash_tokens'] as List<dynamic>? ?? [];

        for (final token in cashTokens) {
          final t = token as Map<String, dynamic>;
          final iid = t['iid']?.toString() ?? '';
          final currency = t['issueCurrency']?.toString() ?? t['issue_currency']?.toString() ?? '';
          final divisibility = t['issueDivisibility']?.toString() ?? t['issue_divisibility']?.toString() ?? '';
          final entry = {'currency': currency, 'divisibility': divisibility};

          if (iid.isNotEmpty) info[iid] = entry;
          if (currency.isNotEmpty) info[currency] = entry;
        }
        print('💰 Cash token info resolved: ${info.keys.toList()}');
      }
    } catch (e) {
      print('Failed to fetch cash token list: $e');
    }

    // 2. Fetch ALL security listings and build a lookup by securityId, symbol, and metadata
    final unresolvedIds = holdings.keys.where((k) => !info.containsKey(k)).toList();
    if (unresolvedIds.isNotEmpty) {
      print('🔍 Unresolved holdings after cash tokens: $unresolvedIds');
      try {
        final result = await GrpcurlHelper.getSecurityListingList(
          pageSize: 0, // get all
        ).timeout(
          const Duration(minutes: 2),
          onTimeout: () => {'success': false, 'output': {'error': 'timed out'}},
        );

        if (result['success'] == true) {
          final output = result['output'] as Map<String, dynamic>? ?? {};
          final listings = output['securityListings'] as List<dynamic>? ??
              output['security_listings'] as List<dynamic>? ?? [];

          print('📊 Fetched ${listings.length} security listings');

          // Build listing entries with divisibility derived from minPriceIncrement
          final listingEntries = <Map<String, String>>[];
          final secListingMap = <String, Map<String, String>>{};
          for (final listing in listings) {
            final l = listing as Map<String, dynamic>;
            final symbol = l['symbol']?.toString() ?? '';
            final securityId = l['securityId']?.toString() ?? l['security_id']?.toString() ?? '';
            final currency = l['currency']?.toString() ?? '';
            final securityDesc = l['securityDesc']?.toString() ?? l['security_desc']?.toString() ?? '';
            final meta = l['metadata'] as Map<String, dynamic>? ?? {};

            // Derive divisibility from minPriceIncrement (e.g. "0.01" → "2")
            final minPriceIncrement = l['minPriceIncrement']?.toString() ??
                l['min_price_increment']?.toString() ?? '';
            var divisibility = meta['issue_divisibility']?.toString() ??
                meta['divisibility']?.toString() ?? '';
            if (divisibility.isEmpty && minPriceIncrement.contains('.')) {
              divisibility = minPriceIncrement.split('.').last.length.toString();
            }

            final entry = {'currency': currency, 'divisibility': divisibility, 'symbol': symbol};
            listingEntries.add(entry);

            if (securityId.isNotEmpty) secListingMap[securityId] = entry;
            if (symbol.isNotEmpty) secListingMap[symbol] = entry;
            if (securityDesc.isNotEmpty) secListingMap[securityDesc] = entry;

            // Index by all metadata values
            for (final mk in meta.entries) {
              final mv = mk.value?.toString() ?? '';
              if (mv.isNotEmpty) secListingMap[mv] = entry;
            }
          }

          // Match unresolved holdings against the listing map
          for (final holdingKey in unresolvedIds) {
            if (secListingMap.containsKey(holdingKey)) {
              info[holdingKey] = secListingMap[holdingKey]!;
              print('📊 Resolved $holdingKey → ${info[holdingKey]}');
            } else {
              // Try matching by instrumentIid inside the holding data
              final holdingData = holdings[holdingKey] as Map<String, dynamic>? ?? {};
              final instrumentIid = holdingData['instrumentIid']?.toString() ??
                  holdingData['instrument_iid']?.toString() ?? '';
              if (instrumentIid.isNotEmpty && secListingMap.containsKey(instrumentIid)) {
                info[holdingKey] = secListingMap[instrumentIid]!;
                print('📊 Resolved $holdingKey via instrumentIid → ${info[holdingKey]}');
              } else if (listingEntries.length == 1 && unresolvedIds.length == 1) {
                // Only 1 security listing and 1 unresolved holding — match them
                info[holdingKey] = listingEntries.first;
                print('📊 Resolved $holdingKey via single-listing match → ${info[holdingKey]}');
              } else {
                print('⚠️ Could not resolve holding: $holdingKey');
              }
            }
          }
        }
      } catch (e) {
        print('Failed to fetch security listing list: $e');
      }
    }

    if (mounted) {
      setState(() {
        _cashTokenInfo = info;
      });
    }
  }

  /// Default divisibility for known fiat currencies when server doesn't return it.
  String _defaultDivisibility(String currencyCode) {
    final code = currencyCode.toUpperCase();
    final shortCode = code.length >= 3 ? code.substring(0, 3) : code;
    const zeroDivisibility = {'JPY', 'KRW', 'VND', 'CLP'};
    if (zeroDivisibility.contains(shortCode)) return '0';
    const threeDivisibility = {'BHD', 'KWD', 'OMR'};
    if (threeDivisibility.contains(shortCode)) return '3';
    return '2';
  }

  /// Format an amount using divisibility (decimal places).
  /// If the amount already contains a decimal point, just ensure correct decimal places.
  /// If it's a raw integer, divide by 10^divisibility.
  String _formatAmount(String rawAmount, String? divisibility) {
    if (divisibility == null || divisibility.isEmpty) {
      // No divisibility info — try to show as-is but with sensible formatting
      try {
        final value = double.parse(rawAmount);
        if (rawAmount.contains('.')) return rawAmount;
        return value.toStringAsFixed(0);
      } catch (_) {
        return rawAmount;
      }
    }
    try {
      final decimals = int.parse(divisibility);
      if (decimals <= 0) return rawAmount;
      final value = double.parse(rawAmount);

      if (rawAmount.contains('.')) {
        // Already a decimal — just format to correct decimal places
        return value.toStringAsFixed(decimals);
      } else {
        // Raw integer units — divide by 10^divisibility
        double divisor = 1;
        for (var i = 0; i < decimals; i++) {
          divisor *= 10;
        }
        return (value / divisor).toStringAsFixed(decimals);
      }
    } catch (_) {
      return rawAmount;
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
      menuItems: MenuItemsHelper.buildMenuItems(context, 'broker_info'),
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
                  'Broker Info',
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
                    onPressed: (_isLoadingInfo || _isLoadingHoldings) ? null : _fetchData,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Participant Info section
                    _buildParticipantInfoSection(isDarkTheme),
                    SizedBox(height: UIConstants.spacingLg),
                    // Holdings section
                    _buildHoldingsSection(isDarkTheme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantInfoSection(bool isDarkTheme) {
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final labelColor = isDarkTheme ? Colors.grey[400]! : Colors.grey[600]!;
    final cardColor = isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[100]!;

    if (_isLoadingInfo) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorInfo != null) {
      return InkWell(
        onTap: () => _copyToClipboard(_errorInfo!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(_errorInfo!, style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm))),
            const SizedBox(width: 4),
            Icon(Icons.copy, size: 10, color: Colors.red[300]),
          ],
        ),
      );
    }

    if (_participantData == null) {
      return Text('No participant data', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm));
    }

    // Render the entire response dynamically so every field is visible
    return Container(
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
          Text(
            'Participant Information',
            style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: UIConstants.spacingSm),
          ..._buildDynamicFields(_participantData!, labelColor, textColor, isDarkTheme),
        ],
      ),
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
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: _infoField(fullLabel, value.toString(), labelColor, textColor),
          ),
        );
      } else if (value is List) {
        if (value.isEmpty) continue;
        if (value.first is Map) {
          // List of objects (e.g. identifiers)
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
          // List of primitives (e.g. tags, types)
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
              return _infoField(_formatFieldName(e.key), v.toString(), labelColor, textColor);
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Convert snake_case or camelCase field names to readable labels
  String _formatFieldName(String name) {
    // Handle snake_case
    var result = name.replaceAllMapped(RegExp(r'_([a-z])'), (m) => ' ${m.group(1)!.toUpperCase()}');
    // Handle camelCase
    result = result.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m.group(1)} ${m.group(2)}');
    // Capitalize first letter
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

  Widget _buildHoldingsSection(bool isDarkTheme) {
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final labelColor = isDarkTheme ? Colors.grey[400]! : Colors.grey[600]!;
    final headerColor = isDarkTheme ? Colors.grey[400] : Colors.grey[700];
    final headerStyle = TextStyle(color: headerColor, fontSize: 10, fontWeight: FontWeight.bold);
    final cellStyle = TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm);

    if (_isLoadingHoldings) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorHoldings != null) {
      return InkWell(
        onTap: () => _copyToClipboard(_errorHoldings!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(_errorHoldings!, style: TextStyle(color: Colors.red, fontSize: UIConstants.fontSizeSm))),
            const SizedBox(width: 4),
            Icon(Icons.copy, size: 10, color: Colors.red[300]),
          ],
        ),
      );
    }

    if (_holdingsData == null) {
      return Text('No holdings data', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm));
    }

    final portfolio = _holdingsData!['portfolio'] as Map<String, dynamic>? ?? {};
    final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};

    // Collect all non-holdings fields from the response and portfolio for display
    final responseFields = Map<String, dynamic>.from(_holdingsData!);
    responseFields.remove('portfolio'); // shown separately below

    final portfolioFields = Map<String, dynamic>.from(portfolio);
    portfolioFields.remove('holdings'); // shown as grid below

    final cardColor = isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[100]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Holdings',
          style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeMd, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: UIConstants.spacingSm),

        // Response-level fields (ref_execution_id, metadata with custody_account_iid, etc.)
        if (responseFields.isNotEmpty) ...[
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
          SizedBox(height: UIConstants.spacingSm),
        ],

        // Portfolio-level fields (account_iid, generated_at_dt, metadata, etc.)
        if (portfolioFields.isNotEmpty) ...[
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
                Text('Portfolio Details', style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.bold)),
                SizedBox(height: UIConstants.spacingXs),
                ..._buildDynamicFields(portfolioFields, labelColor, textColor, isDarkTheme),
              ],
            ),
          ),
          SizedBox(height: UIConstants.spacingSm),
        ],

        // Holdings grid
        if (holdings.isEmpty)
          Text('No holdings found', style: TextStyle(color: labelColor, fontSize: UIConstants.fontSizeSm))
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: UIConstants.spacingLg,
              headingRowHeight: 32,
              dataRowMinHeight: 28,
              dataRowMaxHeight: 36,
              decoration: BoxDecoration(
                border: Border.all(color: isDarkTheme ? Colors.white12 : Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              columns: [
                DataColumn(label: Text('Asset ID', style: headerStyle)),
                DataColumn(label: Text('Currency', style: headerStyle)),
                DataColumn(label: Text('Divisibility', style: headerStyle)),
                DataColumn(label: Text('Total', style: headerStyle)),
                DataColumn(label: Text('Available', style: headerStyle)),
                DataColumn(label: Text('Locked', style: headerStyle)),
              ],
              rows: holdings.entries.map((entry) {
                final assetId = entry.key;
                final holdingData = entry.value as Map<String, dynamic>? ?? {};
                final totalUnitsRaw = holdingData['totalUnits']?.toString() ??
                    holdingData['total_units']?.toString() ?? '0';
                final stashUnits = holdingData['stashUnits'] as Map<String, dynamic>? ??
                    holdingData['stash_units'] as Map<String, dynamic>? ?? {};
                // Stash keys can be: available/locked OR LIQUID/LOCKED/TOTAL
                final availableRaw = stashUnits['available']?.toString() ??
                    stashUnits['LIQUID']?.toString() ?? totalUnitsRaw;
                final lockedRaw = stashUnits['locked']?.toString() ??
                    stashUnits['LOCKED']?.toString() ?? '0';

                // Look up currency and divisibility from resolved info
                final tokenInfo = _cashTokenInfo[assetId];
                var currency = tokenInfo?['currency'] ?? '';
                var divisibility = tokenInfo?['divisibility'] ?? '';

                // Also check if the holding itself has currency_code
                final holdingCurrency = holdingData['currencyCode']?.toString() ??
                    holdingData['currency_code']?.toString() ?? '';
                final displayCurrency = currency.isNotEmpty ? currency : holdingCurrency;

                // Default divisibility for fiat currencies when server doesn't provide it
                if (divisibility.isEmpty && displayCurrency.isNotEmpty) {
                  divisibility = _defaultDivisibility(displayCurrency);
                }

                // Format amounts using divisibility
                final totalUnits = _formatAmount(totalUnitsRaw, divisibility);
                final available = _formatAmount(availableRaw, divisibility);
                final locked = _formatAmount(lockedRaw, divisibility);

                return DataRow(cells: [
                  DataCell(_copyableCell(assetId, cellStyle)),
                  DataCell(_copyableCell(displayCurrency.isNotEmpty ? displayCurrency : '-', cellStyle)),
                  DataCell(_copyableCell(divisibility.isNotEmpty ? divisibility : '-', cellStyle)),
                  DataCell(_copyableCell(totalUnits, cellStyle)),
                  DataCell(_copyableCell(available, cellStyle)),
                  DataCell(_copyableCell(locked, cellStyle)),
                ]);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _copyableCell(String value, TextStyle style) {
    return InkWell(
      onTap: () => _copyToClipboard(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: style),
          const SizedBox(width: 4),
          Icon(Icons.copy, size: 10, color: Colors.grey[500]),
        ],
      ),
    );
  }
}
