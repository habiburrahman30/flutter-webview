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
        backgroundColor: Colors.black,
        body: Base.webViewController.progressValue.value == 1.0
            ? SafeArea(
                child: WebViewWidget(
                  controller: Base.webViewController.webViewController,
                  layoutDirection: TextDirection.ltr,
                ),
              )
            : SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircularProgressIndicator(
                      semanticsLabel:
                          Base.webViewController.progressValue.value.toString(),
                      semanticsValue:
                          Base.webViewController.progressValue.value.toString(),
                      strokeWidth: 5,
                      value: Base.webViewController.progressValue
                          .value, // Observe progress changes
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
