part of 'models.dart';

class Message {
  late String cmd;
  late int to;
  late dynamic result;
  late int id;

  Message(
    this.cmd,
    this.to,
    this.result,
    this.id,
  );

  Message.fromJson(JSONMap json) {
    cmd = json['cmd'];
    to = json['to'] ?? 0;
    result = json['result'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final JSONMap data = {};
    data['cmd'] = cmd;
    data['to'] = to;
    if (result != null) {
      data['result'] = json.encode(result);
    }
    data['id'] = id;
    return data;
  }
}
