part of 'models.dart';

enum ResponseType {
  message,
  prompt,
  event,
  error,
  unknown,
}

class ResponseResult {
  final int id;
  final ResponseType type;
  final Message? message;
  final PromptResult? prompt;
  final EventResult? event;
  final Error? error;
  final dynamic json;

  ResponseResult({
    required this.id,
    required this.type,
    this.message,
    this.prompt,
    this.event,
    this.error,
    this.json,
  });

  bool get isMessage => message != null;
  bool get isPrompt => prompt != null;
  bool get isEvent => event != null;
  bool get isError => error != null;

  dynamic get value => message ?? prompt ?? event ?? error;

  factory ResponseResult.fromJson(JSONMap json) {
    final id = json['id'] ?? -1;
    final cmd = json['cmd'] ?? json['error'];
    //TODO! Add handlers for injectScript & redirect
    switch (cmd) {
      case 'response':
        return ResponseResult(
          id: id,
          type: ResponseType.message,
          message: Message.fromJson(json),
        );
      case 'error':
        return ResponseResult(
          id: id,
          type: ResponseType.error,
          error: Error.fromJson(json),
        );
      case 'confirm':
      case 'notification':
      case 'progress':
      case 'prompt':
        return ResponseResult(
          id: id,
          type: ResponseType.prompt,
          prompt: PromptResult.fromJson(json),
        );
      default:
        if (cmd is String && cmd.startsWith('set')) {
          return ResponseResult(
            id: id,
            type: ResponseType.event,
            event: EventResult.fromJson(json),
          );
        }
        return ResponseResult(
          id: id,
          type: ResponseType.unknown,
          json: json,
        );
    }
  }
}
