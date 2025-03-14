import 'package:get/get.dart';

import '../base/base.dart';
import '../helpers/route.dart';
import '../pages/main_page.dart';

class ConfigController extends GetxController {
  @override
  void onInit() async {
    await initAppConfig();

    super.onInit();
  }

  @override
  void onReady() async {
    await 2.delay();

    await readyToGo();

    super.onReady();
  }

  Future<void> initAppConfig() async {
    // AppLinks is singleton
    //Init onesignal
    await Base.onesignalNotificationController.initOnesignal();
    await Base.onesignalNotificationController.handlePromptForPushPermission();
  }

  Future<void> initLocalDB() async {}

  Future<void> readyToGo() async {
    offAll(MainPage());
  }
}
