part of 'models.dart';

class Notification {
  final List<String> params;
  final int id;

  Notification(this.params, this.id);

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        json['params'] as List<String>,
        json['id'] as int,
      );

  Map<String, dynamic> toJson() => {
        'params': params,
        'id': id,
      };
}
