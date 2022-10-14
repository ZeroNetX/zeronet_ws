part of '../futures.dart';

extension ContentFilterExt on ZeroNet {
  ///Return: "ok" if confirmed.
  Future<MessageOrPrompt> muteAddFuture(
    String authAddress,
    String certUserId,
    String reason,
  ) async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteAdd,
      params: {
        'auth_address': authAddress,
        'cert_user_id': certUserId,
        'reason': reason,
      },
    );
    return resultStr.toMsgOrPrompt;
  }

  ///Return: "ok" if confirmed.
  Future<MessageOrPrompt> muteRemoveFuture(String authAddress) async {
    final resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteRemove,
      params: {
        'auth_address': authAddress,
      },
    );
    return resultStr.toMsgOrPrompt;
  }

  ///Return: Array of muted users.
  Future<Message> muteListFuture() async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteList,
    );
    return resultStr.message!;
  }

  Future<Message> filterIncludeAddFuture({
    required String innerPath,
    String? address,
    String? description,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.filterIncludeAdd,
      params: {
        'inner_path': innerPath,
        'address': address,
        'description': description,
      },
    );
    return resultStr.message!;
  }

  Future<Message> filterIncludeRemoveFuture({
    required String innerPath,
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.filterIncludeRemove,
      params: {
        'inner_path': innerPath,
        'address': address,
      },
    );
    return resultStr.message!;
  }

  Future<Message> filterIncludeListFuture({
    bool allSites = false,
    bool filters = false,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.filterIncludeList,
      params: {
        'all_sites': allSites,
        'filters': filters,
      },
    );
    return resultStr.message!;
  }
}

extension ContentFilterAdmin on ZeroNet {
  Future<MessageOrError> siteblockIgnoreAddSiteFuture(String siteAddr) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteblockIgnoreAddSite,
      params: {
        'site_address': siteAddr,
      },
    );
    return resultStr.toMsgOrErr;
  }

  Future<Message> siteblockAddFuture(String siteAddr, {String? reason}) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteblockAdd,
      params: {
        'site_address': siteAddr,
        'reason': reason,
      },
    );
    return resultStr.message!;
  }

  Future<Message> siteblockRemoveFuture(String siteAddr,
      {String? reason}) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteblockRemove,
      params: {
        'site_address': siteAddr,
        'reason': reason,
      },
    );
    return resultStr.message!;
  }

  Future<Message> siteblockListFuture() async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteblockList,
    );
    return resultStr.message!;
  }

  Future<Message> siteblockGetFuture(
    String siteAddr,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteblockGet,
    );
    return resultStr.message!;
  }
}
