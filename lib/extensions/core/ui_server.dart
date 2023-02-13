part of '../futures.dart';

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
  Future<MessageOrError> fileListFuture(String inner_path) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileList,
      params: {
        'inner_path': inner_path,
      },
    );
    return resultStr.toMsgOrErr;
  }

  ///Return: "ok" on successful download.
  Future<MessageOrError> fileNeedFuture(
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
    return resultStr.toMsgOrErr;
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
    return resultStr.message!;
  }

  ///Return: Matched content as an array.
  Future<Message> fileRulesFuture(String inner_path) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.fileRules,
      params: {
        'inner_path': inner_path,
      },
    );
    return resultStr.message!;
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<MessageOrPromptOrError> fileWriteFuture(
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
    return resultStr.toMsgOrPromptOrErr;
  }

  ///Return: pong
  Future<Message> pingFuture() async {
    final resultStr = await ZeroNetCmd.ping.callFuture();
    return resultStr.message!;
  }

  //Return: All information about the site
  Future<SiteInfo> siteInfoFuture({
    String? file_status,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteInfo,
      params: {
        'file_status': file_status,
      },
    );
    return resultStr.message!.siteInfo;
  }

  //Return: All information about the server
  Future<ServerInfo> serverInfoFuture() async {
    final resultStr = await ZeroNetCmd.serverInfo.callFuture();
    return resultStr.message!.serverInfo;
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<MessageOrPromptOrError> sitePublishFuture({
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
    return resultStr.toMsgOrPromptOrErr;
  }

  ///Return: "ok" on success
  Future<Message> siteReloadFuture([String? innerPath]) async {
    final res = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteReload,
      params: {
        'inner_path': innerPath ?? 'content.json',
      },
    );
    return res.message!;
  }

  ///Return: "ok" on success, the error message otherwise.
  Future<MessageOrPromptOrError> siteSignFuture({
    String? privatekey,
    String? inner_path,
    bool remove_missing_optional = false,
    bool update_changed_files = false,
    bool response_ok = true,
  }) async {
    var params = {};
    if (inner_path != null) params['inner_path'] = inner_path;
    if (privatekey != null) params['privatekey'] = privatekey;
    params['remove_missing_optional'] = remove_missing_optional;
    params['update_changed_files'] = update_changed_files;
    params['response_ok'] = response_ok;
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.siteSign,
      params: params,
    );
    return resultStr.toMsgOrPromptOrErr;
  }

  ///Return: None.
  ///TODO! Add check_files, since, announce parameters
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

  ///Return: The user specific site's settings saved using userSetSettings.
  Future<Message> userGetSettingsFuture() async {
    final resultStr = await ZeroNetCmd.userGetSettings.callFuture();
    return resultStr.message!;
  }

  ///Return: "ok" on success.
  Future<Message> userSetSettingsFuture(Map settings) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userSetSettings,
      params: {
        'settings': settings,
      },
    );
    return resultStr.message!;
  }
}
