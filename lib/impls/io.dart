// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../interface.dart';

class ZeroNetWSIO extends ZeroNetWSInterface {
  static void registerWith() {
    ZeroNetWSInterface.instance = ZeroNetWSIO();
  }

  static String wrapperKey = '';

  Client client = Client();
  WebSocketChannel? channel;
  StreamSubscription<dynamic>? subscription;
  MessageCallback? onEventMessage;

  bool isListening = false;

  int i = 1;
  final callbacks = <int, MessageCallback>{};

  final String _kCmdResponse = 'response';
  final String _kCmdPing = 'ping';
  final String _kCmdPong = 'pong';

  @override
  Future<String?> getWrapperKey(
    String url, {
    bool override = false,
  }) async {
    if (wrapperKey.isEmpty || override) {
      try {
        var res = await client.get(
          Uri.parse(url),
          headers: {'Accept': 'text/html'},
        );
        var body = res.body;
        var i = body.indexOf('wrapper_key = "');
        var bodyM = body.substring(i + 15);
        var j = bodyM.indexOf('"');
        return (i == -1 || j == -1) ? null : bodyM.substring(0, j);
      } catch (e) {
        rethrow;
      }
    } else {
      return wrapperKey;
    }
  }

  @override
  Future<void> connect(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
    String? wrapperKey_,
    MessageCallback? onEventMessage,
  }) async {
    await connectResult(
      site,
      ip: ip,
      port: port,
      override: override,
      wrapperKey_: wrapperKey_,
      onEventMessage: onEventMessage,
    );
  }

  Future<WebSocketChannel?> connectResult(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
    String? wrapperKey_,
    MessageCallback? onEventMessage,
  }) async {
    wrapperKey = (wrapperKey_ != null)
        ? wrapperKey_
        : (override || wrapperKey.isEmpty)
            ? await getWrapperKey(
                  'http://$ip:$port/$site',
                  override: override,
                ) ??
                ''
            : wrapperKey;
    assert(wrapperKey.isNotEmpty);
    var uri = Uri.parse('ws://$ip:$port/Websocket?wrapper_key=$wrapperKey');
    channel ??= WebSocketChannel.connect(uri);
    subscription ??= channel!.stream.listen(null);
    if (override) {
      channel = WebSocketChannel.connect(uri);
      subscription = channel!.stream.listen(null);
    }
    this.onEventMessage = onEventMessage;
    return channel;
  }

  @override
  Future<Map<String, dynamic>?> cmdFuture(String cmdStr, {params = const {}}) {
    if (subscription == null) {
      throw Exception('Initalize ZeroNet Api First before calling any method');
    }
    Completer<Map<String, dynamic>?> completer = Completer();
    cmd(cmdStr, params: params, callback: (message) {
      var msg = json.decode(message);
      if (msg['cmd'] == _kCmdResponse) {
        completer.complete(msg);
      } else {
        completer.complete(message);
      }
    });
    return completer.future;
  }

  @override
  void cmd(
    String cmdStr, {
    params = const {},
    int? id,
    MessageCallback? callback,
  }) {
    var cmdId = id ?? i++;
    try {
      if (callback != null) {
        callbacks[cmdId] = callback;
      }
      channel!.sink.add(
        json.encode({
          'cmd': cmdStr,
          'params': params,
          'id': cmdId,
        }),
      );
    } catch (e) {
      if (channel == null) {
        throw 'Initalize ZeroNet Api First before calling any method';
      }
    }
    if (callback != null) {
      subscription?.onData((message) {
        var msg = json.decode(message);
        var id = msg['to'];
        callbacks[id]?.call(message);
        callbacks.remove(id);
        onEventMessage?.call(message);
      });
    }
  }

  void respond({
    int to = 1,
    int result = 1,
    int id = 2,
    MessageCallback? callback,
  }) {
    channel!.sink.add(
      json.encode(
        response(
          to: to,
          result: result,
          id: id,
        ),
      ),
    );
    if (!isListening) {
      isListening = true;
      channel?.stream.listen(callback ?? onMessage);
    }
  }

  Map response({
    int to = 1,
    int result = 1,
    int id = 2,
  }) =>
      {
        'cmd': 'response',
        'to': to,
        'result': result,
        'id': id,
      };

  void onMessage(message) {
    debugPrint(message);
  }

  void close() => channel!.sink.close();
}
