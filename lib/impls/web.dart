// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show document, Location, promiseToFutureAsMap;
import 'bindings.dart' as bindings;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../interface.dart';

/// A web implementation of the ZeronetWsPlatform of the ZeronetWs plugin.
class ZeroNetWSWeb extends ZeroNetWSInterface {
  /// Constructs a ZeroNetWSWeb
  ZeroNetWSWeb();

  String? _wrapperKey;

  static void registerWith(Registrar registrar) {
    ZeroNetWSInterface.instance = ZeroNetWSWeb();
  }

  @override
  Future<String?> getWrapperKey(String url, {bool override = false}) {
    if (_wrapperKey != null && !override) return Future.value(_wrapperKey);
    final url = (html.document.window?.location as html.Location?)?.href;
    final wrapperKey = url?.split('wrapper_key=').last;
    _wrapperKey = wrapperKey;
    return Future.value(wrapperKey);
  }

  @override
  void cmd(
    String cmdStr, {
    params = const {},
    int? id,
    MessageCallback? callback,
  }) =>
      bindings.cmd(cmdStr, params);

  @override
  Future<Map<String, dynamic>?> cmdFuture(
    String cmdStr, {
    dynamic params = const {},
  }) async {
    final result = await html.promiseToFutureAsMap(bindings.cmdp(cmdStr));
    final value = {'cmd': cmdStr, 'id': -1, 'result': result};
    return value;
  }
}
