import 'dart:async';
import 'package:zeronet_ws/models/message.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

import '../constants.dart';

extension UiServerExt on ZeroNet {
  void announcerInfo({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.announcerInfo,
        callback: callback ?? onMessage,
      );

  void certAdd(
    String domain,
    String auth_type,
    String auth_user_name,
    String cert, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.certAdd,
        params: {
          'domain': domain,
          'auth_type': auth_type,
          'auth_user_name': auth_user_name,
          'cert': cert,
        },
        callback: callback ?? onMessage,
      );

  void certSelect({
    List<String>? accepted_domains,
    String? accept_any,
    String? accepted_pattern,
    MessageCallback? callback,
  }) {
    var params = {};
    if (accepted_domains != null) {
      params['accepted_domains'] = accepted_domains;
    }
    if (accept_any != null) params['accept_any'] = accept_any;
    if (accepted_pattern != null) params['accepted_pattern'] = accepted_pattern;

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
    String inner_path, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.dirList,
        params: {
          'inner_path': inner_path,
        },
        callback: callback ?? onMessage,
      );

  void fileDelete(
    String inner_path, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileDelete,
        params: {
          'inner_path': inner_path,
        },
        callback: callback ?? onMessage,
      );

  void fileGet(
    String inner_path, {
    bool required = true,
    String format = 'text',
    int timeout = 300,
    MessageCallback? callback,
  }) {
    ZeroNet.instance.cmd(
      ZeroNetCmd.fileGet,
      params: {
        'inner_path': inner_path,
        'required': required,
        'format': format,
        'timeout': timeout,
      },
      callback: callback ?? onMessage,
    );
  }

  void fileList(
    String inner_path, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileList,
        params: {
          'inner_path': inner_path,
        },
        callback: callback ?? onMessage,
      );

  void fileNeed(
    String inner_path, {
    int timeout = 300,
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileNeed,
        params: {
          'inner_path': inner_path,
          'timeout': timeout,
        },
        callback: callback ?? onMessage,
      );

  void fileQuery(
    String dir_inner_path, {
    String query = '',
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileQuery,
        params: {
          'dir_inner_path': dir_inner_path,
          'query': query,
        },
        callback: callback ?? onMessage,
      );

  void fileRules(
    String inner_path, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileRules,
        params: {
          'inner_path': inner_path,
        },
        callback: callback ?? onMessage,
      );

  void fileWrite(
    String inner_path,
    String content_base64, {
    MessageCallback? callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.fileWrite,
        params: {
          'inner_path': inner_path,
          'content_base64': content_base64,
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
    String? inner_path,
    bool sign = true,
    MessageCallback? callback,
  }) {
    var params = {};
    if (privatekey != null) params['privatekey'] = privatekey;
    if (inner_path != null) params['inner_path'] = inner_path;
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
    String? inner_path,
    bool remove_missing_optional = false,
    MessageCallback? callback,
  }) {
    var params = {};
    if (inner_path != null) params['inner_path'] = inner_path;
    params['privatekey'] = privatekey;
    params['remove_missing_optional'] = remove_missing_optional;
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

  void siteClone(String address, String root_inner_path) =>
      ZeroNet.instance.cmd(ZeroNetCmd.siteClone, params: {
        'address': address,
        'root_inner_path': root_inner_path,
      });

  void siteList({MessageCallback? callback}) => ZeroNet.instance.cmd(
        ZeroNetCmd.siteList,
        callback: callback ?? onMessage,
      );

  void sitePause(String address) =>
      ZeroNet.instance.cmd(ZeroNetCmd.sitePause, params: {'address': address});

  void siteResume(String address) =>
      ZeroNet.instance.cmd(ZeroNetCmd.siteResume, params: {'address': address});
}
