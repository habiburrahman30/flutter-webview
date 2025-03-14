import 'package:flutter_webview/src/controller/webview_controller.dart';
import 'package:get/get.dart';

import '../controller/config_controller.dart';
import '../controller/onesignal_notification_controller.dart';

class Base {
  Base._();
  static final configController = Get.find<ConfigController>();
  static final webViewController = Get.find<WebViewMobileController>();
  static final onesignalNotificationController =
      Get.find<OnesignalNotificationController>();
}
