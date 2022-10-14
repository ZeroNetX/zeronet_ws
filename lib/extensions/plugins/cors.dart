part of '../futures.dart';

extension CorsExt on ZeroNet {
  ///Return: "ok" on success.
  Future<MessageOrPrompt> corsPermissionFuture(List<String> address) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.corsPermission,
      params: {
        'address': address,
      },
    );
    return resultStr.toMsgOrPrompt;
  }
}
