// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../models/models.dart';
import '../zeronet_ws.dart';

part 'core/ui_server.dart';
part 'core/admin.dart';

extension BigFileExt on ZeroNet {
  Future<Message> bigFileUploadInitFuture(
    String innerPath,
    int size,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.bigfileUploadInit,
      params: {'inner_path': innerPath, 'size': size},
    );
    return resultStr.toMessage();
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

extension CorsExt on ZeroNet {
  ///Return: "ok" on success.
  Future<Message> corsPermissionFuture(String address) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.corsPermission,
      params: {
        'address': address,
      },
    );
    return resultStr.toMessage();
  }
}

extension CryptMessageExt on ZeroNet {
  ///Return: Base64-encoded public key.
  Future<Message> userPublickeyFuture({int? index}) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userPublickey,
      params: {
        'index': index ?? 0,
      },
    );
    return resultStr.toMessage();
  }

  ///Encrypted text in base64 format or [Encrypted text in base64 format, AES key in base64 format].
  Future<Message> eciesEncryptFuture(
    String text, {
    dynamic publicKey = 0,
    bool returnAesKey = false,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.eciesEncrypt,
      params: {
        'text': text,
        'publickey': publicKey,
        'return_aes_key': returnAesKey,
      },
    );
    return resultStr.toMessage();
  }

  ///Decrypted text or array of decrypted texts (null for failed decodings).
  Future<Message> eciesDecryptFuture(
    dynamic params, {
    int privateKey = 0,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.eciesDecrypt,
      params: {
        'param': params,
        'privatekey': privateKey,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: [base64 encoded key, base64 encoded iv, base64 encoded encrypted text].
  Future<Message> aesEncryptFuture(String text, {String? key}) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.aesEncrypt,
      params: {
        'text': text,
        'key': key,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: Decoded text
  Future<Message> aesDecryptFuture(
    String? iv,
    String? encryptedText,
    String? key, {
    List<List<String>> encryptedTexts = const [],
    List<String> keys = const [],
  }) async {
    var params = [];
    if (encryptedText != null) {
      params = [iv, encryptedText, keys];
    } else {
      params = [encryptedTexts, keys];
    }
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.aesDecrypt,
      params: params,
    );
    return resultStr.toMessage();
  }

  ///Return: Decoded array of decoded texts.
  Future<Message> aesDecryptArrayFuture(
    List<String>? encryptedTexts,
    List<String>? keys,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.aesDecrypt,
      params: {
        'encrypted_texts': encryptedTexts,
        'keys': keys,
      },
    );
    return resultStr.toMessage();
  }
}

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

extension MuteExt on ZeroNet {
  ///Return: "ok" if confirmed.
  Future<Message> muteAddFuture(
    String authAddress,
    String certUserId,
    String reason,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteAdd,
      params: {
        'auth_address': authAddress,
        'cert_user_id': certUserId,
        'reason': reason,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: "ok" if confirmed.
  Future<Message> muteRemoveFuture(String authAddress) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteRemove,
      params: {
        'auth_address': authAddress,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: Array of muted users.
  Future<Message> muteListFuture() async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.muteList,
    );
    return resultStr.toMessage();
  }
}

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

extension ToMessage on String {
  Message toMessage() => Message.fromJson(json.decode(this));

  //{"cmd": "notification", "params": ["done", "New certificate added <b>app/helloworld@skynetid.bit</b>."], "id": 2}
  Notification toNotification() => Notification.fromJson(json.decode(this));

  dynamic toMsgOrNotification() {
    try {
      return ['notification', toNotification()];
    } catch (e) {
      var msg = toMessage();
      return ['message', msg];
    }
  }

  Future<ResponseResult> callFuture() async {
    return await ZeroNet.instance.cmdFuture(this);
  }
}

extension ToMessageExt on Map<String, dynamic>? {
  Message toMessage() => Message.fromJson(this ?? {});

  //{"cmd": "notification", "params": ["done", "New certificate added <b>app/helloworld@skynetid.bit</b>."], "id": 2}
  Notification toNotification() => Notification.fromJson(this ?? {});

  dynamic toMsgOrNotification() {
    try {
      return ['notification', toNotification()];
    } catch (e) {
      var msg = toMessage();
      return ['message', msg];
    }
  }
}

extension RespondExt on ZeroNet {
  Future<Message> respondFuture(int to) async {
    Completer<String> completer = Completer();
    ZeroNet.instance.respond(
      to: to,
      callback: (msg) {
        completer.complete(msg);
      },
    );
    return (await completer.future).toMessage();
  }
}
