import 'package:flutter/material.dart';
import '../models/fix_definitions.dart';

class FixMessageForm extends StatefulWidget {
  final FixMessageDefinition messageDefinition;
  final Map<String, String> initialValues;
  final ValueChanged<Map<String, String>> onFieldChanged;
  final VoidCallback onSend;
  final List<String>? allowedFields; // Add parameter to specify which fields to show

  const FixMessageForm({
    super.key,
    required this.messageDefinition,
    this.initialValues = const {},
    required this.onFieldChanged,
    required this.onSend,
    this.allowedFields, // Optional parameter
  });

  @override
  State<FixMessageForm> createState() => _FixMessageFormState();
}

class _FixMessageFormState extends State<FixMessageForm> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _currentValues = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Filter fields based on allowedFields parameter if provided
    final filteredFields = widget.messageDefinition.fields.where((field) {
      // If allowedFields is specified, only show those fields
      if (widget.allowedFields != null) {
        return widget.allowedFields!.contains(field.name);
      }
      // Otherwise, use the default filter (exclude unwanted fields)
      return field.name != 'RawDataLength' && field.name != 'MaxMessageSize';
    }).toList();
    
    for (final field in filteredFields) {
      final initialValue = widget.initialValues[field.name] ?? '';
      
      _controllers[field.name] = TextEditingController(text: initialValue);
      _currentValues[field.name] = initialValue;
      
      _controllers[field.name]!.addListener(() {
        final newValue = _controllers[field.name]!.text;
        _currentValues[field.name] = newValue;
        widget.onFieldChanged(_currentValues);
      });
    }
    
    // Notify parent of initial values immediately after initialization
    if (_currentValues.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onFieldChanged(_currentValues);
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter fields based on allowedFields parameter if provided
    final filteredFields = widget.messageDefinition.fields.where((field) {
      // If allowedFields is specified, only show those fields
      if (widget.allowedFields != null) {
        return widget.allowedFields!.contains(field.name);
      }
      // Otherwise, use the default filter (exclude unwanted fields)
      return field.name != 'RawDataLength' && field.name != 'MaxMessageSize';
    }).toList();
    
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: filteredFields.length,
              itemBuilder: (context, index) {
                final field = filteredFields[index];
                return _buildFieldWidget(field);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0), // Reduced top and bottom padding
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onSend,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue color
                foregroundColor: Colors.white, // White text
                padding: const EdgeInsets.symmetric(vertical: 14), // Slightly reduced vertical padding
              ),
              child: Text(
                'Send ${widget.messageDefinition.name}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldWidget(FixFieldDefinition field) {
    final hasEnumValues = field.values.isNotEmpty;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Field ${field.number} • Type: ${field.type}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            
            if (field.type == 'BOOLEAN')
              _buildBooleanField(field)
            else if (hasEnumValues)
              _buildDropdownField(field)
            else
              _buildTextFormField(field),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(FixFieldDefinition field) {
    return TextFormField(
      controller: _controllers[field.name],
      decoration: InputDecoration(
        labelText: field.name,
        hintText: _getHintText(field.type),
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      keyboardType: _getKeyboardType(field.type),
    );
  }

  Widget _buildDropdownField(FixFieldDefinition field) {
    final currentValue = _currentValues[field.name] ?? '';
    
    print('DEBUG: Building dropdown for ${field.name}, currentValue: $currentValue');
    
    return DropdownButtonFormField<String>(
      value: field.values.containsKey(currentValue) ? currentValue : null,
      decoration: InputDecoration(
        labelText: field.name,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      items: [
        if (!field.required)
          const DropdownMenuItem<String>(
            value: null,
            child: Text('-- Select --'),
          ),
        ...field.values.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text('${entry.key} - ${entry.value}'),
          );
        }),
      ],
      onChanged: (value) {
        setState(() {
          _currentValues[field.name] = value ?? '';
          _controllers[field.name]!.text = value ?? '';
        });
        widget.onFieldChanged(_currentValues);
      },
    );
  }

  Widget _buildBooleanField(FixFieldDefinition field) {
    final currentValue = _currentValues[field.name];
    
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Yes (Y)'),
            value: 'Y',
            groupValue: currentValue,
            onChanged: (value) {
              setState(() {
                _currentValues[field.name] = value ?? '';
                _controllers[field.name]!.text = value ?? '';
              });
              widget.onFieldChanged(_currentValues);
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('No (N)'),
            value: 'N',
            groupValue: currentValue,
            onChanged: (value) {
              setState(() {
                _currentValues[field.name] = value ?? '';
                _controllers[field.name]!.text = value ?? '';
              });
              widget.onFieldChanged(_currentValues);
            },
          ),
        ),
      ],
    );
  }

  TextInputType _getKeyboardType(String type) {
    switch (type.toUpperCase()) {
      case 'INT':
      case 'SEQNUM':
      case 'LENGTH':
      case 'QTY':
        return TextInputType.number;
      case 'PRICE':
      case 'FLOAT':
      case 'PERCENTAGE':
      case 'AMT':
        return const TextInputType.numberWithOptions(decimal: true);
      default:
        return TextInputType.text;
    }
  }

  String _getHintText(String type) {
    switch (type.toUpperCase()) {
      case 'UTCTIMESTAMP':
        return 'YYYYMMDD-HH:MM:SS';
      case 'LOCALMKTDATE':
        return 'YYYYMMDD';
      case 'MONTHYEAR':
        return 'YYYYMM';
      case 'DAYOFMONTH':
        return 'DD';
      case 'BOOLEAN':
        return 'Y or N';
      case 'CHAR':
        return 'Single character';
      case 'CURRENCY':
        return 'USD, EUR, etc.';
      case 'EXCHANGE':
        return 'Exchange code';
      default:
        return 'Enter ${type.toLowerCase()}';
    }
  }
}
