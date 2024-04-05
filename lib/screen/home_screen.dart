import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _progress = 0;
  bool _webViewLoaded = false;
  late InAppWebViewController inAppWebViewController;

  @override
  void dispose() {
    inAppWebViewController.stopLoading();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse("https://aasmartdrivingschool.com")),
              initialOptions: options,
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source: "https://aasmartdrivingschool.com");
                setState(() {
                  _webViewLoaded = true;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                  debugPrint("Progress value-->${progress / 100}");
                });
              },
            ),
            // if (!_webViewLoaded || _progress < 1)
            if (!_webViewLoaded || _progress < 1)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child:CircularProgressIndicator(color: Colors.black.withOpacity(0.5),)

                  // LinearProgressIndicator(
                  //   color: Colors.redAccent,
                  //   value: _progress,
                  // ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
