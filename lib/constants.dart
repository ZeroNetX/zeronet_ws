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
  static const String announcerInfo = 'announcerInfo';
  static const String certAdd = 'certAdd';
  static const String certSelect = 'certSelect';
  static const String channelJoin = 'channelJoin';
  static const String dbQuery = 'dbQuery';
  static const String dirList = 'dirList';
  static const String fileDelete = 'fileDelete';
  static const String fileGet = 'fileGet';
  static const String fileList = 'fileList';
  static const String fileNeed = 'fileNeed';
  static const String fileQuery = 'fileQuery';
  static const String fileRules = 'fileRules';
  static const String fileWrite = 'fileWrite';
  static const String ping = 'ping';
  static const String siteInfo = 'siteInfo';
  static const String serverInfo = 'serverInfo';
  static const String sitePublish = 'sitePublish';
  static const String siteReload = 'siteReload';
  static const String siteSign = 'siteSign';
  static const String siteUpdate = 'siteUpdate';
  static const String userGetSettings = 'userGetSettings';
  static const String userGetGlobalSettings = 'userGetGlobalSettings';
  static const String userSetSettings = 'userSetSettings';

  //Plugins
  //Bigfile
  static const String bigfileUploadInit = 'bigfileUploadInit';
  static const String siteSetAutodownloadBigfileLimit =
      'siteSetAutodownloadBigfileLimit';
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
  static const String ecdsaSign = 'ecdsaSign';
  static const String ecdsaVerify = 'ecdsaVerify';
  static const String eccPrivToPub = 'eccPrivToPub';
  static const String eccPubToAddr = 'eccPubToAddr';
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
  static const String filterIncludeAdd = 'filterIncludeAdd';
  static const String filterIncludeRemove = 'filterIncludeRemove';
  static const String filterIncludeList = 'filterIncludeList';
  static const String siteblockIgnoreAddSite = 'siteblockIgnoreAddSite';
  static const String siteblockAdd = 'siteblockAdd';
  static const String siteblockRemove = 'siteblockRemove';
  static const String siteblockList = 'siteblockList';
  static const String siteblockGet = 'siteblockGet';
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
  static const String permissionAdd = 'permissionAdd';
  static const String permissionRemove = 'permissionRemove';
  static const String permissionDetails = 'permissionDetails';
  static const String userSetGlobalSettings = 'userSetGlobalSettings';
  static const String certList = 'certList';
  static const String certSet = 'certSet';
  static const String channelJoinAllsite = 'channelJoinAllsite';
  static const String serverPortcheck = 'serverPortcheck';
  static const String serverShutdown = 'serverShutdown';
  static const String serverUpdate = 'serverUpdate';
  static const String siteClone = 'siteClone';
  static const String siteList = 'siteList';
  static const String sitePause = 'sitePause';
  static const String siteResume = 'siteResume';

  //Multiuser
  static const String userShowMasterSeed = 'userShowMasterSeed';
  static const String userLogout = 'userLogout';
  static const String userSet = 'userSet';

  //Multiuser: yet to be implemented
  static const String userSelectForm = 'userSelectForm';
  static const String userLoginForm = 'userLoginForm';
}
