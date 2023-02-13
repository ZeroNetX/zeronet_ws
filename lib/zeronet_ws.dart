// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/material.dart';

import 'models/models.dart';
import 'interface.dart';

export ''
    if (dart.library.io) 'impls/io.dart'
    if (dart.library.html) 'impls/web.dart';
export 'extensions/futures.dart';

class ZeroNet {
  static String wrapperKey = '';

  ZeroNet._();

  static ZeroNet? _instance;
  static ZeroNet get instance => _instance = _instance ?? ZeroNet._();

  Future<String?> getWrapperKey(String url, {bool override = false}) {
    return override || wrapperKey.isEmpty
        ? ZeroNetWSInterface.instance.getWrapperKey(url, override: override)
        : Future.value(wrapperKey);
  }

  Future<void> connect(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
    String? wrapperKey_,
    MessageCallback? onEventMessage,
  }) {
    return ZeroNetWSInterface.instance.connect(
      site,
      ip: ip,
      port: port,
      wrapperKey_: wrapperKey_,
      override: override,
      onEventMessage: onEventMessage,
    );
  }

  Future<void> connectWrapper(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
  }) async {
    return await ZeroNetWSInterface.instance.connectWrapper(
      site,
      ip: ip,
      port: port,
    );
  }

  Future<ResponseResult> cmdFuture(
    String cmdStr, {
    dynamic params = const {},
    bool isWrapperCmd = false,
  }) {
    return ZeroNetWSInterface.instance.cmdFuture(
      cmdStr,
      params: params,
      isWrapperCmd: isWrapperCmd,
    );
  }

  void respond({
    int to = 1,
    dynamic result = 1,
    int? id,
    void Function(dynamic)? callback,
  }) {
    ZeroNetWSInterface.instance.respond(
      to: to,
      result: result,
      id: id,
      callback: callback,
    );
  }

  void cmd(
    String cmdStr, {
    params = const {},
    int? id,
    MessageCallback? callback,
    bool isWrapperCmd = false,
  }) {
    return ZeroNetWSInterface.instance.cmd(
      cmdStr,
      params: params,
      id: id,
      callback: callback,
      isWrapperCmd: isWrapperCmd,
    );
  }

  void onMessage(message) {
    debugPrint(message);
  }
}
