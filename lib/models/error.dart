part of 'models.dart';

class Error {
  final int id;
  final String error;

  Error({
    required this.id,
    required this.error,
  });

  factory Error.fromJson(JSONMap json) => Error(
        id: json['id'] ?? -1,
        error: json['error'] ?? '',
      );

  JSONMap toJson() => {
        'id': id,
        'error': error,
      };
}
