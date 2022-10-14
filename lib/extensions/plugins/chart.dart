part of '../futures.dart';

extension ChartExt on ZeroNet {
  Future<MessageOrError> chartDbQueryFuture(
    String query, {
    Map? sqlparams,
  }) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.chartDbQuery,
      params: {
        'query': query,
        'params': sqlparams,
      },
    );
    return res.toMsgOrErr;
  }

  ///Return: A list of unique peers.
  Future<Message> chartGetPeerLocationsFuture() async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.chartGetPeerLocations,
    );
    return res.message!;
  }
}
