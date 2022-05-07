import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

extension ZeroNetExt on ZeroNet {
  Future<String> authenticate(
    String url,
    String site,
  ) async {
    if (ZeroNet.wrapperKey.isEmpty) {
      try {
        var res = await client.get(
          Uri.parse(url + "Authenticate?address=$site"),
          headers: {'Accept': 'text/html'},
        );

        var body = Utf8Decoder().convert(res.bodyBytes);
        var i = body.indexOf('wrapper_key=');
        var key = body.substring(i + 12);
        return key;
      } catch (e) {
        throw e;
      }
    }
    return ZeroNet.wrapperKey;
  }

  Future<IOWebSocketChannel?> connect_new(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
  }) async {
    final wrapperKey = await ZeroNet.instance.authenticate(
      'http://$ip:$port/',
      site,
    );
    if (override)
      channel = IOWebSocketChannel.connect(
        'ws://$ip:$port/Websocket?wrapper_key=$wrapperKey',
      );
    else
      channel ??= IOWebSocketChannel.connect(
        'ws://$ip:$port/Websocket?wrapper_key=$wrapperKey',
      );
    return channel;
  }
}
