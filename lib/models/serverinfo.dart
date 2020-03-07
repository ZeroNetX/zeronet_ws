class ServerInfo extends Result {
  bool ipExternal;
  PortOpened portOpened;
  String platform;
  String fileserverIp;
  int fileserverPort;
  bool torEnabled;
  String torStatus;
  bool torHasMeekBridges;
  bool torUseBridges;
  String uiIp;
  int uiPort;
  String version;
  int rev;
  double timecorrection;
  String language;
  bool debug;
  bool offline;
  List<String> plugins;
  PluginsRev pluginsRev;
  UserSettings userSettings;
  String updatesite;
  String distType;
  String libVerifyBest;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ip_external'] = this.ipExternal;
    if (this.portOpened != null) {
      data['port_opened'] = this.portOpened.toJson();
    }
    data['platform'] = this.platform;
    data['fileserver_ip'] = this.fileserverIp;
    data['fileserver_port'] = this.fileserverPort;
    data['tor_enabled'] = this.torEnabled;
    data['tor_status'] = this.torStatus;
    data['tor_has_meek_bridges'] = this.torHasMeekBridges;
    data['tor_use_bridges'] = this.torUseBridges;
    data['ui_ip'] = this.uiIp;
    data['ui_port'] = this.uiPort;
    data['version'] = this.version;
    data['rev'] = this.rev;
    data['timecorrection'] = this.timecorrection;
    data['language'] = this.language;
    data['debug'] = this.debug;
    data['offline'] = this.offline;
    data['plugins'] = this.plugins;
    if (this.pluginsRev != null) {
      data['plugins_rev'] = this.pluginsRev.toJson();
    }
    if (this.userSettings != null) {
      data['user_settings'] = this.userSettings.toJson();
    }
    data['updatesite'] = this.updatesite;
    data['dist_type'] = this.distType;
    data['lib_verify_best'] = this.libVerifyBest;
    return data;
  }
}

class PortOpened {
  bool ipv4;
  bool ipv6;

  PortOpened({
    this.ipv4,
    this.ipv6,
  });

  PortOpened.fromJson(Map<String, dynamic> json) {
    ipv4 = json['ipv4'];
    ipv6 = json['ipv6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ipv4'] = this.ipv4;
    data['ipv6'] = this.ipv6;
    return data;
  }
}

class PluginsRev {
  PluginsRev();

  PluginsRev.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class UserSettings {
  String theme;
  bool useSystemTheme;

  UserSettings({
    this.theme,
    this.useSystemTheme,
  });

  UserSettings.fromJson(Map<String, dynamic> json) {
    theme = json['theme'];
    useSystemTheme = json['use_system_theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['theme'] = this.theme;
    data['use_system_theme'] = this.useSystemTheme;
    return data;
  }
}

abstract class Result {
  Result();
  Result.fromJson();
  toJson();
}
