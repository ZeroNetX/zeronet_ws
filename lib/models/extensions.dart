part of 'models.dart';

class MessageOrError {
  final Message? message;
  final Error? error;
  const MessageOrError({
    this.message,
    this.error,
  });

  bool get isMsg => message != null;
}

extension MsgOrErr on ResponseResult {
  MessageOrError get toMsgOrErr {
    if (isMessage) {
      return MessageOrError(message: message);
    }
    return MessageOrError(error: error);
  }
}

class MessageOrPrompt {
  final Message? message;
  final PromptResult? prompt;
  const MessageOrPrompt({
    this.message,
    this.prompt,
  });

  bool get isMsg => message != null;
}

extension MsgOrPrompt on ResponseResult {
  MessageOrPrompt get toMsgOrPrompt {
    if (isMessage) {
      return MessageOrPrompt(message: message);
    }
    return MessageOrPrompt(prompt: prompt);
  }
}

class MessageOrPromptOrError {
  final Message? message;
  final PromptResult? prompt;
  final Error? error;
  const MessageOrPromptOrError({
    this.message,
    this.prompt,
    this.error,
  });

  bool get isMsg => message != null;
  bool get isPrompt => prompt != null;
  bool get isErr => error != null;
}

extension MsgOrPromptOrErr on ResponseResult {
  MessageOrPromptOrError get toMsgOrPromptOrErr {
    if (isMessage) {
      return MessageOrPromptOrError(message: message);
    } else if (isPrompt) {
      return MessageOrPromptOrError(prompt: prompt);
    } else {
      return MessageOrPromptOrError(error: error);
    }
  }
}

class PromptOrError {
  final PromptResult? prompt;
  final Error? error;
  const PromptOrError({
    this.prompt,
    this.error,
  });

  bool get isPrompt => prompt != null;
  bool get isErr => error != null;
}

extension PromptOrErr on ResponseResult {
  PromptOrError get toPromptOrErr {
    if (isPrompt) {
      return PromptOrError(prompt: prompt);
    } else {
      return PromptOrError(error: error);
    }
  }
}
