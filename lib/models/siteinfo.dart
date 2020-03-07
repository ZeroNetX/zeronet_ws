class SiteInfo {
  String authKey;
  String authAddress;
  Null certUserId;
  String address;
  String addressShort;
  Settings settings;
  dynamic contentUpdated;
  int badFiles;
  int sizeLimit;
  int nextSizeLimit;
  int peers;
  int startedTaskNum;
  int tasks;
  int workers;
  Content content;
  Null feedFollowNum;

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
    authKey = json['auth_key'];
    authAddress = json['auth_address'];
    certUserId = json['cert_user_id'];
    address = json['address'];
    addressShort = json['address_short'];
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
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
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
      data['settings'] = this.settings.toJson();
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
      data['content'] = this.content.toJson();
    }
    data['feed_follow_num'] = this.feedFollowNum;
    return data;
  }
}

class Settings {
  int added;
  String ajaxKey;
  int bytesRecv;
  int bytesSent;
  Cache cache;
  int downloaded;
  int modified;
  int optionalDownloaded;
  bool own;
  int peers;
  List<String> permissions;
  bool serving;
  int size;
  int sizeFilesOptional;
  int sizeOptional;

  Settings({
    this.added,
    this.ajaxKey,
    this.bytesRecv,
    this.bytesSent,
    this.cache,
    this.downloaded,
    this.modified,
    this.optionalDownloaded,
    this.own,
    this.peers,
    this.permissions,
    this.serving,
    this.size,
    this.sizeFilesOptional,
    this.sizeOptional,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    added = json['added'];
    ajaxKey = json['ajax_key'];
    bytesRecv = json['bytes_recv'];
    bytesSent = json['bytes_sent'];
    cache = json['cache'] != null ? Cache.fromJson(json['cache']) : null;
    downloaded = json['downloaded'];
    modified = json['modified'];
    optionalDownloaded = json['optional_downloaded'];
    own = json['own'];
    peers = json['peers'];
    permissions = json['permissions'].cast<String>();
    serving = json['serving'];
    size = json['size'];
    sizeFilesOptional = json['size_files_optional'];
    sizeOptional = json['size_optional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['added'] = this.added;
    data['ajax_key'] = this.ajaxKey;
    data['bytes_recv'] = this.bytesRecv;
    data['bytes_sent'] = this.bytesSent;
    if (this.cache != null) {
      data['cache'] = this.cache.toJson();
    }
    data['downloaded'] = this.downloaded;
    data['modified'] = this.modified;
    data['optional_downloaded'] = this.optionalDownloaded;
    data['own'] = this.own;
    data['peers'] = this.peers;
    data['permissions'] = this.permissions;
    data['serving'] = this.serving;
    data['size'] = this.size;
    data['size_files_optional'] = this.sizeFilesOptional;
    data['size_optional'] = this.sizeOptional;
    return data;
  }
}

class Cache {
  Cache();

  Cache.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class Content {
  String address;
  String backgroundColor;
  String backgroundColorDark;
  String description;
  int files;
  String ignore;
  String innerPath;
  int modified;
  bool postmessageNonceSecurity;
  int signsRequired;
  String title;
  List<String> translate;
  String viewport;
  String zeronetVersion;
  int filesOptional;
  int includes;

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
    translate = json['translate'].cast<String>();
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
