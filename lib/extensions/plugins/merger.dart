part of '../futures.dart';

extension MergerSiteExt on ZeroNet {
  /// Download new site
  Future<MessageOrPromptOrError> mergerSiteAddFuture(
      List<String> addresses) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.mergerSiteAdd,
      params: {
        'addresses': addresses,
      },
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  /// Delete a merged site
  Future<MessageOrError> mergerSiteDeleteFuture(String address) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.mergerSiteDelete,
      params: {
        'address': address,
      },
    );
    return resultStr.toMsgOrErr;
  }

  ///  Lists merged sites
  Future<MessageOrError> mergerSiteListFuture(bool querySiteInfo) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.mergerSiteList,
      params: {
        'query_site_info': querySiteInfo,
      },
    );
    return resultStr.toMsgOrErr;
  }
}
