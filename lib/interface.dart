import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:zeronet_ws/impls/io.dart';

typedef MessageCallback = void Function(dynamic);

abstract class ZeroNetWSInterface extends PlatformInterface {
  /// Constructs a ZeroNetInterface.
  ZeroNetWSInterface() : super(token: _token);

  static final Object _token = Object();

  static ZeroNetWSInterface _instance = ZeroNetWSIO();
  static ZeroNetWSInterface get instance => _instance;

  static set instance(ZeroNetWSInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getWrapperKey(
    String url, {
    bool override = false,
  });

  Future<void> connect(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
    bool override = false,
    String? wrapperKey_,
    MessageCallback? onEventMessage,
  }) =>
      Future.value();

  Future<void> connectWrapper(
    String site, {
    String ip = '127.0.0.1',
    String port = '43110',
  }) =>
      Future.value();

  void cmd(
    String cmdStr, {
    params = const {},
    int? id,
    MessageCallback? callback,
    bool isWrapperCmd = false,
  });

  Future<Map<String, dynamic>?> cmdFuture(
    String cmdStr, {
    dynamic params = const {},
    bool isWrapperCmd = false,
  });

  void respond({
    int to = 1,
    int result = 1,
    int? id,
    MessageCallback? callback,
  });

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
}
