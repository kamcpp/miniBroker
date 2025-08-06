class FixFieldDefinition {
  final String name;
  final String number;
  final String type;
  final bool required;
  final Map<String, String> values; // For enum values

  const FixFieldDefinition({
    required this.name,
    required this.number,
    required this.type,
    required this.required,
    this.values = const {},
  });

  @override
  String toString() {
    return 'FixFieldDefinition{name: $name, number: $number, type: $type, required: $required, values: $values}';
  }
}

class FixGroupDefinition {
  final String name;
  final bool required;
  final List<FixFieldDefinition> fields;
  final List<FixGroupDefinition> groups;

  const FixGroupDefinition({
    required this.name,
    required this.required,
    this.fields = const [],
    this.groups = const [],
  });

  @override
  String toString() {
    return 'FixGroupDefinition{name: $name, required: $required, fields: $fields, groups: $groups}';
  }
}

class FixMessageDefinition {
  final String name;
  final String msgType;
  final String msgCat;
  final List<FixFieldDefinition> fields;
  final List<FixGroupDefinition> groups;

  const FixMessageDefinition({
    required this.name,
    required this.msgType,
    required this.msgCat,
    this.fields = const [],
    this.groups = const [],
  });

  @override
  String toString() {
    return 'FixMessageDefinition{name: $name, msgType: $msgType, msgCat: $msgCat, fields: $fields, groups: $groups}';
  }
}
