part of '../futures.dart';

/// Site should hold `ADMIN` permission to access these cmds.
/// Otherwise return value will an Error
extension AdminExt on ZeroNet {
  ///Return: Command's return value.
  Future<MessageOrPromptOrError> asFuture({
    required String site,
    required String cmd,
    List? arguments = const [],
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.as_,
      params: {
        'address': site,
        'cmd': cmd,
        'params': arguments,
      },
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  /// Returns: `ok` on adding permission
  Future<MessageOrError> permissionAddFuture(String permission) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionAdd,
      params: {
        'permission': permission,
      },
    );
    return result.toMsgOrErr;
  }

  ///Return: ok
  Future<MessageOrError> permissionRemoveFuture(String permission) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionRemove,
      params: {
        'permission': permission,
      },
    );
    return result.toMsgOrErr;
  }

  ///Return: ok
  Future<MessageOrError> permissionDetailsFuture(String permission) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionDetails,
      params: {
        'permission': permission,
      },
    );
    return res.toMsgOrErr;
  }

  ///Return: A list of objects each representing a certificate from an identity provider.
  Future<MessageOrError> certListFuture() async {
    final resultStr = await ZeroNetCmd.certList.callFuture();
    return resultStr.toMsgOrErr;
  }

  ///Return: Message
  Future<MessageOrError> certSetFuture(String domain) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.certSet,
      params: {
        'domain': domain,
      },
    );
    return res.toMsgOrErr;
  }

  ///Return: Message
  Future<MessageOrError> channelJoinAllSiteFuture(String channel) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.channelJoinAllsite,
      params: {
        'channel': channel,
      },
    );
    return res.toMsgOrErr;
  }

  ///Return: ok
  Future<MessageOrError> configSetFuture(String key, String value) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.configSet,
      params: {
        'key': key,
        'value': value,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Returns: MessageOrErr
  /// If result is message,
  /// you can use [portOpened] extension method to get [PortOpened]
  Future<MessageOrError> serverPortcheckFuture() async {
    final resultStr = await ZeroNetCmd.serverPortcheck.callFuture();
    return resultStr.toMsgOrErr;
  }

  ///Return: None
  Future<PromptOrError?> serverShutdownFuture({bool restart = false}) async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.serverShutdown,
      params: {
        'restart': restart,
      },
    );
    return resultStr.toPromptOrErr;
  }

  ///Return: None
  Future<PromptOrError?> serverUpdateFuture() async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.serverUpdate,
    );
    return resultStr.toPromptOrErr;
  }

  ///Return: None, automatically redirects to new site on completion
  Future<MessageOrPromptOrError> siteCloneFuture(
    String address,
    String rootInnerPath,
  ) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteClone,
      params: {
        'address': address,
        'root_inner_path': rootInnerPath,
      },
    );
    return result.toMsgOrPromptOrErr;
  }

  /// Returns: `MessageOrError`.
  ///
  /// If `response` isMsg, you can use siteList Extension method on `response.message!.siteList`
  Future<MessageOrError> siteListFuture({bool connectingSites = false}) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteList,
      params: {
        'connecting_sites': connectingSites,
      },
    );
    return res.toMsgOrErr;
  }

  /// Returns: `Paused`
  ///
  ///  or
  ///
  /// `Error` - If site is missing
  Future<MessageOrError> sitePauseFuture(String address) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.sitePause,
      params: {
        'address': address,
      },
    );
    return res.toMsgOrErr;
  }

  /// Returns: `Resumed`
  ///
  ///  or
  ///
  /// `Error` - If site is missing
  Future<MessageOrError> siteResumeFuture(String address) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteResume,
      params: {
        'address': address,
      },
    );
    return res.toMsgOrErr;
  }
}
