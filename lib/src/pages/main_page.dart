import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../base/base.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   // backgroundColor: Color(0xFFEC6624),
        //   centerTitle: true,
        //   title: Image.asset(
        //     'assets/logo.png',
        //     height: 40,
        //   ),
        // ),
        // drawer: Drawer(),
        body: Base.webViewController.progressValue.value == 1.0
            ? SafeArea(
                child: WebViewWidget(
                  controller: Base.webViewController.webViewController,
                  layoutDirection: TextDirection.ltr,
                ),
              )
            : SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    semanticsLabel:
                        Base.webViewController.progressValue.value.toString(),
                    semanticsValue:
                        Base.webViewController.progressValue.value.toString(),
                    strokeWidth: 5,
                    value: Base.webViewController.progressValue.value,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFEC6624)),
                    color: Color(0xFFEC6624),
                  ),
                ),
              ),
      ),
    );
  }
}
