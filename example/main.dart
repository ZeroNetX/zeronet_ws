import 'package:zeronet_ws/extensions/futures.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

main(List<String> args) async {
  await ZeroNet.instance.connect('1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d');
  var infoMsg = await ZeroNet.instance.siteInfoFuture();
  print(infoMsg.cmd);
  print(infoMsg.id);
  print(infoMsg.result);

  var annInfo = await ZeroNet.instance.announcerInfoFuture();
  print(annInfo.cmd);
  print(annInfo.id);
  print(annInfo.result);
}
