@JS('frame')
library bindings.js;

import 'package:js/js.dart';

external void cmd(String cmd, List params);

external Object cmdp(String cmd, [List params]);

external void onRequest(String cmd, Function handler);
