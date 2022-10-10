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

  Message.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    to = json['to'] ?? 0;
    result = json['result'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cmd'] = this.cmd;
    data['to'] = this.to;
    if (this.result != null) {
      data['result'] = json.encode(this.result);
    }
    data['id'] = this.id;
    return data;
  }
}
