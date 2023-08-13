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

import '../models/models.dart';
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

  WebSocketChannel? wrapperChannel;
  StreamSubscription<dynamic>? wrapperSubscription;
  int iW = 1000000;

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
    this.onEventMessage ??= onEventMessage;
    if (override) {
      channel = WebSocketChannel.connect(uri);
      subscription = channel!.stream.listen(null);
      if (onEventMessage != null) this.onEventMessage = onEventMessage;
    }
    return channel;
  }

  @override
  Future<void> connectWrapper(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
  }) async {
    var uri = Uri.parse(
      'ws://$ip:$port/ZeroNet-Internal/Websocket?wrapper_key=$wrapperKey',
    );
    wrapperChannel ??= WebSocketChannel.connect(uri);
    wrapperSubscription ??= wrapperChannel!.stream.listen(null);
  }

  @override
  Future<ResponseResult> cmdFuture(
    String cmdStr, {
    params = const {},
    bool isWrapperCmd = false,
  }) {
    if (subscription == null) {
      throw Exception('Initalize ZeroNet Api First before calling any method');
    }
    Completer<ResponseResult> completer = Completer();
    cmd(
      cmdStr,
      params: params,
      isWrapperCmd: isWrapperCmd,
      callback: (message) => completer.complete(
        ResponseResult.fromJson(
          json.decode(message),
        ),
      ),
    );
    return completer.future;
  }

  @override
  void cmd(
    String cmdStr, {
    params = const {},
    int? id,
    MessageCallback? callback,
    bool isWrapperCmd = false,
  }) {
    var cmdId = isWrapperCmd ? iW++ : id ?? i++;
    try {
      if (callback != null) {
        callbacks[cmdId] = callback;
      }
      final vChannel = isWrapperCmd ? wrapperChannel : channel;
      vChannel!.sink.add(
        json.encode({
          'cmd': cmdStr,
          'params': params,
          'id': cmdId,
        }),
      );
    } catch (e) {
      if ((!isWrapperCmd && channel == null) ||
          (isWrapperCmd && wrapperChannel == null)) {
        throw 'Initalize ZeroNet Api First before calling any method';
      }
    }
    if (callback != null) {
      (isWrapperCmd ? wrapperSubscription : subscription)?.onData((message) {
        onEventMessage?.call(message);
        var msg = json.decode(message);
        var id = msg['to'];
        var cmd = msg['cmd'];
        final isConfOrNoti = ['confirm', 'notification'].contains(cmd);
        if (!callbacks.keys.contains(id) && !isConfOrNoti) return;
        if (isConfOrNoti) {
          id = msg['id'];
          // id++;
        } else if (msg['cmd'] == 'injectScript') {
          // i = msg['id'];
          i++;
        }
        callbacks[id]?.call(message);
        if (cmdStr != 'channelJoin') callbacks.remove(id);
      });
    }
  }

  @override
  void respond({
    int to = 1,
    dynamic result = 1,
    int? id,
    MessageCallback? callback,
  }) {
    var cmdId = id ?? i++;
    if (callback != null) {
      callbacks[to] = callback;
    }
    channel!.sink.add(
      json.encode(
        response(
          to: to,
          result: result,
          id: cmdId,
        ),
      ),
    );
  }

  void onMessage(message) {
    debugPrint(message);
  }

  void close() => channel!.sink.close();
}
