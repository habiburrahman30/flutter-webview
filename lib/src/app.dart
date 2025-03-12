import 'package:flutter/material.dart';
import 'package:flutter_webview/src/pages/splash_page.dart';
import 'package:get/get.dart';

import 'base/base_bindings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'competitii',

      // initialRoute: '/',
      initialBinding: BaseBindings(),
      debugShowCheckedModeBanner: false,
      // getPages: GetxRouteGenerator.appRoutes(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        textSelectionTheme: TextSelectionThemeData(
            // selectionHandleColor: AppTheme.primaryColor,
            ),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
