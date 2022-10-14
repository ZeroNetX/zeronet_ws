part of '../futures.dart';

extension ChartExt on ZeroNet {
  Future<Message> chartDbQueryFuture(String query, Map sqlparams) async {
    var msg = await ZeroNet.instance.dbQueryFuture(query, sqlparams);
    return msg;
  }

  ///Return: A list of unique peers.
  Future<Message> chartGetPeerLocationsFuture() async {
    var msg = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.chartGetPeerLocations,
    );
    return msg.toMessage();
  }
}
