part of 'models.dart';

class ServerInfo extends Result {
  bool? ipExternal;
  PortOpened? portOpened;
  String? platform;
  String? fileserverIp;
  int? fileserverPort;
  bool? torEnabled;
  String? torStatus;
  bool? torHasMeekBridges;
  bool? torUseBridges;
  String? uiIp;
  int? uiPort;
  String? version;
  int? rev;
  double? timecorrection;
  String? language;
  bool? debug;
  bool? offline;
  List<String>? plugins;
  PluginsRev? pluginsRev;
  UserSettings? userSettings;
  String? updatesite;
  String? distType;
  String? libVerifyBest;

  ServerInfo({
    this.ipExternal,
    this.portOpened,
    this.platform,
    this.fileserverIp,
    this.fileserverPort,
    this.torEnabled,
    this.torStatus,
    this.torHasMeekBridges,
    this.torUseBridges,
    this.uiIp,
    this.uiPort,
    this.version,
    this.rev,
    this.timecorrection,
    this.language,
    this.debug,
    this.offline,
    this.plugins,
    this.pluginsRev,
    this.userSettings,
    this.updatesite,
    this.distType,
    this.libVerifyBest,
  });

  ServerInfo.fromJson(Map<String, dynamic> json) {
    ipExternal = json['ip_external'];
    portOpened = json['port_opened'] != null
        ? PortOpened.fromJson(json['port_opened'])
        : null;
    platform = json['platform'];
    fileserverIp = json['fileserver_ip'];
    fileserverPort = json['fileserver_port'];
    torEnabled = json['tor_enabled'];
    torStatus = json['tor_status'];
    torHasMeekBridges = json['tor_has_meek_bridges'];
    torUseBridges = json['tor_use_bridges'];
    uiIp = json['ui_ip'];
    uiPort = json['ui_port'];
    version = json['version'];
    rev = json['rev'];
    timecorrection = json['timecorrection'];
    language = json['language'];
    debug = json['debug'];
    offline = json['offline'];
    plugins = json['plugins'].cast<String>();
    pluginsRev = json['plugins_rev'] != null
        ? PluginsRev.fromJson(json['plugins_rev'])
        : null;
    userSettings = json['user_settings'] != null
        ? UserSettings.fromJson(json['user_settings'])
        : null;
    updatesite = json['updatesite'];
    distType = json['dist_type'];
    libVerifyBest = json['lib_verify_best'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ip_external'] = ipExternal;
    if (portOpened != null) {
      data['port_opened'] = portOpened!.toJson();
    }
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
    if (pluginsRev != null) {
      data['plugins_rev'] = pluginsRev!.toJson();
    }
    if (userSettings != null) {
      data['user_settings'] = userSettings!.toJson();
    }
    data['updatesite'] = updatesite;
    data['dist_type'] = distType;
    data['lib_verify_best'] = libVerifyBest;
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
  PluginsRev();

  PluginsRev.fromJson(Map<String, dynamic>? json);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
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
