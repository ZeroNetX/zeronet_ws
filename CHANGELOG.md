## [1.0.0]
 - Implemented Full Core & Main Plugin API with Proper return type
 - Full Changelog https://github.com/ZeroNetX/zeronet_ws/compare/4e97bfb7...73e9d309

 ## [0.0.8]
 - Add Support for Flutter Web Apps, See README.md for more Info on config needed.
 - Added flutter_lint and implement suggession.
 - Full Changelog https://github.com/ZeroNetX/zeronet_ws/compare/73e9d309...715ddb4e


## [0.0.7]

- Add `wrapperKey_` arg for connect method, usefull in web platform.
- Replace `IOWebSocketChannel` with `WebSocketChannel` to improve support for web platform.
- Various Bug fixes in method channels.

## [0.0.6]

- Remove unused imports.
- Better Describe Project in pubspec.yaml.
- Improve certAddFuture function handling.
- Made sqlparams of dbQueryFuture function optional.
- Add privatekey param for signSiteFuture function.
- Don't fail cmdFuture function on else case silentely.
- catch null case on json parsing of Content.fromJson.

## [0.0.5]

* Properely Store and call callbacks queried previously and when received from server.
* Add missing cmds permissionAdd, permissionRemove, permissionDetails and AdminExt methods for them.
* Add missing params for some methods.

## [0.0.4]

* Null Safety
* Add Individual ZeroNet Message Types and methods (both Callback model and Future model)

## [0.0.3]

* Breaking Changes for ZeroNet.connect() method, changed params required.

## [0.0.2]

* Upgrade Dependencies.

## [0.0.1]

* Initial Release.
