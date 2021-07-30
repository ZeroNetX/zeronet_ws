import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:zeronet_ws/models/message.dart';
import 'package:zeronet_ws/models/siteinfo.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

IOWebSocketChannel socket;

main(List<String> args) async {
  await ZeroNet.instance.connect('1HeLLo4uzjaLetFx6NH3PMwFP3qbRbTf3D');
  ZeroNet.instance.siteInfo(callback: (message) {
    SiteInfo info = SiteInfo.fromJson(
      Message.fromJson(json.decode(message)).result,
    );
    print(message);
    print('\n\n\n');
    print(info.toJson());
  });

  ZeroNet.instance.shutDown();

  // ZeroNet.instance.close();
}
