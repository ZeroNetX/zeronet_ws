part of '../futures.dart';

extension CorsExt on ZeroNet {
  ///Return: "ok" on success.
  Future<Message> corsPermissionFuture(String address) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.corsPermission,
      params: {
        'address': address,
      },
    );
    return resultStr.toMessage();
  }
}
