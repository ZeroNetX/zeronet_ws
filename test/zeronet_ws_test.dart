import 'package:test/test.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  test('adds one to input values', () async {
    var zero = await ZeroNet.instance
        .connect('127.0.0.1:43110', '1HeLLo4uzjaLetFx6NH3PMwFP3qbRbTf3D');
    ZeroNet.instance.cmd('serverInfo');
  });
}
