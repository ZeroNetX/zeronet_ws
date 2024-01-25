// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constants.dart';
import '../models/models.dart';
import '../interface.dart';

class ZeroNetWSIO extends ZeroNetWSInterface {
  static void registerWith() {
    ZeroNetWSInterface.instance = ZeroNetWSIO();
  }

  static String wrapperKey = '';
  String? _masterAddress;

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

  Map<String, int> prevCmds = {};
  final cmdsNeedPatching = [
    ZeroNetCmd.certAdd,
    ZeroNetCmd.certSelect,
    //
    ZeroNetCmd.userShowMasterSeed,
  ];

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
        if (res.headers.containsKey('set-cookie') &&
            res.headers['set-cookie']!.contains('master_address=')) {
          var cookie = res.headers['set-cookie']!;
          var i = cookie.indexOf('master_address=');
          var cookieM = cookie.substring(i + 15);
          var j = cookieM.indexOf(';');
          _masterAddress = cookieM.substring(0, j);
        }
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
    Map<String, dynamic>? headers;
    if (_masterAddress != null) {
      headers = {'Cookie': 'master_address=$_masterAddress'};
    }
    channel ??= IOWebSocketChannel.connect(uri, headers: headers);
    subscription ??= channel!.stream.listen(null);
    this.onEventMessage ??= onEventMessage;
    if (override) {
      channel = IOWebSocketChannel.connect(uri, headers: headers);
      subscription = channel!.stream.listen(null);
      if (onEventMessage != null) this.onEventMessage = onEventMessage;
    }
    addCallbackHandler(wrapperCmd: true);
    addCallbackHandler();

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
    Map<String, dynamic>? headers;
    if (_masterAddress != null) {
      headers = {'Cookie': 'master_address=$_masterAddress'};
    }
    wrapperChannel ??= IOWebSocketChannel.connect(uri, headers: headers);
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
      if (cmdsNeedPatching.contains(cmdStr)) prevCmds[cmdStr] = cmdId;
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
  }

  void addCallbackHandler({bool wrapperCmd = false}) {
    (wrapperCmd ? wrapperSubscription : subscription)?.onData((message) {
      onEventMessage?.call(message);
      var msg = json.decode(message);
      var id = msg['to'];
      var cmd = msg['cmd'];
      if (cmd != 'response') {
        if (cmd == 'confirm') {
          if (message.contains('current certificate') &&
              message.contains('Change it')) {
            id = prevCmds[ZeroNetCmd.certAdd]!;
          }
        } else if (cmd == 'notification') {
          if (message.contains('"ask"') &&
              message.contains('#Select+account')) {
            id = prevCmds[ZeroNetCmd.certSelect]!;
          } else if (message.contains('"info"') &&
              message.contains('Your unique private key:')) {
            id = prevCmds[ZeroNetCmd.userShowMasterSeed]!;
          }
        } else if (cmd == 'injectScript') {
          //TODO! Check if need handling
        } else {
          return;
        }
      }
      callbacks[id]?.call(message);
      callbacks.remove(id);
    });
  }

  @override
  void respond({
    int to = 1,
    dynamic result = 1,
    int? id,
    MessageCallback? callback,
  }) {
    if (id == null) {
      if (prevCmds.keys.contains(ZeroNetCmd.certAdd)) {
        i = prevCmds[ZeroNetCmd.certAdd]!;
        prevCmds.remove(ZeroNetCmd.certAdd);
      } else if (prevCmds.keys.contains(ZeroNetCmd.certSelect)) {
        i = prevCmds[ZeroNetCmd.certSelect]!;
        prevCmds.remove(ZeroNetCmd.certSelect);
      }
    }
    final cmdId = id ?? i;
    if (callback != null) {
      callbacks[cmdId] = callback;
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
