import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

void main() {
  var dashboard = '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d';
  var talk = '1TaLkFrMwvbNsooF4ioKAY9EuxTBTjipT';
  var testSite = '1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw';

  var instance = ZeroNet.instance;
  group('Plugin::BigFile', () {
    test("bigFileUpload", () async {
      await instance.connect("1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw");
      var file = File("RustDesk.exe");
      var size = file.lengthSync();
      var res = await instance.bigFileUploadInitFuture("RustDesk.exe", size);
      assert(res.isMsg);
      assert(res.message!.result is Map);
      // assert(res.message!.result);
    });

    test("siteSetAutodownloadBigfileLimit", () async {
      await instance.connect(talk);
      var res = await instance.siteSetAutodownloadBigfileLimit(0);
      assert(res.isMsg);
    });

    test("uploadFile", () async {
      await instance.connect('1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw');
      var file = File("test/RustDesk.exe");
      var size = file.lengthSync();
      var urlRes = await instance.bigFileUploadInitFuture("RustDesk.exe", size);

      var map = urlRes.message!.result as Map;
      print(map);
      final url = "http://127.0.0.1:43110${map['url']}";
      var res =
          await instance.uploadFile(url, "RustDesk.exe", "test/RustDesk.exe");
      assert(res);
    });
  });

  group('Plugin::Chart', () {
    test("chartDbQueryFuture", () async {
      await instance.connect(talk);

      final perRes = await instance.permissionAddFuture('ADMIN');
      assert(perRes.result == 'ok');

      var res = await instance.chartDbQueryFuture(
        'SELECT site.site_id FROM site WHERE site.address = "$talk"',
      );
      assert(res.isMsg);
    });

    test("chartGetPeerLocationsFuture", () async {
      await instance.connect(talk);
      var res = await instance.chartGetPeerLocationsFuture();
      assert(res.result is List);
    });
  });

  group('Plugin::ContentFilter', () {
    test("muteAddFuture", () async {
      await instance.connect(talk);
      var res = await instance.muteAddFuture(
        '1J4MejFtU6VkcguG1ng3xK3RjAjFohSGed',
        "18143wpue3rqyknaopx5kjkzymayhcjqhv@cryptoid.bit",
        "testing mute feature",
      );
      assert(res.prompt != null);

      assert(false); //confirm callback ??
    });

    test("muteRemove", () async {
      await instance.connect(talk);
      var res = await instance.muteRemoveFuture(
        '1J4MejFtU6VkcguG1ng3xK3RjAjFohSGed',
      );
      assert(res.prompt !=
          null); // test fails if auth address not found in filters.json

      assert(false); // how  to confirm prompt
    });

    test("muteListFuture", () async {
      await instance.connect(talk);
      var res = await instance.muteListFuture();
      assert(res.result is List);
    });

    test("muteListFuture", () async {
      assert(
          false); // handle when un authorized user call this funtion, return error message, getting null operator used on null value

      await instance.connect(talk);
      var res = await instance.muteListFuture();
      assert(res.result == 'error');
    });

    // test("filterIncludeAddFuture", () async {
    //   await instance.connect(talk);
    //   var res = await instance.filterIncludeAddFuture();
    // });
    //

    // test("filterIncludeRemoveFuture", () async {
    //   await instance.connect(talk);
    //   var res = await instance.filterIncludeRemoveFuture();
    // });

    test("filterIncludeListFuture", () async {
      await instance.connect(talk);
      var res = await instance.filterIncludeListFuture();

      assert(res.result is List);
    });
    test("siteblockIgnoreAddSiteFuture", () async {
      await instance.connect(talk);
      var res = await instance
          .siteblockIgnoreAddSiteFuture('1EjitdTHErKQccRVyfvgharFc15wVpbS2j');

      assert(res.isMsg);
    });

    test("siteblockAddFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      var res = await instance.siteblockAddFuture(
          '1EjitdTHErKQccRVyfvgharFc15wVpbS2j',
          reason: "testing");
    });

    test("siteblockRemoveFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      var res = await instance.siteblockRemoveFuture(
          '1EjitdTHErKQccRVyfvgharFc15wVpbS2j',
          reason: "testing");
    });

    test("siteblockListFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      var res = await instance.siteblockListFuture();
    });

    test("siteblockGetFuture", () async {
      assert(false); // unathorized
      await instance.connect(talk);
      var res = await instance
          .siteblockGetFuture('1EjitdTHErKQccRVyfvgharFc15wVpbS2j');
    });
  });

  group('Plugin::Cors', () {
    test("corsPermissionFuture", () async {
      await instance.connect(talk);
      var res = await instance
          .corsPermissionFuture(["cors-15UYrA7aXr2Nto1Gg4yWXpY3EAJwafMTNk"]);

      assert(res.prompt != null);

      assert(false); // callback ??
    });
  });

  group('Plugin::Crypt', () {
    test("userPublickeyFuture", () async {
      await instance.connect(talk);
      var res = await instance.userPublickeyFuture();

      assert(res.result is String);
    });

    test("eciesEncryptFuture", () async {
      await instance.connect(talk);
      var keyResult = await instance.userPublickeyFuture();

      String publicKey = keyResult.result as String;
      var res = await instance.eciesEncryptFuture('testing encrypt',
          publicKey: publicKey);
      assert(res.result is String);
    });

    test("eciesDecryptFuture", () async {
      await instance.connect('17fZG8MAHZ4HUVpx5DwV85LeCFrJPaqFKG');
      String text = "Testing Crypt_dart";
      var encryptStr = await instance.eciesEncryptFuture(
        text,
      );
      assert(encryptStr.result is String);
      var res = await instance.eciesDecryptFuture(encryptStr.result);
      var deCrypt = res.result;
      assert(res.result == text);
    });

    test("aesEncryptFuture", () async {
      await instance.connect(talk);
      String text = "Testing Crypt_dart";

      var res = await instance.aesEncryptFuture(text);

      assert(res.result is List);
    });

    test("aesDecryptFuture", () async {
      await instance.connect("1DCN2A5VqYrQSNds7Y3s9JLn65CfykPKJw");
      String text = "Testing Crypt_dart";
      var keyResult = await instance.userPublickeyFuture();

      String publicKey = keyResult.result as String;
      var enCrypStr = await instance.aesEncryptFuture(
        text,
      );
      assert(enCrypStr.result[0] is String);
      var res = await instance.aesDecryptFuture(
        enCrypStr.result[1],
        enCrypStr.result[2],
        enCrypStr.result[0],
      );

      assert(res.result != null);
    });

    test("aesDecryptArrayFuture", () async {
      await instance.connect(talk);
      String text = "Testing Crypt_dart";
      var keyResult = await instance.userPublickeyFuture();

      String publicKey = keyResult.result as String;
      assert(false); // loading ...
      var aesEncryp = await instance.aesEncryptFuture(text, key: publicKey);

      var res = await instance.aesDecryptArrayFuture(
        [aesEncryp.result[2]],
        [aesEncryp.result[1]],
      );

      assert(res.result is List);
    });

    test("ecdsaSignFuture", () async {
      await instance.connect(talk);

      var res = await instance.ecdsaSignFuture("data", null);

      assert(res.result != null);
    });

    test("ecdsaVerifyFuture", () async {
      await instance.connect(talk);

      var sign = await instance.ecdsaSignFuture("data", null);
      var res = await instance.ecdsaVerifyFuture(
        "data",
        ['1J4MejFtU6VkcguG1ng3xK3RjAjFohSGed'],
        sign.result,
      );

      assert(res.result != null);
    });

    test("eccPrivToPubFuture", () async {
      await instance.connect(talk);
      await instance.connect(dashboard);

      var res = await instance.eccPrivToPubFuture('');

      assert(res.result is String);
    });

    test("eccPubToAddrFuture", () async {
      assert(false); // loading ..
      await instance.connect(dashboard);
      var keyResult = await instance.userPublickeyFuture();

      var pubKey = keyResult.result;

      assert(pubKey is String);
      var res = await instance.eccPubToAddrFuture(pubKey);
      assert(res.result is String && res.result.toString().startsWith("1"));
    });
  });

  group('Plugin::Merger', () {
    test('mergerSiteAddFuture', () async {
      await instance.connect(testSite);
      var res = await instance
          .mergerSiteAddFuture(['1E54os6VQDZ2fEsgNZmB5oWJb9scQnsgNh']);

      assert(res.isMsg);

      assert(res.message!.result is List);
    });

    test('mergerSiteDeleteFuture', () async {
      await instance.connect(testSite);

      var res = await instance
          .mergerSiteDeleteFuture('1E54os6VQDZ2fEsgNZmB5oWJb9scQnsgNh');

      assert(res.isMsg);
    });

    test('mergerSiteListFuture', () async {
      await instance.connect('1FUzXC93wj3Djv33tzxXcLpb6AMgjKTWvH');

      var res = await instance.mergerSiteListFuture(false);

      assert(res.isMsg);
      assert(res.message!.result is List);
    });
  });
}
