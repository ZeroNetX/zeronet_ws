part of 'models.dart';

class Notification {
  final String cmd;
  final List<String> params;
  final int id;

  Notification(this.cmd, this.params, this.id);

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        json['cmd'] as String,
        json['params'] as List<String>,
        json['id'] as int,
      );

  Map<String, dynamic> toJson() => {
        'cmd': cmd,
        'params': params,
        'id': id,
      };
}
