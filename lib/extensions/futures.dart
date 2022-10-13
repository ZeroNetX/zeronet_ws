// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../models/models.dart';
import '../zeronet_ws.dart';

extension UiServerExt on ZeroNet {
  ///Return stats for current Site
  Future<Message?> announcerInfoFuture() async {
    var resultStr = await ZeroNetCmd.announcerInfo.callFuture();
    return resultStr.message;
  }

  ///Returns "ok", "Not changed" or {"error": error_message}.
  Future<MessageOrPromptOrError> certAddFuture(
    String domain,
    String auth_type,
    String auth_user_name,
    String cert,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.certAdd,
      params: {
        'domain': domain,
        'auth_type': auth_type,
        'auth_user_name': auth_user_name,
        'cert': cert,
      },
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  ///Return: None.
  Future<void> certSelectFuture({
    List<String>? accepted_domains,
    bool accept_any = false,
    String? accepted_pattern,
  }) async {
    var params = {};
    if (accepted_domains != null) {
      params['accepted_domains'] = accepted_domains;
    }
    params['accept_any'] = accept_any;
    if (accepted_pattern != null) params['accepted_pattern'] = accepted_pattern;

    await ZeroNet.instance.cmdFuture(ZeroNetCmd.certSelect, params: params);
  }

  ///Return: None.
  Future<Message> channelJoinFuture(List<String> channels) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.channelJoin,
      params: {
        'channels': channels,
      },
    );
    return result.message!;
  }

  ///Return: Result of the query as an array.
  Future<MessageOrError> dbQueryFuture(
    String query, [
    Map sqlparams = const {},
  ]) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.dbQuery,
      params: {
        'query': query,
        'params': sqlparams,
      },
    );
    return resultStr.toMsgOrErr;
  }

  ///Return: List of file and directory names
  Future<MessageOrError> dirListFuture(
    String inner_path, {
    bool stats = false,
  }) async {
    var resultsStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.dirList,
      params: {
        'inner_path': inner_path,
        'stats': stats,
      },
    );
    return resultsStr.toMsgOrErr;
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<MessageOrError> fileDeleteFuture(String inner_path) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileDelete,
      params: {
        'inner_path': inner_path,
      },
    );
    return resultStr.toMsgOrErr;
  }

  ///Return: The content of the file.
  Future<MessageOrError> fileGetFuture(
    String inner_path, {
    bool required_ = true,
    String format = 'text',
    int timeout = 300,
    int priority = 6,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileGet,
      params: {
        'inner_path': inner_path,
        'required': required_,
        'format': format,
        'timeout': timeout,
        'priority': priority,
      },
    );
    return resultStr.toMsgOrErr;
  }

  ///Return: List of files in the directory (recursive).
  Future<Message> fileListFuture(String inner_path) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileList,
      params: {
        'inner_path': inner_path,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: "ok" on successful download.
  Future<Message> fileNeedFuture(
    String inner_path, {
    int timeout = 300,
    int priority = 6,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileNeed,
      params: {
        'inner_path': inner_path,
        'timeout': timeout,
        'priority': priority,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: Matched content as an array.
  Future<Message> fileQueryFuture(
    String dir_inner_path, {
    String query = '',
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileQuery,
      params: {
        'dir_inner_path': dir_inner_path,
        'query': query,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: Matched content as an array.
  Future<Message> fileRulesFuture(String inner_path) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileRules,
      params: {
        'inner_path': inner_path,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<Message> fileWriteFuture(
    String inner_path,
    String content_base64, [
    bool ignore_bad_files = false,
  ]) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileWrite,
      params: {
        'inner_path': inner_path,
        'content_base64': content_base64,
        'ignore_bad_files': ignore_bad_files,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: pong
  Future<Message> pingFuture() async {
    final resultStr = await ZeroNetCmd.ping.callFuture();
    return resultStr.toMessage();
  }

  ///Return: All information about the Site as a JavaScript object.
  Future<Message> siteInfoFuture() async {
    final resultStr = await ZeroNetCmd.siteInfo.callFuture();
    return resultStr.toMessage();
  }

  //Return: All information about the server as a JavaScript object.
  Future<Message> serverInfoFuture() async {
    final resultStr = await ZeroNetCmd.serverInfo.callFuture();
    return resultStr.toMessage();
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<Message> sitePublishFuture({
    String? privatekey,
    String? inner_path,
    bool sign = true,
    bool remove_missing_optional = false,
    bool update_changed_files = false,
  }) async {
    var params = {};
    if (privatekey != null) params['privatekey'] = privatekey;
    if (inner_path != null) params['inner_path'] = inner_path;
    params['sign'] = sign;
    params['remove_missing_optional'] = remove_missing_optional;
    params['update_changed_files'] = update_changed_files;
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.sitePublish,
      params: params,
    );
    return resultStr.toMessage();
  }

  ///Return: "ok" on success
  ///TODO! Add inner_path parameter
  Future<Message> siteReloadFuture() async {
    final resultStr = await ZeroNetCmd.siteReload.callFuture();
    return resultStr.toMessage();
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<Message> siteSignFuture({
    String? privatekey,
    String? inner_path,
    bool remove_missing_optional = false,
    bool update_changed_files = false,
  }) async {
    var params = {};
    if (inner_path != null) params['inner_path'] = inner_path;
    if (privatekey != null) params['privatekey'] = privatekey;
    params['remove_missing_optional'] = remove_missing_optional;
    params['update_changed_files'] = update_changed_files;
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteSign,
      params: params,
    );
    return resultStr.toMessage();
  }

  ///Return: None.
  ///TODO! Add check_files, since, announce parameters
  Future<Message> siteUpdateFuture(String address) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteUpdate,
      params: {
        'address': address,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: The user specific site's settings saved using userSetSettings.
  Future<Message> userGetSettingsFuture() async {
    final resultStr = await ZeroNetCmd.userGetSettings.callFuture();
    return resultStr.toMessage();
  }

  ///Return: "ok" on success.
  Future<Message> userSetSettingsFuture(Map settings) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userSetSettings,
      params: {
        'settings': settings,
      },
    );
    return resultStr.toMessage();
  }
}

extension AdminExt on ZeroNet {
  ///Return: Command's return value.
  Future<Message> asFuture(
    String site,
    String cmd,
    List arguments,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.as_,
      params: {
        'address': site,
        'cmd': cmd,
        'params': arguments,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: ok
  Future<Message> permissionAddFuture(String permission) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.permissionAdd,
      params: {'permission': permission},
    );
    return result.toMessage();
  }

  ///Return: ok
  Future<void> permissionRemoveFuture(String permission) async =>
      ZeroNet.instance.cmdFuture(
        ZeroNetCmd.permissionRemove,
        params: {'permission': permission},
      );

  ///Return: ok
  Future<void> permissionDetailsFuture(String permission) async =>
      ZeroNet.instance.cmdFuture(
        ZeroNetCmd.permissionDetails,
        params: {'permission': permission},
      );

  ///Return: A list of objects each representing a certificate from an identity provider.
  Future<Message> certListFuture() async {
    final resultStr = await ZeroNetCmd.certList.callFuture();
    return resultStr.toMessage();
  }

  ///Return: None
  Future<void> certSetFuture(String domain) async => ZeroNet.instance.cmdFuture(
        ZeroNetCmd.certSet,
        params: {'domain': domain},
      );

  ///Return: None
  Future<void> channelJoinAllSiteFuture(String channel) async {
    await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.channelJoinAllsite,
      params: {'channel': channel},
    );
  }

  ///Return: ok
  Future<Message> configSetFuture(String key, String value) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.configSet,
      params: {
        'key': key,
        'value': value,
      },
    );
    return resultStr.toMessage();
  }

  ///Return: True (port opened) or False (port closed).
  Future<Message> serverPortcheckFuture() async {
    final resultStr = await ZeroNetCmd.serverPortcheck.callFuture();
    return resultStr.toMessage();
  }

  ///Return: None
  ///TODO! Add restart parameter
  Future<Message> serverShutdownFuture() async {
    final resultStr = await ZeroNetCmd.serverShutdown.callFuture();
    return resultStr.toMessage();
  }

  ///Return: None
  Future<Message> serverUpdateFuture() async {
    final resultStr = await ZeroNetCmd.serverUpdate.callFuture();
    return resultStr.toMessage();
  }

  ///Return: None, automatically redirects to new site on completion
  Future<Message> siteCloneFuture(
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
    return await respondFuture(result!['id']);
  }

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

  ///Return: SiteInfo list of all downloaded sites
  ///TODO! Add connecting_sites parameter
  Future<Message> siteListFuture() async {
    final resultStr = await ZeroNetCmd.siteList.callFuture();
    return resultStr.toMessage();
  }

  ///Return: None
  Future<void> sitePauseFuture(String address) async => await ZeroNet.instance
      .cmdFuture(ZeroNetCmd.sitePause, params: {'address': address});

  ///Return: None
  Future<void> siteResumeFuture(String address) async => await ZeroNet.instance
      .cmdFuture(ZeroNetCmd.siteResume, params: {'address': address});
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
