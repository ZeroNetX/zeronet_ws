part of '../futures.dart';

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
