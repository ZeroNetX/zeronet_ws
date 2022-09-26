# zeronet_ws

ZeroNet Web Socket Package is dart library to connect and get data from [ZeroNet](https://github.com/canewsin/ZeroNet) Network, This package does not include zeronet client hence, it works only when there already an existing client on host system running this package.

# Flutter Web Support

Add below line in your index.html

```html
<head>
...
<script type="text/javascript" src="assets/packages/zeronet_ws/js/ZeroFrame.js"></script>
</head>
```

Flutter Web Apps needs monkeyPatching to load files, thus index.html' should load _flutter Engine as below without this your Web App will failed to load.
```html
<body>
  <script>
    // `frame` variable is accessed by bindings of lib, thus name should not be changed.
    var frame = new ZeroFrame();
    frame.monkeyPatchAjax();
    frame.cmd("siteInfo", [], function () {
      var script = document.createElement("script");
      script.src = "main.dart.js";
      script.type = "text/javascript";
      document.body.appendChild(script);

      //Uncomment Below for MaterialIcons Support
      /*
      script = document.createElement("script");
      script.src = "assets/fonts/MaterialIcons-Regular.otf";
      script.type = "application/octet-stream";
      document.body.appendChild(script);
      */

      _flutter.loader.loadEntrypoint(null).then(function (engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function (appRunner) {
        return appRunner.runApp();
      });
    });
  </script>
</body>
```

## Build

```flutter build web --pwa-strategy=none --dart-define=SITE_ADDR=1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M --dart-define=FLUTTER_WEB_CANVASKIT_URL=/raw/1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M/canvaskit/ --base-href=/1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M/```

> Note: In the above build step `1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M` is example site address, You need to replace that address with your own.

See flutter_template https://github.com/ZeroNetX/flutter_template for full example
