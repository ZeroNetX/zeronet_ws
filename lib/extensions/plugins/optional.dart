part of '../futures.dart';

extension OptionalFileExt on ZeroNet {
  Future<MessageOrError> optionalFileListFuture({
    String? address,
    String orderBy = 'time_downloaded DESC',
    int limit = 10,
    String filter = 'downloaded',
    String? filterInnerPath,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFileList,
      params: {
        'address': address,
        'orderby': orderBy,
        'limit': limit,
        'filter': filter,
        'filter_inner_path': filterInnerPath,
      },
    );
    return resultStr.toMsgOrErr;
  }

  Future<Message> optionalFileInfoFuture(
    String innerPath,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFileInfo,
      params: {
        'inner_path': innerPath,
      },
    );
    return resultStr.message!;
  }

  Future<Message> optionalFilePinFuture(
    List<String> innerPaths, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFilePin,
      params: {
        'inner_path': innerPaths,
        'address': address,
      },
    );
    return resultStr.message!;
  }

  Future<Message> optionalFileUnPinFuture(
    List<String> innerPaths, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFileUnpin,
      params: {
        'inner_path': innerPaths,
        'address': address,
      },
    );
    return resultStr.message!;
  }

  Future<MessageOrError> optionalFileDeleteFuture(
    String innerPath, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFileDelete,
      params: {
        'inner_path': innerPath,
        'address': address,
      },
    );
    return resultStr.toMsgOrErr;
  }

  Future<Message> optionalLimitStatsFuture() async {
    var resultStr = await ZeroNetCmd.optionalLimitStats.callFuture();
    return resultStr.message!;
  }

  Future<Message> optionalLimitSetFuture({
    String? limit,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalLimitSet,
      params: {
        'limit': limit,
      },
    );
    return resultStr.message!;
  }

  Future<Message> optionalHelpListFuture({
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalHelpList,
      params: {
        'address': address,
      },
    );
    return resultStr.message!;
  }

  Future<Message> optionalHelpFuture(
    String directory,
    String title, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalHelp,
      params: {
        'directory': directory,
        'title': title,
        'address': address,
      },
    );
    return resultStr.message!;
  }

  Future<Message> optionalHelpRemoveFuture(
    String directory, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalHelpRemove,
      params: {
        'directory': directory,
        'address': address,
      },
    );
    return resultStr.message!;
  }

  Future<MessageOrPromptOrError> optionalHelpAllFuture(
    String value, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalHelpAll,
      params: {
        'value': value,
        'address': address,
      },
    );
    return resultStr.toMsgOrPromptOrErr;
  }
}
