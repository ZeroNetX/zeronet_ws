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

enum PromptType {
  confirm,
  notification,
  progress,
  prompt,
  unknown,
}

class PromptResult {
  final PromptType type;
  final dynamic value;

  PromptResult({
    required this.type,
    required this.value,
  });

  factory PromptResult.fromJson(JSONMap json) {
    final cmd = json['cmd'] ?? json['error'];
    switch (cmd) {
      case 'notification':
        return PromptResult(
          type: PromptType.notification,
          value: Notification.fromJson(json),
        );
      case 'confirm':
        return PromptResult(
          type: PromptType.confirm,
          value: Confirm.fromJson(json),
        );
      case 'progress':
        return PromptResult(
          type: PromptType.progress,
          value: Progress.fromJson(json),
        );
      default:
        return PromptResult(
          type: PromptType.confirm,
          value: null,
        );
    }
  }
}
