import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/constants.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  const dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  const talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  // const testSite = '1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw';

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

    assert(result.isMsg);

    if (result.message!.result is String) {
      assert(result.message!.result == 'No permission for site $talk');
      return;
    }

    assert(result.message!.result is List);
  });

  test('Admin::permissionAdd', () async {
    await instance.connect(dashboard);
    final res = await instance.permissionAddFuture('ADMIN');
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error == "You don't have permission to run permissionAdd");
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::permissionDetails', () async {
    await instance.connect(dashboard);
    final res = await instance.permissionDetailsFuture('ADMIN');
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error == "You don't have permission to run permissionDetails");
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result is String);
  });

  test('Admin::certList', () async {
    await instance.connect(dashboard);
    final res = await instance.certListFuture();
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error == "You don't have permission to run certList");
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result is List);
    if (res.message!.result is List && res.message!.result.isNotEmpty) {
      assert(res.message!.result.first is Map);
    }
  });

  test('Admin::certSet', () async {
    await instance.connect(dashboard);
    final res = await instance.certSetFuture('zeroid.bit');
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error == "You don't have permission to run certSet");
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::channelJoinAllsite', () async {
    await instance.connect(dashboard);
    final res = await instance.channelJoinAllSiteFuture('siteChanged');
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error == "You don't have permission to run channelJoinAllsite");
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::serverConfigSet', () async {
    await instance.connect(dashboard);
    var res = await instance.configSetFuture('open_browser', 'False');
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
    res = await instance.configSetFuture('open_browser', 'default_browser');
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });

  test('Admin::serverPortCheck', () async {
    await instance.connect(dashboard);
    final res = await instance.serverPortcheckFuture();
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
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
    if (!res.isPrompt) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.prompt!.type == PromptType.confirm);
    assert(res.prompt!.value.params[1] == 'Restart');
  });

  test('Admin::serverShutdown', () async {
    await instance.connect(dashboard);
    final res = await instance.serverShutdownFuture();
    if (!res.isPrompt) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.prompt!.type == PromptType.confirm);
    assert(res.prompt!.value.params[1] == 'Shut down');
  });
  test('Admin::serverUpdate', () async {
    await instance.connect(dashboard);
    final res = await instance.serverUpdateFuture();
    if (!res.isPrompt) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
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
    if (res.isErr) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    } else if (res.isMsg) {
      assert(res.isMsg);
      assert(res.message!.result is Map);
      assert(res.message!.result['address'] is String);
    } else if (res.isPrompt) {
      assert(res.isPrompt);
      assert(res.prompt!.type == PromptType.confirm);
      assert(res.prompt!.value.params[1] == 'Clone');
    }
  });

  test('Admin::siteCloneWithNonAdminSite', () async {
    await instance.connect(talk);
    final res = await instance.siteCloneFuture(dashboard, '');
    if (!res.isPrompt) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.isPrompt);
    assert(res.prompt!.type == PromptType.confirm);
    assert(res.prompt!.value.params[1] is String);
    assert(res.prompt!.value.params[1] == 'Clone');
  });

  test('Admin::siteList', () async {
    await instance.connect(dashboard);
    final res = await instance.siteListFuture();
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.message!.result.isNotEmpty);
  });

  test('Admin::sitePause', () async {
    await instance.connect(dashboard);
    final res = await instance.sitePauseFuture(talk);
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'Paused');
  });

  test('Admin::siteResume', () async {
    await instance.connect(dashboard);
    final res = await instance.siteResumeFuture(talk);
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error.startsWith("You don't have permission to run"));
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'Resumed');
  });

  test('Admin::permissionRemove', () async {
    await instance.connect(dashboard);
    final res = await instance.permissionRemoveFuture('ADMIN');
    if (!res.isMsg) {
      final error = res.error!.error;
      assert(error == "You don't have permission to run permissionRemove");
      return;
    }
    assert(res.isMsg);
    assert(res.message!.result == 'ok');
  });
}
