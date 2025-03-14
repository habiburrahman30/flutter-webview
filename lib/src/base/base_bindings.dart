import 'package:get/get.dart';
import '../controller/config_controller.dart';
import '../controller/onesignal_notification_controller.dart';
import '../controller/webview_controller.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => ConfigController());
    Get.lazyPut(() => WebViewMobileController());
    Get.lazyPut(() => OnesignalNotificationController());
  }
}
