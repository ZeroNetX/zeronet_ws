part of 'models.dart';

class Progress {
  final List<String> params;
  final int id;

  Progress(this.params, this.id);

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        json['params'] as List<String>,
        json['id'] as int,
      );

  Map<String, dynamic> toJson() => {
        'params': params,
        'id': id,
      };
}
