library zeronet_ws;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:zeronet_ws/constants.dart';

typedef void MessageCallback(message);

class ZeroNet {
  static const String kCMD_RESPONSE = 'response';
  static const String kCMD_PING = 'ping';
  static const String kCMD_PONG = 'pong';

  static String wrapperKey = '';
  Client client = Client();
  bool invoked = false;
  bool isListening = false;
  IOWebSocketChannel? channel;
  StreamSubscription<dynamic>? subscription;
  static ZeroNet? _instance;

  ZeroNet._();

  static ZeroNet get instance => _instance = _instance ?? ZeroNet._();

  static bool get isInitialised => instance.channel != null;

  Future<String> getWrapperKey(
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
        return bodyM.substring(0, j);
      } catch (e) {
        throw e;
      }
    } else {
      return wrapperKey;
    }
  }

  Future<IOWebSocketChannel?> connect(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
  }) async {
    final wrapperKey = await instance.getWrapperKey(
      'http://$ip:$port/$site',
      override: override,
    );
    if (override)
      channel = IOWebSocketChannel.connect(
        'ws://$ip:$port/Websocket?wrapper_key=$wrapperKey',
      );
    else
      channel ??= IOWebSocketChannel.connect(
        'ws://$ip:$port/Websocket?wrapper_key=$wrapperKey',
      );
    subscription = channel!.stream.listen(null);
    return channel;
  }

  Future<String> cmdFuture(
    String cmdStr, {
    Map params = const {},
  }) async {
    if (subscription == null) {
      throw Exception('Initalize ZeroNet Api First before calling any method');
    }
    Completer<String> completer = Completer();
    cmd(cmdStr, params: params);
    subscription?.onData((message) async {
      if (!completer.isCompleted) {
        completer.complete(message);
      }
    });
    return completer.future;
  }

  void cmd(
    String cmdStr, {
    Map params = const {},
    int? id,
    MessageCallback? callback,
  }) {
    i = id ?? i++;
    try {
      channel!.sink.add(
        json.encode({
          'cmd': cmdStr,
          'params': params,
          'id': i,
        }),
      );
    } catch (e) {
      if (channel == null)
        throw 'Initalize ZeroNet Api First before calling any method';
    }
    if (callback != null) {
      subscription?.onData((message) {
        callback(message);
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
    print(message);
  }

  int i = 1;

  void close() => channel!.sink.close();
}
