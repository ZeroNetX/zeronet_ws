part of 'models.dart';

abstract class _PromptImpl<T> {
  final List<String>? params;
  final int id;
  _PromptImpl({
    required this.id,
    this.params,
  });

  Map<String, dynamic> toJson() => {
        'params': params,
        'id': id,
      };
}

class Confirm extends _PromptImpl {
  Confirm(int id, List<String>? params) : super(id: id, params: params);

  factory Confirm.fromJson(Map<String, dynamic> json) => Confirm(
        json['id'] as int,
        json['params'] as List<String>,
      );
}

class Notification extends _PromptImpl {
  Notification(int id, List<String>? params) : super(id: id, params: params);

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        json['id'] as int,
        json['params'] as List<String>,
      );
}

class Progress extends _PromptImpl {
  Progress(int id, List<String>? params) : super(id: id, params: params);

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        json['id'] as int,
        json['params'] as List<String>,
      );
}

class Prompt extends _PromptImpl {
  Prompt(int id, List<String>? params) : super(id: id, params: params);

  factory Prompt.fromJson(Map<String, dynamic> json) => Prompt(
        json['id'] as int,
        json['params'] as List<String>,
      );
}
