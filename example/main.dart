import 'package:zeronet_ws/zeronet_ws.dart';

main(List<String> args) async {
  await ZeroNet.instance.connect('1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d');
  var infoMsg = await ZeroNet.instance.siteInfoFuture();
  assert(infoMsg.cmd == 'siteInfo');
  assert(infoMsg.result != null);

  var annInfo = await ZeroNet.instance.announcerInfoFuture();
  assert(annInfo.cmd == 'announcerInfo');
  assert(annInfo.result != null);
}
