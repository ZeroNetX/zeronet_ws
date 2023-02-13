import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/extensions/core/utils.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  var dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  var talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  var instance = ZeroNet.instance;

  test('announcerInfo', () async {
    await instance.connect(dashboard);
    final res = await instance.announcerInfoFuture();
    final result = res?.result;
    assert(result is Map);

    assert(result['address'] == dashboard);
  });

  test('certAdd', () async {
    await instance.connect(talk);
    final res = await instance.certAddFuture(
      'test.bit',
      'app',
      'usertesting',
      'Gze3JrN+NNSZblwFwg9NQf9/HIvAjkDSB1ES7nQUiuM8DLAASZ7Lg5fSQTG4l7jYxxszZxMrb+giYtCCwunKEWI=',
    );
    assert(res.isMsg || res.isPrompt || res.isErr);
    if (res.isMsg) {
      final res_ = res.message?.result;
      assert(res_ == 'ok' || res_ == 'Not changed');
    } else if (res.isErr) {
      assert(res.error?.error != null);
    } else {
      assert(res.isPrompt);
    }
    final resReadd = await instance.certAddFuture(
      'test.bit',
      'app',
      'usertesting',
      'Gze3JrN+NNSZblwFwg9NQf9/HIvAjkDSB1ES7nQUiuM8DLAASZ7Lg5fSQTG4l7jYxxszZxMrb+giYtCCwunKEWI=',
    );
    assert(resReadd.isMsg || resReadd.isPrompt || resReadd.isErr);
    if (resReadd.isMsg) {
      final resReadd_ = resReadd.message?.result;
      assert(resReadd_ == 'ok' || resReadd_ == 'Not changed');
    } else if (resReadd.isErr) {
      assert(resReadd.error?.error != null);
    } else {
      assert(resReadd.isPrompt);
      assert(resReadd.prompt!.type == PromptType.confirm);
      final confirm = resReadd.prompt!.value as Confirm;
      final changeRes = await ZeroNet.instance.respondFuture(confirm.id);
      assert(changeRes.result == 'ok');
    }
  });

  test('certSelect', () async {
    await instance.connect(talk);
    final res = await instance.certSelectFuture();
    final certs = extractCertSelectDomains(res);
    var userId = certs.firstWhere((element) => element.domain == 'zeroid.bit');
    final domain = userId.domain;
    final vRes = await instance.respondFuture(
      (res.value as Notification).id,
      domain,
    );
    assert(vRes.result == 'ok');
  });

  test('channelJoin', () async {
    await instance.connect(dashboard);
    final res = await instance.channelJoinFuture(['sitesChanged']);
    final result = res.result;
    assert(result is String);
    assert(result == 'ok');
  });

  test('dbQueryLoadATopic', () async {
    await instance.connect(talk, override: true);
    var topicId = 1638782523;
    var topicUseraddress = '1AmeB7f5wBfJm6iR7MRZfFh65xkJzaVCX7';
    var query = """
SELECT topic.*, topic_creator_user.value AS topic_creator_user_name, topic_creator_content.directory AS topic_creator_address, topic.topic_id || '_' || topic_creator_content.directory
AS row_topic_uri, (SELECT COUNT(*) FROM topic_vote WHERE topic_vote.topic_uri = topic.topic_id || '_' || topic_creator_content.directory)+1 AS votes
FROM topic LEFT JOIN json AS topic_creator_json ON (topic_creator_json.json_id = topic.json_id)
LEFT JOIN json AS topic_creator_content ON (topic_creator_content.directory = topic_creator_json.directory AND topic_creator_content.file_name = 'content.json')
LEFT JOIN keyvalue AS topic_creator_user ON (topic_creator_user.json_id = topic_creator_content.json_id AND topic_creator_user.key = 'cert_user_id')
WHERE topic.topic_id = "$topicId" AND topic_creator_address = '$topicUseraddress' LIMIT 1
		""";
    var res = await instance.dbQueryFuture(query);
    if (res.isMsg) {
      var dbQueryResult = res.message!.result.first;
      assert(dbQueryResult['topic_id'] == topicId);
      assert(dbQueryResult['topic_creator_address'] == topicUseraddress);
      assert(dbQueryResult['row_topic_uri'] == '${topicId}_$topicUseraddress');
    }
  });

  test('dirList', () async {
    await instance.connect(talk);
    final res = await instance.dirListFuture('js');
    assert(res.isMsg);
    assert(res.message!.result != null);
    assert(res.message!.result is List);

    final result = await instance.dirListFuture('data/users/directoryNotfound');
    assert(!result.isMsg);
    assert(result.error!.error ==
        'FileNotFoundError: The system cannot find the path specified');
  });

  test('fileDelete', () async {
    await instance.connect(talk);
    final res = await instance.fileDeleteFuture('js/all.js');
    assert(!res.isMsg);
    assert(res.error != null);
    assert(res.error!.error == 'Forbidden, you can only modify your own files');
  });

  test('fileGet', () async {
    await instance.connect(talk);
    final res = await instance.fileGetFuture('js/all.js');
    assert(res.isMsg);
    assert(res.message!.result != null);
    assert(res.message!.result is String);
  });

  /// returns fileslist
  test('fileList', () async {
    await instance.connect(talk);
    final res = await instance.fileListFuture('js');
    assert(res.isMsg);
    assert(res.message!.result != null);
    assert(res.message!.result is List);
  });

  test('fileNeed', () async {
    await instance.connect(talk);
    final res = await instance.fileNeedFuture('js/all.js');
    assert(res.isMsg);
    assert(res.message!.result != null);
    assert(res.message!.result is String);
    assert(res.message!.result == 'ok');

    //'noFileNeed' file is not present, but getting 'ok';
    // final res2 = await instance.fileNeedFuture('js/noFileNeed.js');
    // assert(!res2.isMsg);
  });

  test('fileQuery', () async {
    await instance.connect(talk);
    final res = await instance.fileQueryFuture(
      'data/users/*/data.json',
      query: 'topic',
    );
    assert(res.result != null);
    assert(res.result is List);
    //  assert(false); // query ??
  });

  /// provides information about the files, file owners,
  test('fileRules', () async {
    await instance.connect(talk);
    final res = await instance.fileRulesFuture('content.json');
    assert(res.result != null);
    assert(res.result is Map);
    assert(res.result['signers'] is List);
    assert(res.result['signers'].contains(talk));
  });

//takes innerpath and base64 string to write the file
  test('fileWrite', () async {
    await instance.connect(talk);
    final res = await instance.fileWriteFuture('js/all.js', '');
    assert(res.isErr);
    assert(res.error!.error == 'Forbidden, you can only modify your own files');
  });

  test('ping', () async {
    await instance.connect(dashboard);
    final res = await instance.pingFuture();
    final result = res.result;
    assert(result is String);
    assert(result == 'pong');
  });

// returns siteInfo, siteInfo provides user auth address, site address, site content obj
// by using site content obj you can laod site default settings
  test('siteInfo', () async {
    await instance.connect(dashboard);
    var siteInfo = await instance.siteInfoFuture();
    assert(siteInfo.address.isNotEmpty);
  });

  test('siteInfoWithFilePath', () async {
    await instance.connect(dashboard);
    var siteInfo = await instance.siteInfoFuture(file_status: 'index.html');
    assert(siteInfo.address.isNotEmpty);
    assert(siteInfo.event![0] == 'file_done');
    assert(siteInfo.event![1] == 'index.html');
  });

  /// provides information about the zeronet server i.e local client
  test('serverInfo', () async {
    await instance.connect(dashboard);
    var serverInfo = await instance.serverInfoFuture();
    assert(serverInfo.version.isNotEmpty);
  });

  // this funtion is used to sign the files after file writes
  test('siteSign', () async {
    await instance.connect(dashboard);
    var res = await instance.siteSignFuture(inner_path: "content.json");
    assert(res.isErr);
  });

  //  sitePublish funcion publishes the files to the network, this is used after user file writes.
  test('sitePublish', () async {
    await instance.connect(dashboard);
    var res = await instance.sitePublishFuture(
      inner_path: 'content.json',
      sign: false,
    );
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('siteReloadFuture', () async {
    await instance.connect(dashboard);
    final res = await instance.siteReloadFuture('content.json');
    assert(res.result == 'ok');
  });

  test('siteUpdate', () async {
    await instance.connect(dashboard);
    var res = await instance.siteUpdateFuture(dashboard);

    if (res.isMsg) {
      assert(res.message!.result == 'Updated');
    } else {
      assert(res.error!.error == 'Unknown site: $dashboard');
    }
  });

  test('userGetSettings', () async {
    await instance.connect(dashboard);
    var res = await instance.userGetSettingsFuture();
    assert(res.result != null);
  });

  test('userSetSettings', () async {
    await instance.connect(dashboard);
    var settings = await instance.userGetSettingsFuture();
    var res = await instance.userSetSettingsFuture(settings.result);
    assert(res.result is String);
    assert(res.result == 'ok');
  });
}
