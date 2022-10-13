part of 'models.dart';

class SiteInfo {
  String? authKey;
  String? authAddress;
  String? certUserId;
  String? address;
  String? addressShort;
  Settings? settings;
  dynamic contentUpdated;
  int? badFiles;
  int? sizeLimit;
  int? nextSizeLimit;
  int? peers;
  int? startedTaskNum;
  int? tasks;
  int? workers;
  Content? content;
  int? feedFollowNum;

  SiteInfo({
    this.authKey,
    this.authAddress,
    this.certUserId,
    this.address,
    this.addressShort,
    this.settings,
    this.contentUpdated,
    this.badFiles,
    this.sizeLimit,
    this.nextSizeLimit,
    this.peers,
    this.startedTaskNum,
    this.tasks,
    this.workers,
    this.content,
    this.feedFollowNum,
  });

  SiteInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressShort = json['address_short'];
    if (json.containsKey('auth_key')) authKey = json['auth_key'];
    authAddress = json['auth_address'];
    certUserId = json['cert_user_id'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    contentUpdated = json['content_updated'];
    badFiles = json['bad_files'];
    sizeLimit = json['size_limit'];
    nextSizeLimit = json['next_size_limit'];
    peers = json['peers'];
    startedTaskNum = json['started_task_num'];
    tasks = json['tasks'];
    workers = json['workers'];
    content = json['content'] != null
        ? Content.fromJson(
            json['content'],
          )
        : null;
    feedFollowNum = json['feed_follow_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['auth_key'] = this.authKey;
    data['auth_address'] = this.authAddress;
    data['cert_user_id'] = this.certUserId;
    data['address'] = this.address;
    data['address_short'] = this.addressShort;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    data['content_updated'] = this.contentUpdated;
    data['bad_files'] = this.badFiles;
    data['size_limit'] = this.sizeLimit;
    data['next_size_limit'] = this.nextSizeLimit;
    data['peers'] = this.peers;
    data['started_task_num'] = this.startedTaskNum;
    data['tasks'] = this.tasks;
    data['workers'] = this.workers;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['feed_follow_num'] = this.feedFollowNum;
    return data;
  }
}

class Settings {
  int added;
  List<String> permissions;
  int sizeFilesOptional;
  int sizeOptional;
  bool serving;
  Cache cache;
  int optionalDownloaded;
  bool own;
  String? ajaxKey;
  int? downloaded;
  int? size;
  int? sizeLimit;
  String? autodownloadoptional;

  int? bytesRecv;
  int? bytesSent;
  int? modified;
  int? peers;

  Settings({
    required this.added,
    required this.permissions,
    required this.sizeFilesOptional,
    required this.sizeOptional,
    required this.serving,
    required this.cache,
    required this.optionalDownloaded,
    required this.own,
    this.ajaxKey,
    this.downloaded,
    this.size,
    this.sizeLimit,
    this.autodownloadoptional,
    //
    this.bytesRecv,
    this.bytesSent,
    this.peers,
    this.modified,
  }) {
    downloaded ??= added;
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      added: json['added'],
      permissions: json['permissions'].cast<String>(),
      sizeFilesOptional: json['size_files_optional'],
      sizeOptional: json['size_optional'],
      serving: json['serving'],
      cache: Cache.fromJson(json['cache']),
      optionalDownloaded: json['optional_downloaded'],
      own: json['own'],
      ajaxKey: json['ajax_key'],
      downloaded: json['downloaded'],
      size: json['size'],
      sizeLimit: json['size_limit'],
      autodownloadoptional: json['autodownloadoptional'],
      //
      bytesRecv: json['bytes_recv'],
      bytesSent: json['bytes_sent'],
      peers: json['peers'],
      modified: (json['modified'] is double)
          ? json['modified'].toInt()
          : json['modified'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['added'] = added;
    data['permissions'] = permissions;
    data['size_files_optional'] = sizeFilesOptional;
    data['size_optional'] = sizeOptional;
    data['serving'] = serving;
    data['cache'] = cache.toJson();
    data['optional_downloaded'] = optionalDownloaded;
    data['own'] = own;
    data['ajax_key'] = ajaxKey;
    data['downloaded'] = downloaded;
    data['size'] = size;
    data['size_limit'] = sizeLimit;
    data['autodownloadoptional'] = autodownloadoptional;
    //
    data['bytes_recv'] = bytesRecv;
    data['bytes_sent'] = bytesSent;
    data['peers'] = peers;
    data['modified'] = modified;
    return data;
  }
}

class Cache {
  Map<String, int> badFiles;
  Map<String, int>? hashfield;
  Cache({
    required this.badFiles,
    this.hashfield,
  });

  factory Cache.fromJson(Map<String, dynamic> json) {
    return Cache(
      badFiles: json['bad_files'],
      hashfield: json['hashfield'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bad_files'] = badFiles;
    data['hashfield'] = hashfield;
    return data;
  }
}

class Content {
  String? address;
  String? backgroundColor;
  String? backgroundColorDark;
  String? description;
  int? files;
  String? ignore;
  String? innerPath;
  int? modified;
  bool? postmessageNonceSecurity;
  int? signsRequired;
  String? title;
  List<String>? translate;
  String? viewport;
  String? zeronetVersion;
  int? filesOptional;
  int? includes;

  Content({
    this.address,
    this.backgroundColor,
    this.backgroundColorDark,
    this.description,
    this.files,
    this.ignore,
    this.innerPath,
    this.modified,
    this.postmessageNonceSecurity,
    this.signsRequired,
    this.title,
    this.translate,
    this.viewport,
    this.zeronetVersion,
    this.filesOptional,
    this.includes,
  });

  Content.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    backgroundColor = json['background-color'];
    backgroundColorDark = json['background-color-dark'];
    description = json['description'];
    files = json['files'];
    ignore = json['ignore'];
    innerPath = json['inner_path'];
    modified = json['modified'];
    postmessageNonceSecurity = json['postmessage_nonce_security'];
    signsRequired = json['signs_required'];
    title = json['title'];
    translate = json['translate']?.cast<String>();
    viewport = json['viewport'];
    zeronetVersion = json['zeronet_version'];
    filesOptional = json['files_optional'];
    includes = json['includes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = this.address;
    data['background-color'] = this.backgroundColor;
    data['background-color-dark'] = this.backgroundColorDark;
    data['description'] = this.description;
    data['files'] = this.files;
    data['ignore'] = this.ignore;
    data['inner_path'] = this.innerPath;
    data['modified'] = this.modified;
    data['postmessage_nonce_security'] = this.postmessageNonceSecurity;
    data['signs_required'] = this.signsRequired;
    data['title'] = this.title;
    data['translate'] = this.translate;
    data['viewport'] = this.viewport;
    data['zeronet_version'] = this.zeronetVersion;
    data['files_optional'] = this.filesOptional;
    data['includes'] = this.includes;
    return data;
  }
}

extension SiteInfoMessageExt on Message {
  SiteInfo get siteInfo {
    return SiteInfo.fromJson(this.result);
  }
}
