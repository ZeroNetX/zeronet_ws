import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:zeronet_ws/extensions/callbacks.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  var dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  var talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  var instance = ZeroNet.instance;
  test('announcerInfo', () async {
    await instance.connect(dashboard);
    var res = await instance.announcerInfoFuture();
    var result = res?.result;
    assert(result is Map);
    assert(result['address'] == dashboard);
  });

  test('siteInfo', () async {
    var res = await instance.siteInfoFuture();
    var siteInfo = res.siteInfo;
    assert(siteInfo.address == dashboard);
  });

  test('dbQueryLoadATopic', () async {
    await instance.connect(talk, override: true);
    var topic_id = 1638782523;
    var topic_user_address = '1AmeB7f5wBfJm6iR7MRZfFh65xkJzaVCX7';
    var query = """
SELECT topic.*, topic_creator_user.value AS topic_creator_user_name, topic_creator_content.directory AS topic_creator_address, topic.topic_id || '_' || topic_creator_content.directory
AS row_topic_uri, (SELECT COUNT(*) FROM topic_vote WHERE topic_vote.topic_uri = topic.topic_id || '_' || topic_creator_content.directory)+1 AS votes
FROM topic LEFT JOIN json AS topic_creator_json ON (topic_creator_json.json_id = topic.json_id)
LEFT JOIN json AS topic_creator_content ON (topic_creator_content.directory = topic_creator_json.directory AND topic_creator_content.file_name = 'content.json')
LEFT JOIN keyvalue AS topic_creator_user ON (topic_creator_user.json_id = topic_creator_content.json_id AND topic_creator_user.key = 'cert_user_id')
WHERE topic.topic_id = "$topic_id" AND topic_creator_address = '$topic_user_address' LIMIT 1
		""";
    var res = await instance.dbQueryFuture(query, {});
    var dbQueryResult = res.result.first;
    assert(dbQueryResult['topic_id'] == topic_id);
    assert(dbQueryResult['topic_creator_address'] == topic_user_address);
    assert(
        dbQueryResult['row_topic_uri'] == '${topic_id}_' + topic_user_address);
  });

  test('dbQueryLoadTopics', () async {
    var date = DateTime.now().millisecondsSinceEpoch;
    var query = """
SELECT
  COUNT(comment_id) AS comments_num, MAX(comment.added) AS last_comment, topic.added as last_added, CASE WHEN MAX(comment.added) IS NULL THEN topic.added ELSE MAX(comment.added) END as last_action,
  topic.*,
  topic_creator_user.value AS topic_creator_user_name,
  topic_creator_content.directory AS topic_creator_address,
  topic.topic_id || '_' || topic_creator_content.directory AS row_topic_uri,
  NULL AS row_topic_sub_uri, NULL AS row_topic_sub_title, NULL AS row_topic_sub_type,
  (SELECT COUNT(*) FROM topic_vote WHERE topic_vote.topic_uri = topic.topic_id || '_' || topic_creator_content.directory)+1 AS votes,
  0 AS sticky
FROM topic
LEFT JOIN json AS topic_creator_json ON (topic_creator_json.json_id = topic.json_id)
LEFT JOIN json AS topic_creator_content ON (topic_creator_content.directory = topic_creator_json.directory AND topic_creator_content.file_name = 'content.json')
LEFT JOIN keyvalue AS topic_creator_user ON (topic_creator_user.json_id = topic_creator_content.json_id AND topic_creator_user.key = 'cert_user_id')
LEFT JOIN comment ON (comment.topic_uri = row_topic_uri AND comment.added < $date)
WHERE topic.type IS NULL AND topic.parent_topic_uri IS NULL
GROUP BY topic.topic_id, topic.json_id
HAVING last_action < $date

ORDER BY sticky DESC, last_action DESC LIMIT 31
		""";
    var res = await instance.dbQueryFuture(query, {});
    var dbQueryResult = res.result;
    assert(dbQueryResult.isNotEmpty);
    // assert(dbQueryResult['topic_id'] == topic_id);
    // assert(dbQueryResult['topic_creator_address'] == topic_user_address);
    // assert(
    //     dbQueryResult['row_topic_uri'] == '${topic_id}_' + topic_user_address);
  });

  test('Old Api', () async {
    // await ZeroNet.instance.connect(
    //   '1JP2hyjfFsNXejnYBGpDbegBXLnTXjbJz3',
    //   port: '43110',
    // );
    ZeroNet.instance.siteInfo(callback: (message) {
      SiteInfo info = SiteInfo.fromJson(
        Message.fromJson(json.decode(message)).result,
      );
      print(message);
      print('\n\n\n');
      print(info.toJson());
    });

    sleep(Duration(seconds: 10));

    // ZeroNet.instance.shutDown();

    // ZeroNet.instance.close();
  });

  test('New Api', () async {
    // await ZeroNet.instance.connect_new(
    //   '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d',
    //   port: '43110',
    // );
    ZeroNet.instance.siteInfo(callback: (message) {
      SiteInfo info = SiteInfo.fromJson(
        Message.fromJson(json.decode(message)).result,
      );
      print(message);
      print('\n\n\n');
      print(info.toJson());
    });

    sleep(Duration(seconds: 10));
    // ZeroNet.instance.shutDown();

    // ZeroNet.instance.close();
  });
}
