import 'package:flutter_webview/src/helpers/klog.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewMobileController extends GetxController {
  late WebViewController webViewController;
  late final PlatformWebViewControllerCreationParams params;

  final progressValue = RxDouble(0.0);

  @override
  void onInit() {
    super.onInit();
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    webViewController = WebViewController.fromPlatformCreationParams(params);

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // Assuming you have a method to update the loading bar on the screen.

            klog('Page loading progress: $progress');
            progressValue.value = progress.toDouble() / 100;
            klog('Page loading progressValue: ${progressValue.value}');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            webViewController.runJavaScript('''
          var header = document.querySelector('header'); // Use the correct selector
          if (header) {
            header.style.display = 'none !important'; // Hide the header
          }
        ''');
            // webViewController.runJavaScript(
            //   // "document.getElementsByTagName('header')[0].style.display='none';",
            //   "javascript:document.getElementsByClassName('header d-flex align-items-center sticky-top shadow-lg')[0].style.display='none !important'",
            // );
            //         webViewController.runJavaScript('''
            //   var element = document.querySelector('#header');
            //   if (element) {
            //     element.style.display = 'none';
            //   }
            // ''');
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://competitii.co.uk/'),
      );
  }
}
