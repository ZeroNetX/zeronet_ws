part of '../futures.dart';

extension OptionalFileExt on ZeroNet {
  Future<Message> optionalFileListFuture({
    String? address,
    String orderBy = 'DESC',
    int limit = 10,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFileList,
      params: {
        'address': address,
        'orderby': orderBy,
        'limit': limit,
      },
    );
    return resultStr.toMessage();
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
    return resultStr.toMessage();
  }

  Future<Message> optionalFilePinFuture(
    String innerPath, {
    String? address,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalFilePin,
      params: {
        'inner_path': innerPath,
        'address': address,
      },
    );
    return resultStr.toMessage();
  }

  Future<Message> optionalFileDeleteFuture(
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
    return resultStr.toMessage();
  }

  Future<Message> optionalLimitStatsFuture() async {
    var resultStr = await ZeroNetCmd.optionalLimitStats.callFuture();
    return resultStr.toMessage();
  }

  Future<Message> optionalLimitSetFuture({
    String? limit,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.optionalLimitSet,
      params: {
        'address': limit,
      },
    );
    return resultStr.toMessage();
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
    return resultStr.toMessage();
  }

  Future<Message> optionalHelpFuture(
    String directory, {
    String? title,
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
    return resultStr.toMessage();
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
    return resultStr.toMessage();
  }

  Future<Message> optionalHelpAllFuture(
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
    return resultStr.toMessage();
  }
}
