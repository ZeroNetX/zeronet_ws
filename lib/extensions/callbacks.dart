import '../lib.dart';
import '../constants.dart';
import '../interface.dart';

extension UiServerExt on ZeroNet {
  void announcerInfo({
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.announcerInfo,
        callback: callback ?? onMessage,
      );

  void certAdd(
    String domain,
    String authType,
    String authUserName,
    String cert, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.certAdd,
        params: {
          'domain': domain,
          'auth_type': authType,
          'auth_user_name': authUserName,
          'cert': cert,
        },
        callback: callback ?? onMessage,
      );

  void certSelect({
    List<String>? acceptedDomains,
    String? acceptAny,
    String? acceptedPattern,
    MessageCallback? callback,
  }) {
    var params = {};
    if (acceptedDomains != null) {
      params['accepted_domains'] = acceptedDomains;
    }
    if (acceptAny != null) params['accept_any'] = acceptAny;
    if (acceptedPattern != null) params['accepted_pattern'] = acceptedPattern;

    ZeroNet.instance.cmd(
      ZeroNetCmd.certSelect,
      params: params,
      callback: callback ?? onMessage,
    );
  }

  void channelJoin(String channel) => ZeroNet.instance.cmd(
        ZeroNetCmd.channelJoin,
        params: {
          'channel': channel,
        },
      );

  void dbQuery(
    String query,
    Map sqlparams, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.dbQuery,
        params: {
          'query': query,
          'params': sqlparams,
        },
        callback: callback ?? onMessage,
      );

  void dirList(
    String innerPath, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.dirList,
        params: {
          'inner_path': innerPath,
        },
        callback: callback ?? onMessage,
      );

  void fileDelete(
    String innerPath, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileDelete,
        params: {
          'inner_path': innerPath,
        },
        callback: callback ?? onMessage,
      );

  void fileGet(
    String innerPath, {
    bool required = true,
    String format = 'text',
    int timeout = 300,
    MessageCallback? callback,
  }) {
    ZeroNet.instance.cmd(
      ZeroNetCmd.fileGet,
      params: {
        'inner_path': innerPath,
        'required': required,
        'format': format,
        'timeout': timeout,
      },
      callback: callback ?? onMessage,
    );
  }

  void fileList(
    String innerPath, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileList,
        params: {
          'inner_path': innerPath,
        },
        callback: callback ?? onMessage,
      );

  void fileNeed(
    String innerPath, {
    int timeout = 300,
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileNeed,
        params: {
          'inner_path': innerPath,
          'timeout': timeout,
        },
        callback: callback ?? onMessage,
      );

  void fileQuery(
    String dirInnerpath, {
    String query = '',
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileQuery,
        params: {
          'dir_inner_path': dirInnerpath,
          'query': query,
        },
        callback: callback ?? onMessage,
      );

  void fileRules(
    String innerPath, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileRules,
        params: {
          'inner_path': innerPath,
        },
        callback: callback ?? onMessage,
      );

  void fileWrite(
    String innerPath,
    String contentBase64, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileWrite,
        params: {
          'inner_path': innerPath,
          'content_base64': contentBase64,
        },
        callback: callback ?? onMessage,
      );

  void ping({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.ping,
        callback: callback ?? onMessage,
      );

  void siteInfo({int? id, MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.siteInfo,
        id: id,
        callback: callback ?? onMessage,
      );

  void serverInfo({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.serverInfo,
        callback: callback ?? onMessage,
      );

  void sitePublish({
    String? privatekey,
    String? innerPath,
    bool sign = true,
    MessageCallback? callback,
  }) {
    var params = {};
    if (privatekey != null) params['privatekey'] = privatekey;
    if (innerPath != null) params['inner_path'] = innerPath;
    params['sign'] = sign;
    ZeroNet.instance.cmd(
      ZeroNetCmd.sitePublish,
      params: params,
      callback: callback ?? onMessage,
    );
  }

  void siteReload({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.siteReload,
        callback: callback ?? onMessage,
      );

  void siteSign({
    String privatekey = 'stored',
    String? innerPath,
    bool removeMissingOptional = false,
    MessageCallback? callback,
  }) {
    var params = {};
    if (innerPath != null) params['inner_path'] = innerPath;
    params['privatekey'] = privatekey;
    params['remove_missing_optional'] = removeMissingOptional;
    ZeroNet.instance.cmd(
      ZeroNetCmd.siteSign,
      params: params,
      callback: callback ?? onMessage,
    );
  }

  void siteUpdate(
    String address, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.siteUpdate,
        params: {
          'address': address,
        },
        callback: callback ?? onMessage,
      );

  void userGetSettings({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.userGetSettings,
        callback: callback ?? onMessage,
      );

  void userSetSettings(Map settings, {MessageCallback? callback}) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.userSetSettings,
        params: {
          'settings': settings,
        },
        callback: callback ?? onMessage,
      );
}

extension AdminExt on ZeroNet {
  void as_(
    String site,
    String cmd,
    List arguments, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.as_,
        params: {
          'site': site,
          'cmd': cmd,
          'arguments': arguments,
        },
        callback: callback ?? onMessage,
      );

  void certList({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.certList,
        callback: callback ?? onMessage,
      );

  void certSet(String domain) => ZeroNet.instance.cmd(
        ZeroNetCmd.certSet,
        params: {'domain': domain},
      );

  void channelJoinAllSite(String channel) => ZeroNet.instance.cmd(
        ZeroNetCmd.channelJoinAllsite,
        params: {'channel': channel},
      );

  void configSet(String key, String value, {MessageCallback? callback}) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.configSet,
        params: {
          'key': key,
          'value': value,
        },
        callback: callback ?? onMessage,
      );

  void serverPortcheck({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.serverPortcheck,
        callback: callback ?? onMessage,
      );

  void serverShutdown() => ZeroNet.instance.cmd(ZeroNetCmd.serverShutdown);

  void serverUpdate() => ZeroNet.instance.cmd(ZeroNetCmd.serverUpdate);

  void siteClone(String address, String rootInnerPath) => ZeroNet.instance.cmd(
        ZeroNetCmd.siteClone,
        params: {
          'address': address,
          'root_inner_path': rootInnerPath,
        },
      );

  void siteList({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.siteList,
        callback: callback ?? onMessage,
      );

  void sitePause(String address) =>
      ZeroNet.instance.cmd(ZeroNetCmd.sitePause, params: {'address': address});

  void siteResume(String address) =>
      ZeroNet.instance.cmd(ZeroNetCmd.siteResume, params: {'address': address});
}
