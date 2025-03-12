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
            klog('Page finished loading: $url');
            // Execute JavaScript to hide the element by its ID
            //     webViewController.runJavaScript('''
            //   var element = document.getElementById('your-element-id');
            //   console.log(element); // Debugging: Log the element
            //   if (element) {
            //     element.style.display = 'none';
            //   } else {
            //     console.log('Element not found'); // Debugging: Log if element is not found
            //   }
            // ''');
            //================================================================
            // Execute JavaScript to hide the header after the page has fully loaded
            //     webViewController.runJavaScript('''
            //   var element = document.querySelector('.col-8.col-md-8.text-center.align-self-center.wpslabtop.wpslab8');
            //   console.log(element); // Debugging: Log the element
            //   if (element) {
            //     element.style.display = 'none';
            //   } else {
            //     console.log('Element not found'); // Debugging: Log if element is not found
            //   }
            // ''');

            webViewController.runJavaScript('''
                // Hide the outer div with class "row wpslabtop wpslab6"
                var outerDiv = document.querySelector('.row.wpslabtop.wpslab6');
                if (outerDiv) {
             var element = document.querySelector('.col-8.col-md-8.text-center.align-self-center.wpslabtop.wpslab8');
                    console.log(element); // Debugging: Log the element
                    if (element) {
                      element.style.display = 'none';
                    } else {
                      console.log('Element not found'); // Debugging: Log if element is not found
                    }

                var element1 = document.querySelector('.col-md-2');
                if (element1) {
                element1.style.display = 'none';
                
                  // Remove the class "col-md-2"
                  // element1.classList.remove('col-md-2');

                  // Add the class "col-md-6"
                  // element1.classList.add('col-md-6');
                }

                 var element2 = document.querySelector('.col-12');
                   if (element2) {
                    element2.style.display = 'none';

                  // Remove the class "col-md-2"
                  // element2.classList.remove('col-12');

                  // Add the class "col-md-6"
                  // element2.classList.add('col-6');
                }

                //  var element3 = document.querySelector('.top-social');
                //    if (element3) {
                //   // Remove the class "col-md-2"
                //   element3.classList.remove('top-social');

                //    }
                }

              ''');
          },
          onHttpError: (HttpResponseError error) {
            klog('HTTP error: ${error.response}');
          },
          onWebResourceError: (WebResourceError error) {
            klog('Web resource error: ${error.description}');
          },
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
