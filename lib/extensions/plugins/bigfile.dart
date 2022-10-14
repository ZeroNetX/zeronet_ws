part of '../futures.dart';

extension BigFileExt on ZeroNet {
  Future<MessageOrError> bigFileUploadInitFuture(
    String innerPath,
    int size, {
    String protocol = 'xhr',
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.bigfileUploadInit,
      params: {
        'inner_path': innerPath,
        'size': size,
        'protocol': protocol,
      },
    );
    return resultStr.toMsgOrErr;
  }

  Future<MessageOrError> siteSetAutodownloadBigfileLimit(int limit) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteSetAutodownloadBigfileLimit,
      params: {
        'limit': limit,
      },
    );
    return resultStr.toMsgOrErr;
  }

  ///TODO: Check for proper working
  Future<bool> uploadFile(String url, String fileName, String filePath) async {
    MultipartRequest request = MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await MultipartFile.fromPath(
        fileName,
        filePath,
      ),
    );
    var response = await request.send();
    return response.statusCode == 200;
  }
}
