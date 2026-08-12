import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../helper_function/api.dart';

class PaymentOnlinePage extends StatefulWidget {
  final num total;
  final String type;
  const PaymentOnlinePage({required this.total, super.key, required this.type});

  @override
  State<PaymentOnlinePage> createState() => _PaymentOnlinePageState();
}

class _PaymentOnlinePageState extends State<PaymentOnlinePage> {
  WebViewController? controller;

  String get _paymentUrl =>
      '${Constants.baseUri}payment/${widget.total}/${widget.type}';

  Future<void> _openExternal() async {
    final uri = Uri.parse(_paymentUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _openExternal());
      return;
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView Error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            String url = request.url;
            if (url.contains('status=failed') && !url.contains('callback')) {
              navPop('field');
              return NavigationDecision.prevent;
            } else if (url.contains('status=paid') &&
                !url.contains('callback')) {
              debugPrint('paid');
              debugPrint(url);
              navPop('paid');
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(_paymentUrl),
        headers: {
          'Authorization':
              '${ApiHandel.getInstance.dio.options.headers['Authorization']}',
          'Accept': 'application/json',
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LanguageProvider.translate("global", "payment_page")),
        ),
        body: kIsWeb
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.payment, size: 40),
                      const SizedBox(height: 12),
                      Text(
                        _paymentUrl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: _openExternal,
                        child: const Text('Open payment in browser'),
                      ),
                    ],
                  ),
                ),
              )
            : WebViewWidget(controller: controller!),
      ),
    );
  }
}
