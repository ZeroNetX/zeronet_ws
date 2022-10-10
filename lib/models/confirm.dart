part of 'models.dart';

class Confirm {
  final List<String> params;
  final int id;

  Confirm(this.params, this.id);

  factory Confirm.fromJson(Map<String, dynamic> json) => Confirm(
        json['params'] as List<String>,
        json['id'] as int,
      );

  Map<String, dynamic> toJson() => {
        'params': params,
        'id': id,
      };
}
