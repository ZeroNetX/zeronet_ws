part of '../futures.dart';

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

  ///Return: ok
  Future<Message> permissionAddFuture(String permission) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionAdd,
      params: {
        'permission': permission,
      },
    );
    return result.message!;
  }

  ///Return: ok
  Future<Message> permissionRemoveFuture(String permission) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionRemove,
      params: {
        'permission': permission,
      },
    );
    return result.message!;
  }

  ///Return: ok
  Future<Message> permissionDetailsFuture(String permission) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionDetails,
      params: {
        'permission': permission,
      },
    );
    return res.message!;
  }

  ///Return: A list of objects each representing a certificate from an identity provider.
  Future<Message?> certListFuture() async {
    final resultStr = await ZeroNetCmd.certList.callFuture();
    return resultStr.message;
  }

  ///Return: Message
  Future<Message> certSetFuture(String domain) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.certSet,
      params: {
        'domain': domain,
      },
    );
    return res.message!;
  }

  ///Return: Message
  Future<Message> channelJoinAllSiteFuture(String channel) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.channelJoinAllsite,
      params: {
        'channel': channel,
      },
    );
    return res.message!;
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

  ///Return: True (port opened) or False (port closed).
  Future<PortOpened?> serverPortcheckFuture() async {
    final resultStr = await ZeroNetCmd.serverPortcheck.callFuture();
    if (resultStr.isMessage) {
      return PortOpened.fromJson(resultStr.message!.result);
    }
    return null;
  }

  ///Return: None
  Future<PromptResult?> serverShutdownFuture({bool restart = false}) async {
    final resultStr =
        await ZeroNet.instance.cmdFuture(ZeroNetCmd.serverShutdown, params: {
      'restart': restart,
    });
    return resultStr.prompt;
  }

  ///Return: None
  Future<PromptResult?> serverUpdateFuture() async {
    final resultStr = await ZeroNetCmd.serverUpdate.callFuture();
    return resultStr.prompt;
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

  ///Return: SiteInfo list of all downloaded sites
  Future<List<SiteInfo>> siteListFuture({bool connectingSites = false}) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteList,
      params: {
        'connecting_sites': connectingSites,
      },
    );
    final result = (res.message!.result as List);
    final list = result.map((e) => SiteInfo.fromJson(e)).toList();
    return list;
  }

  ///Return: None
  Future<MessageOrError> sitePauseFuture(String address) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.sitePause,
      params: {
        'address': address,
      },
    );
    return res.toMsgOrErr;
  }

  ///Return: None
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
