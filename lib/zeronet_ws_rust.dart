// import 'dart:convert';

// import 'package:http/http.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:zeronet_ws/zeronet_ws.dart';

// extension ZeroNetExt on ZeroNet {
//   Future<String> authenticate(
//     String url,
//     String site,
//   ) async {
//     if (ZeroNet.wrapperKey.isEmpty) {
//       try {
//         Client client = Client();
//         var res = await client.get(
//           Uri.parse(url + "Authenticate?address=$site"),
//           headers: {'Accept': 'text/html'},
//         );

//         var body = Utf8Decoder().convert(res.bodyBytes);
//         var i = body.indexOf('wrapper_key=');
//         var key = body.substring(i + 12);
//         return key;
//       } catch (e) {
//         throw e;
//       }
//     }
//     return ZeroNet.wrapperKey;
//   }

//   Future<WebSocketChannel?> connect_new(
//     String site, {
//     String ip = '127.0.0.1',
//     String port = '43110',
//     bool override = false,
//   }) async {
//     final wrapperKey = await ZeroNet.instance.authenticate(
//       'http://$ip:$port/',
//       site,
//     );
//     final uri = Uri.parse('ws://$ip:$port/Websocket?wrapper_key=$wrapperKey');
//     if (override)
//       channel = WebSocketChannel.connect(uri);
//     else
//       channel ??= WebSocketChannel.connect(uri);
//     return channel;
//   }
// }
