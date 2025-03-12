import 'package:flutter_webview/src/controller/webview_controller.dart';
import 'package:get/get.dart';

class Base {
  Base._();
  static final webViewController = Get.find<WebViewMobileController>();
}
