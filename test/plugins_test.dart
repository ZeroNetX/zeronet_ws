import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/models/models.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  const dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  const talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  const testSite = '1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw';

  final instance = ZeroNet.instance;
  group('Plugin::BigFile', () {
    test("bigFileUpload", () async {
      await instance.connect("1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw");
      final file = File("RustDesk.exe");
      final size = file.lengthSync();
      final res = await instance.bigFileUploadInitFuture("RustDesk.exe", size);
      assert(res.isMsg);
      assert(res.message!.result is Map);
      // assert(res.message!.result);
    });

    test("siteSetAutodownloadBigfileLimit", () async {
      await instance.connect(talk);
      final res = await instance.siteSetAutodownloadBigfileLimit(0);
      assert(res.isMsg);
    });

    test("uploadFile", () async {
      await instance.connect('1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw');
      final file = File("test/RustDesk.exe");
      final size = file.lengthSync();
      final urlRes =
          await instance.bigFileUploadInitFuture("RustDesk.exe", size);
      final map = urlRes.message!.result as Map;
      final url = "http://127.0.0.1:43110${map['url']}";
      final res =
          await instance.uploadFile(url, "RustDesk.exe", "test/RustDesk.exe");
      assert(res);
    });
  });

  group('Plugin::Chart', () {
    test("chartDbQueryFuture", () async {
      await instance.connect(talk);

      final perRes = await instance.permissionAddFuture('ADMIN');
      assert(perRes.isMsg);

      final res = await instance.chartDbQueryFuture(
        'SELECT site.site_id FROM site WHERE site.address = "$talk"',
      );
      assert(res.isMsg);
    });

    test("chartGetPeerLocationsFuture", () async {
      await instance.connect(talk);
      final res = await instance.chartGetPeerLocationsFuture();
      assert(res.result is List);
    });
  });

  group('Plugin::ContentFilter', () {
    test("muteAddFuture", () async {
      await instance.connect(talk);
      final res = await instance.muteAddFuture(
        '1J4MejFtU6VkcguG1ng3xK3RjAjFohSGed',
        "18143wpue3rqyknaopx5kjkzymayhcjqhv@cryptoid.bit",
        "testing mute feature",
      );
      assert(res.prompt != null);

      assert(false); //confirm callback ??
    });

    test("muteRemove", () async {
      await instance.connect(talk);
      final res = await instance.muteRemoveFuture(
        '1J4MejFtU6VkcguG1ng3xK3RjAjFohSGed',
      );
      assert(res.prompt !=
          null); // test fails if auth address not found in filters.json

      assert(false); // how  to confirm prompt
    });

    test("muteListFuture", () async {
      await instance.connect(talk);
      final res = await instance.muteListFuture();
      assert(res.result is List);
    });

    test("muteListFuture", () async {
      assert(
          false); // handle when un authorized user call this funtion, return error message, getting null operator used on null value

      await instance.connect(talk);
      final res = await instance.muteListFuture();
      assert(res.result == 'error');
    });

    // test("filterIncludeAddFuture", () async {
    //   await instance.connect(talk);
    //   final res = await instance.filterIncludeAddFuture();
    // });
    //

    // test("filterIncludeRemoveFuture", () async {
    //   await instance.connect(talk);
    //   final res = await instance.filterIncludeRemoveFuture();
    // });

    test("filterIncludeListFuture", () async {
      await instance.connect(talk);
      final res = await instance.filterIncludeListFuture();

      assert(res.result is List);
    });
    test("siteblockIgnoreAddSiteFuture", () async {
      await instance.connect(talk);
      final res = await instance
          .siteblockIgnoreAddSiteFuture('1EjitdTHErKQccRVyfvgharFc15wVpbS2j');

      assert(res.isMsg);
    });

    test("siteblockAddFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      final res = await instance.siteblockAddFuture(
        '1EjitdTHErKQccRVyfvgharFc15wVpbS2j',
        reason: "testing",
      );
      assert(res.result != null);
    });

    test("siteblockRemoveFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      final res = await instance.siteblockRemoveFuture(
        '1EjitdTHErKQccRVyfvgharFc15wVpbS2j',
        reason: "testing",
      );
      assert(res.result != null);
    });

    test("siteblockListFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      final res = await instance.siteblockListFuture();
      assert(res.result != null);
    });

    test("siteblockGetFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      final res = await instance.siteblockGetFuture(
        '1EjitdTHErKQccRVyfvgharFc15wVpbS2j',
      );
      assert(res.result != null);
    });
  });

  group('Plugin::Cors', () {
    test("corsPermissionFuture", () async {
      await instance.connect(talk);
      final res = await instance.corsPermissionFuture([
        "cors-15UYrA7aXr2Nto1Gg4yWXpY3EAJwafMTNk",
      ]);

      assert(res.prompt != null);

      assert(false); // callback ??
    });
  });

  group('Plugin::Crypt', () {
    test("userPublickeyFuture", () async {
      await instance.connect(talk);
      final res = await instance.userPublickeyFuture();

      assert(res.result is String);
    });

    test("eciesEncryptFuture", () async {
      await instance.connect(talk);
      final keyResult = await instance.userPublickeyFuture();

      String publicKey = keyResult.result as String;
      final res = await instance.eciesEncryptFuture('testing encrypt',
          publicKey: publicKey);
      assert(res.result is String);
    });

    test("eciesDecryptFuture", () async {
      await instance.connect('17fZG8MAHZ4HUVpx5DwV85LeCFrJPaqFKG');
      String text = "Testing Crypt_dart";
      final encryptStr = await instance.eciesEncryptFuture(
        text,
      );
      assert(encryptStr.result is String);
      final res = await instance.eciesDecryptFuture(encryptStr.result);
      final deCrypt = res.result;
      assert(deCrypt == text);
    });

    test("aesEncryptFuture", () async {
      await instance.connect(talk);
      String text = "Testing Crypt_dart";

      final res = await instance.aesEncryptFuture(text);

      assert(res.result is List);
    });

    test("aesDecryptFuture", () async {
      await instance.connect("1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw");
      String text = "Testing Crypt_dart";

      final enCrypStr = await instance.aesEncryptFuture(
        text,
      );
      assert(enCrypStr.result[0] is String);
      final key = enCrypStr.result[0];
      final iv = enCrypStr.result[1];
      final en = enCrypStr.result[2];
      final bulkTextDecrResult = await instance.aesDecryptFuture(
        null,
        null,
        null,
        encryptedTexts: [
          [iv, en]
        ],
        keys: [key],
      );
      assert(bulkTextDecrResult.result is List);

      assert(bulkTextDecrResult.result.first == text);

      final res = await instance.aesDecryptFuture(iv, en, key);

      assert(res.result == text);
    });

    test("aesDecryptArrayFuture", () async {
      await instance.connect(talk);
      String text = "Testing Crypt_dart";

      final keyResult = await instance.userPublickeyFuture();

      final publicKey = keyResult.result as String;

      /// Getting wrong public key length
      assert(false); // test failed with public key param
      final aesEncryp = await instance.aesEncryptFuture(text, key: publicKey);

      final res = await instance.aesDecryptArrayFuture(
        [aesEncryp.result[0]],
        [aesEncryp.result[2]],
      );

      assert(res.result is List);
    });

    test("ecdsaSignFuture", () async {
      await instance.connect(talk);

      final res = await instance.ecdsaSignFuture("data", null);

      assert(res.result != null);
    });

    test("ecdsaVerifyFuture", () async {
      await instance.connect(talk);

      final sign = await instance.ecdsaSignFuture("data", null);
      final res = await instance.ecdsaVerifyFuture(
        "data",
        ['1J4MejFtU6VkcguG1ng3xK3RjAjFohSGed'],
        sign.result,
      );

      assert(res.result != null);
    });

    test("eccPrivToPubFuture", () async {
      await instance.connect(talk);
      await instance.connect(dashboard);

      final res = await instance.eccPrivToPubFuture('');

      assert(res.result is String);
    });

    test("eccPubToAddrFuture", () async {
      assert(false); // loading ..
      await instance.connect(dashboard);
      final keyResult = await instance.userPublickeyFuture();

      final pubKey = keyResult.result;

      assert(pubKey is String);
      final res = await instance.eccPubToAddrFuture(pubKey);
      assert(res.result is String && res.result.toString().startsWith("1"));
    });
  });

  group('Plugin::Merger', () {
    test('mergerSiteAddFuture', () async {
      await instance.connect(testSite);
      final res = await instance
          .mergerSiteAddFuture(['1E54os6VQDZ2fEsgNZmB5oWJb9scQnsgNh']);

      assert(res.isMsg);

      assert(res.message!.result is List);
    });

    test('mergerSiteDeleteFuture', () async {
      await instance.connect(testSite);

      final res = await instance
          .mergerSiteDeleteFuture('1E54os6VQDZ2fEsgNZmB5oWJb9scQnsgNh');

      assert(res.isMsg);
    });

    test('mergerSiteListFuture', () async {
      await instance.connect('1FUzXC93wj3Djv33tzxXcLpb6AMgjKTWvH');

      final res = await instance.mergerSiteListFuture(false);

      assert(res.isMsg);
      assert(res.message!.result is List);
    });
  });

  group('Plugin::OptionalFiles', () {
    const storageAdd = '1UPLoADsqDWzMEyqLNin8GPcWoqiihu1g';

    test('optionalFileListFuture', () async {
      await instance.connect(storageAdd);
      final res = await instance.optionalFileListFuture(limit: 1);
      assert(res.isMsg);
      assert(res.message!.result is List);
    });

    test('optionalFileInfoFuture', () async {
      await instance.connect(storageAdd);
      final res = await instance.optionalFileInfoFuture(
        'data/users/13JuGiUNQFGijiA5NWsKsgv8YWBus5NvV1/1668771876-cryptocam_android.zip',
      );

      assert(res.result is Map);
    });

    test('optionalFilePinFuture', () async {
      await instance.connect(storageAdd);
      final res = await instance.optionalFilePinFuture(
        [
          'data/users/13JuGiUNQFGijiA5NWsKsgv8YWBus5NvV1/1668771876-cryptocam_android.zip',
        ],
        address: storageAdd,
      );
      if (res.isMsg) {
        assert(res.message!.result == 'ok');
      } else if (res.isPrompt) {
        assert(res.prompt!.type == PromptType.notification);
        assert((res.prompt!.value as Notification).params![0] == 'done');
      }
    });

    test('optionalFileUnPinFuture', () async {
      await instance.connect(storageAdd);
      final res = await instance.optionalFileUnPinFuture([
        'data/users/13JuGiUNQFGijiA5NWsKsgv8YWBus5NvV1/1668771876-cryptocam_android.zip',
      ]);
      assert(res.result == 'ok');
    });

    test('optionalFileDeleteFuture', () async {
      await instance.connect(storageAdd);
      final res = await instance.optionalFileDeleteFuture(
        'data/users/13JuGiUNQFGijiA5NWsKsgv8YWBus5NvV1/1668771876-cryptocam_android.zip',
      );
      assert(res.isMsg);
    });

    test('optionalLimitStatsFuture', () async {
      await instance.connect(storageAdd);
      assert(false);
      final res = await instance.optionalLimitStatsFuture();
      assert(res.result != null);
    });

    test('optionalLimitSetFuture', () async {
      assert(false); // how to pass argument ??
      await instance.connect(storageAdd);

      final res = await instance.optionalLimitSetFuture();
      assert(res.result != null);
    });

    /// enabled auto downlaoded feature to the provided directory
    test('optionalHelpFuture', () async {
      await instance.connect(storageAdd);
      const dir = '1AmeB7f5wBfJm6iR7MRZfFh65xkJzaVCX7';
      final res = await instance.optionalHelpFuture(
          dir, 'title, enable auto downloading to this dir');

      assert(res.result is Map);
    });

    /// returns the map of auto downloaded feature enabled directory name along with title
    test('optionalHelpListFuture', () async {
      await instance.connect(storageAdd);

      final res = await instance.optionalHelpListFuture();
      assert(res.result is Map);
    });

    test('optionalHelpRemoveFuture', () async {
      await instance.connect(storageAdd);
      const removeDir = '1AmeB7f5wBfJm6iR7MRZfFh65xkJzaVCX7';
      final res = await instance.optionalHelpRemoveFuture(removeDir);
      assert(res.result == 'ok');
    });

    test('optionalHelpAllFuture', () async {
      assert(false);
      await instance.connect(storageAdd);

      final res = await instance.optionalHelpAllFuture(true);
      assert(res.isMsg);
    });
  });
}
