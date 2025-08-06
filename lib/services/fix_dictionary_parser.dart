import 'package:xml/xml.dart';
import '../models/fix_definitions.dart';

class FixDictionaryParser {
  static Map<String, FixMessageDefinition> parseDictionary(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final messages = <String, FixMessageDefinition>{};
    
    // Parse fields first to create a lookup map
    final fieldLookup = <String, FixFieldDefinition>{};
    final fieldElements = document.findAllElements('field');
    
    for (final fieldElement in fieldElements) {
      final name = fieldElement.getAttribute('name');
      final number = fieldElement.getAttribute('number');
      final type = fieldElement.getAttribute('type');
      
      if (name != null && number != null && type != null) {
        // Parse enum values if they exist
        final values = <String, String>{};
        for (final valueElement in fieldElement.findElements('value')) {
          final enumValue = valueElement.getAttribute('enum');
          final description = valueElement.getAttribute('description');
          if (enumValue != null && description != null) {
            values[enumValue] = description;
          }
        }
        
        fieldLookup[name] = FixFieldDefinition(
          name: name,
          number: number,
          type: type,
          required: false, // Will be set per message
          values: values,
        );
      }
    }
    
    // Parse messages
    final messageElements = document.findAllElements('message');
    
    for (final messageElement in messageElements) {
      final name = messageElement.getAttribute('name');
      final msgType = messageElement.getAttribute('msgtype');
      final msgCat = messageElement.getAttribute('msgcat') ?? 'app';
      
      if (name != null && msgType != null) {
        final messageFields = <FixFieldDefinition>[];
        
        // Parse message fields
        for (final fieldElement in messageElement.findElements('field')) {
          final fieldName = fieldElement.getAttribute('name');
          final required = fieldElement.getAttribute('required') == 'Y';
          
          if (fieldName != null && fieldLookup.containsKey(fieldName)) {
            final baseField = fieldLookup[fieldName]!;
            messageFields.add(FixFieldDefinition(
              name: baseField.name,
              number: baseField.number,
              type: baseField.type,
              required: required,
              values: baseField.values,
            ));
          }
        }
        
        messages[msgType] = FixMessageDefinition(
          name: name,
          msgType: msgType,
          msgCat: msgCat,
          fields: messageFields,
        );
      }
    }
    
    return messages;
  }
}
