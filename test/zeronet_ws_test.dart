import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  var dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  var talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  var instance = ZeroNet.instance;
  test('ping', () async {
    await instance.connect(dashboard);
    final res = await instance.pingFuture();
    final result = res.result;
    assert(result is String);
    assert(result == 'pong');
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

  test('dbQueryLoadTopics', () async {
    await instance.connect(talk, override: true);
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
    var res = await instance.dbQueryFuture(query);
    if (res is Message) {
      var dbQueryResult = res.message!.result;
      assert(dbQueryResult.isNotEmpty);
    }
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

  test('fileWrite', () async {
    await instance.connect(talk);
    final res = await instance.fileWriteFuture('js/all.js', '');
    assert(res.isErr);
    assert(res.error!.error == 'Forbidden, you can only modify your own files');
  });

  test('siteInfo', () async {
    await instance.connect(dashboard);
    final res = await instance.siteInfoFuture();
    if (res.isMsg) {
      final siteInfo = res.message!.siteInfo;
      assert(siteInfo.address.isNotEmpty);
    }
  });

  test('sitePublish', () async {
    await instance.connect(dashboard);
    var res = await instance.sitePublishFuture(
      innerPath: 'content.json',
      sign: false,
    );
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('siteSign', () async {
    await instance.connect(dashboard);
    var res = await instance.siteSignFuture(innerPath: "content.json");
    assert(res.isErr);
  });
}
