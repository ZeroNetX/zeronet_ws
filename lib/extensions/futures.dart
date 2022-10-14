// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../models/models.dart';
import '../zeronet_ws.dart';

part 'core/ui_server.dart';
part 'core/admin.dart';

part 'plugins/bigfile.dart';
part 'plugins/chart.dart';
part 'plugins/cors.dart';
part 'plugins/crypt.dart';
part 'plugins/merger.dart';
part 'plugins/content_filter.dart';
part 'plugins/optional.dart';

extension ToMessage on String {
  Message toMessage() => Message.fromJson(json.decode(this));

  //{"cmd": "notification", "params": ["done", "New certificate added <b>app/helloworld@skynetid.bit</b>."], "id": 2}
  Notification toNotification() => Notification.fromJson(json.decode(this));

  dynamic toMsgOrNotification() {
    try {
      return ['notification', toNotification()];
    } catch (e) {
      var msg = toMessage();
      return ['message', msg];
    }
  }

  Future<ResponseResult> callFuture() async {
    return await ZeroNet.instance.cmdFuture(this);
  }
}

extension ToMessageExt on Map<String, dynamic>? {
  Message toMessage() => Message.fromJson(this ?? {});

  //{"cmd": "notification", "params": ["done", "New certificate added <b>app/helloworld@skynetid.bit</b>."], "id": 2}
  Notification toNotification() => Notification.fromJson(this ?? {});

  dynamic toMsgOrNotification() {
    try {
      return ['notification', toNotification()];
    } catch (e) {
      var msg = toMessage();
      return ['message', msg];
    }
  }
}

extension RespondExt on ZeroNet {
  Future<Message> respondFuture(int to) async {
    Completer<String> completer = Completer();
    ZeroNet.instance.respond(
      to: to,
      callback: (msg) {
        completer.complete(msg);
      },
    );
    return (await completer.future).toMessage();
  }
}
