part of '../futures.dart';

extension MuteExt on ZeroNet {
  ///Return: "ok" if confirmed.
  Future<Message> muteAddFuture(
    String authAddress,
    String certUserId,
    String reason,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteAdd,
      params: {
        'auth_address': authAddress,
        'cert_user_id': certUserId,
        'reason': reason,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: "ok" if confirmed.
  Future<Message> muteRemoveFuture(String authAddress) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteRemove,
      params: {
        'auth_address': authAddress,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: Array of muted users.
  Future<Message> muteListFuture() async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteList,
    );
    return resultStr.toMessage();
  }
}