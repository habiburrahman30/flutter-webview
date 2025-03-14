import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview/src/pages/main_page.dart';
import 'package:get/get.dart';

import '../base/base.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _updateAppbar();

    super.initState();
    initAppConfig();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const MainPage());
    });
  }

  Future<void> initAppConfig() async {
    // AppLinks is singleton
    //Init onesignal
    await Base.onesignalNotificationController.initOnesignal();
    await Base.onesignalNotificationController.handlePromptForPushPermission();
  }

  void _updateAppbar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     // Color.fromARGB(255, 98, 178, 243),
            //     // Color.fromARGB(255, 50, 138, 216),
            //     // Color.fromARGB(255, 47, 107, 163),
            //     // Color.fromARGB(255, 23, 65, 110),
            //     Color(0xFFb4c6f7),
            //     Color(0xFF2a438a),
            //     Color(0xFF002385),
            //   ],
            // ),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
