class ZeroNetCmd {
  //Wrapper cmds
  static const String wrapperConfirm = 'wrapperConfirm';
  static const String wrapperInnerLoaded = 'wrapperInnerLoaded';
  static const String wrapperGetLocalStorage = 'wrapperGetLocalStorage';
  static const String wrapperGetState = 'wrapperGetState';
  static const String wrapperGetAjaxKey = 'wrapperGetAjaxKey';
  static const String wrapperNotification = 'wrapperNotification';
  static const String wrapperOpenWindow = 'wrapperOpenWindow';
  static const String wrapperPermissionAdd = 'wrapperPermissionAdd';
  static const String wrapperPrompt = 'wrapperPrompt';
  static const String wrapperPushState = 'wrapperPushState';
  static const String wrapperReplaceState = 'wrapperReplaceState';
  static const String wrapperRequestFullscreen = 'wrapperRequestFullscreen';
  static const String wrapperSetLocalStorage = 'wrapperSetLocalStorage';
  static const String wrapperSetTitle = 'wrapperSetTitle';
  static const String wrapperSetViewport = 'wrapperSetViewport';

  //UiServer
  static const String certAdd = 'certAdd';
  static const String certSelect = 'certSelect';
  static const String channelJoin = 'channelJoin';
  static const String dbQuery = 'dbQuery';
  static const String fileDelete = 'fileDelete';
  static const String fileGet = 'fileGet';
  static const String fileList = 'fileList';
  static const String fileNeed = 'fileNeed';
  static const String fileQuery = 'fileQuery';
  static const String fileRules = 'fileRules';
  static const String fileWrite = 'fileWrite';
  static const String siteInfo = 'siteInfo';
  static const String serverInfo = 'serverInfo';
  static const String sitePublish = 'sitePublish';
  static const String siteSign = 'siteSign';
  static const String siteUpdate = 'siteUpdate';
  static const String userGetSettings = 'userGetSettings';
  static const String userSetSettings = 'userSetSettings';

  //Plugins
  //Bigfile
  static const String bigfileUploadInit = 'bigfileUploadInit';
  //chartDbQuery
  static const String chartDbQuery = 'chartDbQuery';
  static const String chartGetPeerLocations = 'chartGetPeerLocations';
  //Cors
  static const String corsPermission = 'corsPermission';
  //CryptMessage
  static const String userPublickey = 'userPublickey';
  static const String eciesEncrypt = 'eciesEncrypt';
  static const String eciesDecrypt = 'eciesDecrypt';
  static const String aesEncrypt = 'aesEncrypt';
  static const String aesDecrypt = 'aesDecrypt';
  //Newsfeed
  static const String feedFollow = 'feedFollow';
  static const String feedListFollow = 'feedListFollow';
  static const String feedQuery = 'feedQuery';
  //MergerSite
  static const String mergerSiteAdd = 'mergerSiteAdd';
  static const String mergerSiteDelete = 'mergerSiteDelete';
  static const String mergerSiteList = 'mergerSiteList';
  //Mute
  static const String muteAdd = 'muteAdd';
  static const String muteRemove = 'muteRemove';
  static const String muteList = 'muteList';
  //OptionalManager
  static const String optionalFileList = 'optionalFileList';
  static const String optionalFileInfo = 'optionalFileInfo';
  static const String optionalFilePin = 'optionalFilePin';
  static const String optionalFileUnpin = 'optionalFileUnpin';
  static const String optionalFileDelete = 'optionalFileDelete';
  static const String optionalLimitStats = 'optionalLimitStats';
  static const String optionalLimitSet = 'optionalLimitSet';
  static const String optionalHelpList = 'optionalHelpList';
  static const String optionalHelp = 'optionalHelp';
  static const String optionalHelpRemove = 'optionalHelpRemove';
  static const String optionalHelpAll = 'optionalHelpAll';

  //Admin
  static const String as_ = 'as';

  static const String configSet = 'configSet';
  static Map configSetParams(Map<String, String> map) => map;

  static const String certSet = 'certSet';
  static Map certSetParams(String domain) => {'domain': domain};

  static const String channelJoinAllsite = 'channelJoinAllsite';
  static Map channelJoinAllsiteParams(String channel) => {'channel': channel};

  static const String serverPortcheck = 'serverPortcheck';

  static const String serverShutdown = 'serverShutdown';

  static const String serverUpdate = 'serverUpdate';

  static const String siteClone = 'siteClone';
  static Map siteCloneParams(
    String address,
    String root_inner_path,
  ) =>
      {
        'address': address,
        'root_inner_path': root_inner_path,
      };

  static const String siteList = 'siteList';

  static const String sitePause = 'sitePause';
  static Map sitePauseParams(String address) => {'address': address};

  static const String siteResume = 'siteResume';
  static Map siteResumeParams(String address) => {'address': address};
}
