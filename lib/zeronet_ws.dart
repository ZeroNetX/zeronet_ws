library zeronet_ws;

export ''
    if (dart.library.io) 'impls/io.dart'
    if (dart.library.html) 'impls/web.dart';
export 'extensions/futures.dart';
export 'lib.dart' show ZeroNet;
