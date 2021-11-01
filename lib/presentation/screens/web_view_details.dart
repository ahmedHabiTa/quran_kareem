import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDetails extends StatelessWidget {
  static const routeName = '/WebViewDetails';

  @override
  Widget build(BuildContext context) {
    var videoLink = ModalRoute.of(context).settings.arguments as String ;
    return Scaffold(
      body: WebView(
        initialUrl: videoLink,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
