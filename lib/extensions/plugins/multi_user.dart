part of '../futures.dart';

extension MultiUserExt on ZeroNet {
  Future<String> userShowMasterSeedFuture() async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userShowMasterSeed,
    );
    final value = (resultStr.prompt!.value as Notification).params![1];
    final seed = value.split("0px'>")[1].split('</div><small>')[0];
    return seed;
  }

  Future<MessageOrPromptOrError> userLogoutFuture() async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userLogout,
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  Future<MessageOrError> userSetFuture(String masterAddress) async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userSet,
      params: {'master_address': masterAddress},
    );
    return resultStr.toMsgOrErr;
  }

  //TODO!: implement remaining multi_user commands
}
