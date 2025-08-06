class ConfigModel {
  final String name;
  final String ipAddress;
  final int port;
  final int hbInterval;
  final String senderCompID;
  final String targetCompID;
  final String fixVersion;
  final String dictionaryLocation;
  final String account;

  const ConfigModel({
    required this.name,
    required this.ipAddress,
    required this.port,
    required this.hbInterval,
    required this.senderCompID,
    required this.targetCompID,
    required this.fixVersion,
    required this.dictionaryLocation,
    required this.account,
  });

  ConfigModel copyWith({
    String? name,
    String? ipAddress,
    int? port,
    int? hbInterval,
    String? senderCompID,
    String? targetCompID,
    String? fixVersion,
    String? dictionaryLocation,
    String? account,
  }) {
    return ConfigModel(
      name: name ?? this.name,
      ipAddress: ipAddress ?? this.ipAddress,
      port: port ?? this.port,
      hbInterval: hbInterval ?? this.hbInterval,
      senderCompID: senderCompID ?? this.senderCompID,
      targetCompID: targetCompID ?? this.targetCompID,
      fixVersion: fixVersion ?? this.fixVersion,
      dictionaryLocation: dictionaryLocation ?? this.dictionaryLocation,
      account: account ?? this.account,
    );
  }

  @override
  String toString() {
    return 'ConfigModel{name: $name, ipAddress: $ipAddress, port: $port, hbInterval: $hbInterval, senderCompID: $senderCompID, targetCompID: $targetCompID, fixVersion: $fixVersion, dictionaryLocation: $dictionaryLocation, account: $account}';
  }
}
