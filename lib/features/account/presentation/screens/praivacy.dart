import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  static const String url = 'https://dev2.newgooobig.com/TECHPLACE_PRIVACY_POLICY.html';

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (_) {
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(Privacy.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            const SubAppBar(title: "سياسة الخصوصية"),
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_loading) const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
