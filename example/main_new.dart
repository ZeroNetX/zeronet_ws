import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:zeronet_ws/extensions/callbacks.dart';
import 'package:zeronet_ws/models/message.dart';
import 'package:zeronet_ws/models/siteinfo.dart';
import 'package:zeronet_ws/zeronet_ws.dart';
import 'package:zeronet_ws/zeronet_ws_rust.dart';

IOWebSocketChannel? socket;

main(List<String> args) async {
  await ZeroNet.instance.connect_new(
    '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d',
    port: '42110',
  );
  ZeroNet.instance.siteInfo(callback: (message) {
    SiteInfo info = SiteInfo.fromJson(
      Message.fromJson(json.decode(message)).result,
    );
    print(message);
    print('\n\n\n');
    print(info.toJson());
  });

  // ZeroNet.instance.shutDown();

  // ZeroNet.instance.close();
}
