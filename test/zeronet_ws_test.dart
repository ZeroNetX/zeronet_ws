import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  var dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  var talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  var instance = ZeroNet.instance;
  test('announcerInfo', () async {
    await instance.connect(dashboard);
    final res = await instance.announcerInfoFuture();
    final result = res?.result;
    assert(result is Map);
    assert(result['address'] == dashboard);
  });

  test('certAdd', () async {
    await instance.connect(talk);
    final res = await instance.certAddFuture(
      'zeroid.bit',
      'web',
      'usertesting',
      'Gze3JrN+NNSZblwFwg9NQf9/HIvAjkDSB1ES7nQUiuM8DLAASZ7Lg5fSQTG4l7jYxxszZxMrb+giYtCCwunKEWI=',
    );
    assert(res.isMsg || res.isPrompt || res.isErr);
    if (res.isMsg) {
      final res_ = res.message?.result;
      assert(res_ == 'ok' || res_ == 'Not changed');
    } else if (res.isErr) {
      assert(res.error?.error != null);
    } else {
      assert(res.isPrompt);
    }
  });

  test('certSelect', () async {
    Future<bool> certSelectFuture() async {
      final completer = Completer<bool>();
      await instance.connect(talk, onEventMessage: (msg) {
        final res = ResponseResult.fromJson(json.decode(msg));
        assert(res.isPrompt || res.type == ResponseType.unknown);
        if (res.type == ResponseType.unknown) {
          assert(res.json['cmd'] == 'injectScript');
          completer.complete(true);
        }
      });
      await instance.certSelectFuture();
      return await completer.future;
    }

    final res = await certSelectFuture();
    assert(res == true);
  });
}
