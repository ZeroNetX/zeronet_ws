part of '../futures.dart';

extension MergerSiteExt on ZeroNet {
  ///Return: None
  Future<Message> mergerSiteAddFuture(List<String> addresses) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.mergerSiteAdd,
      params: {
        'addresses': addresses,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: None
  Future<Message> mergerSiteDeleteFuture(String address) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.mergerSiteDelete,
      params: {
        'address': address,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: None
  Future<Message> mergerSiteListFuture(bool querySiteInfo) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.mergerSiteList,
      params: {
        'query_site_info': querySiteInfo,
      },
    );
    return resultStr.toMessage();
  }
}