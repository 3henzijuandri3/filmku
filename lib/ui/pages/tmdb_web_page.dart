import 'package:filmku/controllers/auth_controller.dart';
import 'package:filmku/controllers/main_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class TmdbWebPage extends StatefulWidget {
  final String requestToken;

  const TmdbWebPage({super.key, required this.requestToken});

  @override
  State<TmdbWebPage> createState() => _TmdbWebPageState();
}

class _TmdbWebPageState extends State<TmdbWebPage> {
  final authStateController = Get.put(AuthContrroller());
  final navigationStateController = Get.put(MainNavigationController());

  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },

          onPageStarted: (String url) {},

          onPageFinished: (String url) async {
            if (url.contains('/allow')) {
              final getSessionId = await authStateController.createSessionId(Get.arguments as String);

              if(getSessionId){
                Get.offNamed('/');
              }
            }
          },

          onWebResourceError: (WebResourceError error) {},

          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.themoviedb.org/authenticate/${Get.arguments as String}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final isLoading = authStateController.isLoading.value;

        return Stack(
          children: [
            // WebView
            WebViewWidget(controller: webViewController!),

            if(isLoading)
              Stack(
                children: [
                  // Overlay
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                  ),

                  // Circular Bar
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
          ],
        );
      }),
    );
  }
}
