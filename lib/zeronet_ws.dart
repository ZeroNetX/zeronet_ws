library zeronet_ws;

import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:zeronet_ws/constants.dart';

import 'models/message.dart';

typedef void MessageCallback(message);

class ZeroNet {
  static String wrapperKey = '';
  Client client = Client();
  bool invoked = false;
  bool isListening = false;
  IOWebSocketChannel channel;
  static ZeroNet _instance;

  ZeroNet._();

  static ZeroNet get instance => _instance = _instance ?? ZeroNet._();

  static bool get isInitialised => instance.channel != null;

  Future<String> getWrapperKey(String url) async {
    if (wrapperKey.isEmpty) {
      try {
        var res = await client.get(
          url,
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

  Future<IOWebSocketChannel> connect(
    String ipwithPort,
    String siteAddress,
  ) async {
    var wrapperKey =
        await instance.getWrapperKey('http://$ipwithPort/$siteAddress');
    channel ??= IOWebSocketChannel.connect(
      'ws://$ipwithPort/Websocket?wrapper_key=$wrapperKey',
    );
    return channel;
  }

  void cmd(
    String cmdStr, {
    IOWebSocketChannel channelK,
    Map params = const {},
    int id = 1,
    MessageCallback callback,
  }) {
    try {
      channel.sink.add(
        json.encode({
          'cmd': cmdStr,
          'params': params,
          'id': id,
        }),
      );
      if (!isListening) {
        isListening = true;
        channel.stream.listen(callback ?? onMessage);
      }
    } catch (e) {
      if (channel == null)
        throw 'Initalize ZeroNet Api First before calling any method';
    }
  }

  void respond({
    int to = 1,
    int result = 1,
    int id = 2,
    MessageCallback callback,
  }) {
    channel.sink.add(
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
      channel.stream.listen(callback ?? onMessage);
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

  void siteInfo({MessageCallback callback}) => ZeroNet.instance
      .cmd(ZeroNetCmd.siteInfo, callback: callback ?? onMessage);

  int i = 1;

  void shutDown({
    MessageCallback callback,
  }) =>
      ZeroNet.instance.cmd(
        ZeroNetCmd.serverShutdown,
        id: i,
        callback: callback ??
            (message) {
              Message msg = Message.fromJson(json.decode(message));
              if (msg.cmd == 'confirm' && msg.id == i) {
                ZeroNet.instance.respond();
                i = 1;
              }
            },
      );

  void close() => channel.sink.close();
}
