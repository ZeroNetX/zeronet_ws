library zeronet_ws;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef void MessageCallback(message);

class ZeroNet {
  static const String kCMD_RESPONSE = 'response';
  static const String kCMD_PING = 'ping';
  static const String kCMD_PONG = 'pong';

  static String wrapperKey = '';
  Client client = Client();
  bool invoked = false;
  bool isListening = false;
  WebSocketChannel? channel;
  StreamSubscription<dynamic>? subscription;
  MessageCallback? onEventMessage;
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

  Future<WebSocketChannel?> connect(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
    String? wrapperKey_,
    MessageCallback? onEventMessage,
  }) async {
    final wrapperKey = wrapperKey_ ??
        await instance.getWrapperKey(
          'http://$ip:$port/$site',
          override: override,
        );
    var uri = Uri.parse('ws://$ip:$port/Websocket?wrapper_key=$wrapperKey');
    if (override)
      channel = WebSocketChannel.connect(uri);
    else
      channel ??= WebSocketChannel.connect(uri);
    subscription = channel!.stream.listen(null);
    this.onEventMessage = onEventMessage;
    return channel;
  }

  Future<String> cmdFuture(
    String cmdStr, {
    dynamic params = const {},
  }) async {
    if (subscription == null) {
      throw Exception('Initalize ZeroNet Api First before calling any method');
    }
    Completer<String> completer = Completer();
    cmd(cmdStr, params: params, callback: (message) {
      var msg = json.decode(message);
      if (msg['cmd'] == kCMD_RESPONSE) {
        completer.complete(message);
      } else {
        completer.complete(message);
      }
    });
    // subscription?.onData((message) async {
    //   if (!completer.isCompleted) {
    //     completer.complete(message);
    //   }
    // });
    return completer.future;
  }

  var callbacks = <int, MessageCallback>{};

  void cmd(
    String cmdStr, {
    dynamic params = const {},
    int? id,
    MessageCallback? callback,
  }) {
    var cmd_id = id ?? i++;
    try {
      if (callback != null) {
        callbacks[cmd_id] = callback;
      }
      channel!.sink.add(
        json.encode({
          'cmd': cmdStr,
          'params': params,
          'id': cmd_id,
        }),
      );
    } catch (e) {
      if (channel == null)
        throw 'Initalize ZeroNet Api First before calling any method';
    }
    if (callback != null) {
      subscription?.onData((message) {
        var msg = json.decode(message);
        var id = msg['to'];
        callbacks[id]?.call(message);
        callbacks.remove(id);
        this.onEventMessage?.call(message);
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
