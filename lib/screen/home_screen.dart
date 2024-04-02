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

  Future<bool> handleWebViewBack() async {
    if (await inAppWebViewController.canGoBack()) {
      inAppWebViewController.goBack();
      return false;
    } else {
      // If you want to handle back navigation when there's no history
      // or customize the behavior, you can do so here.
      return true;
    }
  }

  Future<void> goBackWithJavaScript() async {
    await inAppWebViewController.evaluateJavascript(source: 'window.history.back();');
    }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  /*final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://aasmartdrivingschool.com"))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          debugPrint("progress==>$progress");
        },
        onPageStarted: (String url) {
        },
        onPageFinished: (String url) {},
      ),
    );*/
  // ..loadRequest(Uri.parse("https://motivateu.in/"));

  @override
  Widget build(BuildContext context) {

    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
    );

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Smart Driving School"),
        // ),
        body: Column(
          children: [
            if (!_webViewLoaded || _progress < 1)
              LinearProgressIndicator(
                color: Colors.redAccent,
                value: _progress,
              ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse("https://aasmartdrivingschool.com")),
                  initialOptions: options,
                  onWebViewCreated: (InAppWebViewController controller) {
                    inAppWebViewController = controller;
                  },
                  onLoadStop: (controller, url) {
                    controller.evaluateJavascript(source: "https://aasmartdrivingschool.com");
                        setState(() {
                      _webViewLoaded = true;
                    });
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                ),
            ),

          ],
        )
      ),
    );
  }
}

