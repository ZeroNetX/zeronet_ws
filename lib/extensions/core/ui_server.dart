part of '../futures.dart';

extension UiServerExt on ZeroNet {
  /// Return stats for current Site
  Future<Message?> announcerInfoFuture() async {
    var resultStr = await ZeroNetCmd.announcerInfo.callFuture();
    return resultStr.message;
  }

  /// Returns "ok", "Not changed" or {"error": error_message}.
  Future<MessageOrPromptOrError> certAddFuture(
    String domain,
    String authType,
    String authUserName,
    String cert,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.certAdd,
      params: {
        'domain': domain,
        'auth_type': authType,
        'auth_user_name': authUserName,
        'cert': cert,
      },
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  /// Return: Prompt with list of certs available.
  Future<PromptResult> certSelectFuture({
    List<String>? acceptedDomains,
    bool acceptAny = false,
    String? acceptedPattern,
  }) async {
    var params = {};
    if (acceptedDomains != null) {
      params['accepted_domains'] = acceptedDomains;
    }
    params['accept_any'] = acceptAny;
    if (acceptedPattern != null) params['accepted_pattern'] = acceptedPattern;

    var result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.certSelect,
      params: params,
    );
    return result.toMsgOrPrompt.prompt!;
  }

  /// Return: None.
  Future<Message> channelJoinFuture(List<String> channels) async {
    final result = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.channelJoin,
      params: {
        'channels': channels,
      },
    );
    return result.message!;
  }

  /// Return: Result of the query as an array.
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

  /// Return: List of file and directory names
  Future<MessageOrError> dirListFuture(
    String innerPath, {
    bool stats = false,
  }) async {
    var resultsStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.dirList,
      params: {
        'inner_path': innerPath,
        'stats': stats,
      },
    );
    return resultsStr.toMsgOrErr;
  }

  /// Return: "ok" on success, the error message otherwise.
  Future<MessageOrError> fileDeleteFuture(String innerPath) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileDelete,
      params: {
        'inner_path': innerPath,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Return: The content of the file.
  Future<MessageOrError> fileGetFuture(
    String innerPath, {
    bool required_ = true,
    String format = 'text',
    int timeout = 300,
    int priority = 6,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileGet,
      params: {
        'inner_path': innerPath,
        'required': required_,
        'format': format,
        'timeout': timeout,
        'priority': priority,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Return: List of files in the directory (recursive).
  Future<MessageOrError> fileListFuture(String innerPath) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileList,
      params: {
        'inner_path': innerPath,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Return: "ok" on successful download.
  Future<MessageOrError> fileNeedFuture(
    String innerPath, {
    int timeout = 300,
    int priority = 6,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileNeed,
      params: {
        'inner_path': innerPath,
        'timeout': timeout,
        'priority': priority,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Return: Matched content as an array.
  Future<Message> fileQueryFuture(
    String dirInnerPath, {
    String query = '',
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileQuery,
      params: {
        'dir_inner_path': dirInnerPath,
        'query': query,
      },
    );
    return resultStr.message!;
  }

  /// Return: Matched content as an array.
  Future<Message> fileRulesFuture(String innerPath) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileRules,
      params: {
        'inner_path': innerPath,
      },
    );
    return resultStr.message!;
  }

  /// Return: "ok" on success, the error message otherwise.
  Future<MessageOrPromptOrError> fileWriteFuture(
    String innerPath,
    String contentBase64, [
    bool ignoreBadFiles = false,
  ]) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileWrite,
      params: {
        'inner_path': innerPath,
        'content_base64': contentBase64,
        'ignore_bad_files': ignoreBadFiles,
      },
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  /// Return: pong
  Future<Message> pingFuture() async {
    final resultStr = await ZeroNetCmd.ping.callFuture();
    return resultStr.message!;
  }

  /// Return: All information about the site
  /// If return value isMsg
  /// you can convert result to siteInfo with siteInfo extension method
  /// final siteInfo = result.message!.siteInfo;
  /// or using SiteInfo.fromJson() method
  /// final siteInfo = SiteInfo.fromJson(result.message!.result);
  Future<MessageOrError> siteInfoFuture({
    String? fileStatus,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteInfo,
      params: {
        'file_status': fileStatus,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Return: All information about the server
  Future<ServerInfo> serverInfoFuture() async {
    final resultStr = await ZeroNetCmd.serverInfo.callFuture();
    return resultStr.message!.serverInfo;
  }

  /// Return: "ok" on success, the error message otherwise.
  Future<MessageOrPromptOrError> sitePublishFuture({
    String? privatekey,
    String? innerPath,
    bool sign = true,
    bool removeMissingOptional = false,
    bool updateChangedFiles = false,
  }) async {
    var params = {};
    if (privatekey != null) params['privatekey'] = privatekey;
    if (innerPath != null) params['inner_path'] = innerPath;
    params['sign'] = sign;
    params['remove_missing_optional'] = removeMissingOptional;
    params['update_changed_files'] = updateChangedFiles;
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.sitePublish,
      params: params,
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  /// Return: "ok" on success
  Future<Message> siteReloadFuture([String? innerPath]) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteReload,
      params: {
        'inner_path': innerPath ?? 'content.json',
      },
    );
    return res.message!;
  }

  /// Return: "ok" on success, the error message otherwise.
  Future<MessageOrPromptOrError> siteSignFuture({
    String? privatekey,
    String? innerPath,
    bool removeMissingOptional = false,
    bool updateChangedFiles = false,
    bool responseOk = true,
  }) async {
    var params = {};
    if (innerPath != null) params['inner_path'] = innerPath;
    if (privatekey != null) params['privatekey'] = privatekey;
    params['remove_missing_optional'] = removeMissingOptional;
    params['update_changed_files'] = updateChangedFiles;
    params['response_ok'] = responseOk;
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteSign,
      params: params,
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  /// Return: MessageOrError.
  Future<MessageOrError> siteUpdateFuture(
    String address, {
    bool checkFiles = false,
    bool announce = false,
    int? since,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteUpdate,
      params: {
        'address': address,
        'check_files': checkFiles,
        'announce': announce,
        'since': since,
      },
    );
    return resultStr.toMsgOrErr;
  }

  /// Return: User specific site's settings saved using userSetSettings.
  Future<Message> userGetSettingsFuture() async {
    final resultStr = await ZeroNetCmd.userGetSettings.callFuture();
    return resultStr.message!;
  }

  /// Return: "ok" on success.
  Future<Message> userSetSettingsFuture(Map settings) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userSetSettings,
      params: {
        'settings': settings,
      },
    );
    return resultStr.message!;
  }

  /// Returns: User's global settings saved using userSetGlobalSettings(ADMIN).
  Future<Message> userGetGlobalSettingsFuture() async {
    final resultStr = await ZeroNetCmd.userGetGlobalSettings.callFuture();
    return resultStr.message!;
  }
}
