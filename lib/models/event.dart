part of 'models.dart';

enum EventChannel {
  announcerChanged,
  siteChanged,
  serverChanged,
}

enum EventType {
  setAnnouncerInfo,
  setSiteInfo,
  setServerInfo,
  unknown,
}

class EventResult {
  final EventType type;
  final SiteInfo? siteInfo;
  final ServerInfo? serverInfo;
  final dynamic result;

  EventResult({
    required this.type,
    this.siteInfo,
    this.serverInfo,
    this.result,
  });

  factory EventResult.fromJson(JSONMap json) {
    final JSONMap result = json['params'] ?? {};
    switch (json['cmd']) {
      case 'setSiteInfo':
        return EventResult(
          type: EventType.setSiteInfo,
          siteInfo: SiteInfo.fromJson(result),
        );
      case 'setServerInfo':
        return EventResult(
          type: EventType.setServerInfo,
          serverInfo: ServerInfo.fromJson(result),
        );
      case 'setAnnouncerInfo':
        return EventResult(
          type: EventType.setAnnouncerInfo,
          result: result,
        );
      default:
        return EventResult(
          type: EventType.unknown,
          result: json,
        );
    }
  }
}
