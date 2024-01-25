part of 'models.dart';

class ServerInfo extends Result {
  String version;
  int rev;
  String platform;

  String? uiIp;
  int? uiPort;
  String? fileserverIp;
  int? fileserverPort;
  PortOpened portOpened;
  bool? ipExternal;

  double? timecorrection;
  String? language;
  bool? debug;
  bool? offline;

  bool torEnabled;
  String? torStatus;
  bool torHasMeekBridges;
  bool? torUseBridges;

  List<String> plugins;
  PluginsRev pluginsRev;
  UserSettings userSettings;

  String? updatesite;
  String? distType;
  String? libVerifyBest;

  String? masterAddress;
  bool? multiUser;
  bool? multiUserAdmin;

  ServerInfo({
    required this.version,
    required this.rev,
    required this.platform,
    //
    required this.ipExternal,
    required this.portOpened,
    required this.torEnabled,
    required this.torHasMeekBridges,
    required this.plugins,
    required this.pluginsRev,
    this.fileserverIp,
    this.fileserverPort,
    this.torStatus,
    this.torUseBridges,
    this.uiIp,
    this.uiPort,
    this.timecorrection,
    this.language,
    this.debug,
    this.offline,
    required this.userSettings,
    this.updatesite,
    this.distType,
    this.libVerifyBest,
    //
    this.masterAddress,
    this.multiUser,
    this.multiUserAdmin,
  });

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    return ServerInfo(
      version: json['version'],
      rev: json['rev'],
      platform: json['platform'],
      ipExternal: json['ip_external'],
      portOpened: PortOpened.fromJson(json['port_opened'] ?? {}),
      torEnabled: json['tor_enabled'],
      torHasMeekBridges: json['tor_has_meek_bridges'],
      plugins: json['plugins'].cast<String>(),
      pluginsRev: PluginsRev.fromJson(json['plugins_rev'] ?? {}),
      fileserverIp: json['fileserver_ip'],
      fileserverPort: json['fileserver_port'],
      torStatus: json['tor_status'],
      torUseBridges: json['tor_use_bridges'],
      uiIp: json['ui_ip'],
      uiPort: json['ui_port'],
      timecorrection: json['timecorrection'],
      language: json['language'],
      debug: json['debug'],
      offline: json['offline'],
      userSettings: UserSettings.fromJson(json['user_settings'] ?? {}),
      updatesite: json['updatesite'],
      distType: json['dist_type'],
      libVerifyBest: json['lib_verify_best'],
      //
      masterAddress: json['master_address'],
      multiUser: json['multiuser'],
      multiUserAdmin: json['multiuser_admin'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ip_external'] = ipExternal;
    data['port_opened'] = portOpened.toJson();

    data['platform'] = platform;
    data['fileserver_ip'] = fileserverIp;
    data['fileserver_port'] = fileserverPort;
    data['tor_enabled'] = torEnabled;
    data['tor_status'] = torStatus;
    data['tor_has_meek_bridges'] = torHasMeekBridges;
    data['tor_use_bridges'] = torUseBridges;
    data['ui_ip'] = uiIp;
    data['ui_port'] = uiPort;
    data['version'] = version;
    data['rev'] = rev;
    data['timecorrection'] = timecorrection;
    data['language'] = language;
    data['debug'] = debug;
    data['offline'] = offline;
    data['plugins'] = plugins;
    data['plugins_rev'] = pluginsRev.toJson();
    data['user_settings'] = userSettings.toJson();

    data['updatesite'] = updatesite;
    data['dist_type'] = distType;
    data['lib_verify_best'] = libVerifyBest;

    data['master_address'] = masterAddress;
    data['multi_user'] = multiUser;
    data['multi_user_admin'] = multiUserAdmin;
    return data;
  }
}

class PortOpened {
  bool? ipv4;
  bool? ipv6;

  PortOpened({
    this.ipv4,
    this.ipv6,
  });

  PortOpened.fromJson(Map<String, dynamic> json) {
    ipv4 = json['ipv4'];
    ipv6 = json['ipv6'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ipv4'] = ipv4;
    data['ipv6'] = ipv6;
    return data;
  }
}

class PluginsRev {
  final Map<String, int> rev;
  PluginsRev(this.rev);

  factory PluginsRev.fromJson(Map<String, dynamic> json) {
    var map = <String, int>{};
    for (final key in json.keys) {
      map[key] = json[key];
    }
    return PluginsRev(map);
  }

  Map<String, dynamic> toJson() {
    return rev;
  }
}

class UserSettings {
  String? theme;
  bool? useSystemTheme;

  UserSettings({
    this.theme,
    this.useSystemTheme,
  });

  UserSettings.fromJson(Map<String, dynamic> json) {
    theme = json['theme'];
    useSystemTheme = json['use_system_theme'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['theme'] = theme;
    data['use_system_theme'] = useSystemTheme;
    return data;
  }
}

abstract class Result {
  Result();
  Result.fromJson();
  toJson();
}

extension ServerInfoMessage on Message {
  ServerInfo get serverInfo {
    return ServerInfo.fromJson(result);
  }
}
