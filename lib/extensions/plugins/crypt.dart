part of '../futures.dart';

extension CryptMessageExt on ZeroNet {
  /// Returns user's public key unique to site
  ///
  /// Return: Public key
  Future<Message> userPublickeyFuture({
    int index = 0,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.userPublickey,
      params: {
        'index': index,
      },
    );
    return resultStr.message!;
  }

  /// Encrypt a text using the publickey or user's sites unique publickey
  ///
  /// Return: Encrypted text using base64 encoding
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
    return resultStr.message!;
  }

  /// Decrypt a text using privatekey or the user's site unique private key
  ///
  /// Return: Decrypted text or list of decrypted texts
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
    return resultStr.message!;
  }

  /// Encrypt a text using AES
  ///
  /// Return: Iv, AES key, Encrypted text
  Future<Message> aesEncryptFuture(
    String text, {
    String? key,
  }) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.aesEncrypt,
      params: {
        'text': text,
        'key': key,
      },
    );
    return resultStr.message!;
  }

  /// Decrypt a text using AES
  ///
  /// Return: Decrypted text
  Future<Message> aesDecryptFuture(
    String? iv,
    String? encryptedText,
    String? key, {
    List<List<String>> encryptedTexts = const [],
    List<String> keys = const [],
  }) async {
    var params = [];
    if (encryptedText != null) {
      params = [iv, encryptedText, key];
    } else {
      params = [encryptedTexts, keys];
    }
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.aesDecrypt,
      params: params,
    );
    return resultStr.message!;
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
    return resultStr.message!;
  }

  /// Sign data using ECDSA
  ///
  /// Return: Signature
  Future<Message> ecdsaSignFuture(
    String data,
    String? privatekey,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.ecdsaSign,
      params: {
        'data': data,
        'privatekey': privatekey,
      },
    );
    return resultStr.message!;
  }

  /// Verify data using ECDSA (address is either a address or array of addresses)
  ///
  /// Return: Signature
  Future<Message> ecdsaVerifyFuture(
    String data,
    List<String> address,
    String signature,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.ecdsaVerify,
      params: {
        'data': data,
        'address': address,
        'signature': signature,
      },
    );
    return resultStr.message!;
  }

  /// Gets the publickey of a given privatekey
  Future<Message> eccPrivToPubFuture(
    String privateKey,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.eccPrivToPub,
      params: {
        'privateKey': privateKey,
      },
    );
    return resultStr.message!;
  }

  /// Gets the address of a given publickey
  Future<Message> eccPubToAddrFuture(
    String publickey,
  ) async {
    var resultStr = await ZeroNet.instance.cmdFuture(
      ZeroNetCmd.eccPubToAddr,
      params: {
        'publickey': publickey,
      },
    );
    return resultStr.message!;
  }
}
