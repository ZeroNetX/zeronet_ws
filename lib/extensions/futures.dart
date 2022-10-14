// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../models/models.dart';
import '../zeronet_ws.dart';

part 'futures/ui_server.dart';

extension AdminExt on ZeroNet {
  ///Return: Command's return value.
  Future<MessageOrPromptOrError> asFuture({
    required String site,
    required String cmd,
    List? arguments,
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
    String root_inner_path,
  ) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteClone,
      params: {
        'address': address,
        'root_inner_path': root_inner_path,
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
