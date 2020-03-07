import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:zeronet_ws/models/message.dart';
import 'package:zeronet_ws/models/siteinfo.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

IOWebSocketChannel socket;

main(List<String> args) async {
  await ZeroNet.instance
      .connect('127.0.0.1:43110', '1HeLLo4uzjaLetFx6NH3PMwFP3qbRbTf3D');
  ZeroNet.instance.siteInfo(callback: (message) {
    SiteInfo info = SiteInfo.fromJson(
      Message.fromJson(json.decode(message)).result,
    );
    print(message);
    print(info);
    ZeroNet.instance.close();
  });
}
