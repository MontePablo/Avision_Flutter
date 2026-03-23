import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main() {
  runApp(const WebViewPage(data: ""));
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.data});
  final String data;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track loading status

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar (optional).
            print("Loading: $progress%");
          },
          onPageStarted: (String data) {
            print('Page started loading: $data');
            setState(() {
              _isLoading = true; // Show loading spinner
            });
          },
          onPageFinished: (String data) {
            print('Page finished loading: $data');
            setState(() {
              _isLoading = false; // Hide loading spinner
            });
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error: $error');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error:' + error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    if (widget.data.contains("http")) {
      _controller.loadRequest(
          Uri.parse('https://docs.google.com/viewer?url=${widget.data}&embedded=true'));
    } else {
      _controller.loadHtmlString(
          '<html><head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head><body>${widget.data}</body></html>');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        title: const Text(
          "",
          style: TextStyle(color: MyColors.white, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Change the color here
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          _isLoading // Show loading spinner while loading
              ? Center(
            child: SpinKitFadingCircle(
              color: MyColors.blue,
              size: MyConstants.sh * .1,
            ),
          )
              : const SizedBox.shrink(), // Hide spinner when page is loaded
        ],
      ),
    );
  }
}
