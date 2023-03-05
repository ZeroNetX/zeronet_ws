import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/constants.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  const dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  const talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  const testSite = '1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw';

  final instance = ZeroNet.instance;
  test('Admin::as', () async {
    await instance.connect(dashboard);
    final res = await instance.asFuture(site: talk, cmd: ZeroNetCmd.siteInfo);
    if (res.isErr) {
      final error = res.error!.error;
      assert(error == 'Site Does Not Exist: $talk');
      return;
    }

    final result = await instance.asFuture(
      site: talk,
      cmd: ZeroNetCmd.dirList,
      arguments: ['data/users/', false],
    );

    assert(result.message!.result is List);
  });

  test('Admin::permissionAdd', () async {
    await instance.connect(dashboard);
    final res = await instance.permissionAddFuture('ADMIN');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::permissionRemove', () async {
    await instance.connect(dashboard);
    final res = await instance.permissionRemoveFuture('ADMIN');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::permissionDetails', () async {
    await instance.connect(dashboard);
    final res = await instance.permissionDetailsFuture('ADMIN');
    assert(res.isMsg);
    assert(res.message!.result is String);
  });

  test('Admin::certList', () async {
    await instance.connect(dashboard);
    final res = await instance.certListFuture();
    assert(res.isMsg);
    assert(res.message!.result is List);
    if (res.message!.result is List && res.message!.result.isNotEmpty) {
      assert(res.message!.result.first is Map);
    }
  });

  test('Admin::certSet', () async {
    await instance.connect(dashboard);
    final res = await instance.certSetFuture('zeroid.bit');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::channelJoinAllsite', () async {
    await instance.connect(dashboard);
    final res = await instance.channelJoinAllSiteFuture('siteChanged');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::serverConfigSet', () async {
    await instance.connect(dashboard);
    var res = await instance.configSetFuture('open_browser', 'False');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
    res = await instance.configSetFuture('open_browser', 'default_browser');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::serverPortCheck', () async {
    await instance.connect(dashboard);
    final res = await instance.serverPortcheckFuture();
    assert(res.isMsg);
    assert(
      res.message!.portOpened.ipv4 is bool ||
          res.message!.portOpened.ipv4 == null,
    );
    assert(
      res.message!.portOpened.ipv6 is bool ||
          res.message!.portOpened.ipv6 == null,
    );
  });

  test('Admin::serverRestart', () async {
    await instance.connect(dashboard);
    final res = await instance.serverShutdownFuture(restart: true);
    assert(res.prompt!.type == PromptType.confirm);
    assert(res.prompt!.value.params[1] == 'Restart');
  });

  test('Admin::serverShutdown', () async {
    await instance.connect(dashboard);
    final res = await instance.serverShutdownFuture();
    assert(res.prompt!.type == PromptType.confirm);
    assert(res.prompt!.value.params[1] == 'Shut down');
  });
  test('Admin::serverUpdate', () async {
    await instance.connect(dashboard);
    final res = await instance.serverUpdateFuture();
    assert(res.prompt!.type == PromptType.confirm);
  });

  test('Admin::siteCloneWithFakeSite', () async {
    await instance.connect(dashboard);
    final res = await instance.siteCloneFuture('FAKE SITE', '');
    assert(res.isErr);
    assert(res.error!.error == 'Not a site: FAKE SITE');
  });

  test('Admin::siteCloneWithAdminSite', () async {
    await instance.connect(dashboard);
    final res = await instance.siteCloneFuture(dashboard, 'template-new');
    assert(res.isMsg);
    assert(res.message!.result is Map);
    assert(res.message!.result['address'] is String);
  });

  test('Admin::siteCloneWithNonAdminSite', () async {
    await instance.connect(talk);
    final res = await instance.siteCloneFuture(dashboard, '');
    assert(res.isPrompt);
    assert(res.prompt!.type == PromptType.confirm);
    assert(res.prompt!.value.params[1] is String);
    assert(res.prompt!.value.params[1] == 'Clone');
  });

  test('Admin::siteList', () async {
    await instance.connect(dashboard);
    final res = await instance.siteListFuture();
    assert(res.message!.result.isNotEmpty);
  });

  test('Admin::sitePause', () async {
    await instance.connect(dashboard);
    final res = await instance.sitePauseFuture(talk);
    assert(res.isMsg);
    assert(res.message!.result == 'Paused');
  });

  test('Admin::siteResume', () async {
    await instance.connect(dashboard);
    final res = await instance.siteResumeFuture(talk);
    assert(res.isMsg);
    assert(res.message!.result == 'Resumed');
  });
}
