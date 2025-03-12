import 'package:get/get.dart';
import '../controller/webview_controller.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebViewMobileController());
  }
}
