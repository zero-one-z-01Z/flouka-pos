import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/helper_function/api.dart';
import '../../../language/presentation/provider/language_provider.dart';
class WebViewPage extends StatefulWidget {
  final String title;
  final String link;
  const WebViewPage({required this.title,required this.link,super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController controller = WebViewController();
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link),headers: {
        "Authorization": "${ApiHandel.getInstance.dio.options.headers['Authorization']}",
      });

  }
  @override
  Widget build(BuildContext context) {

    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LanguageProvider.translate('settings', widget.title)),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
