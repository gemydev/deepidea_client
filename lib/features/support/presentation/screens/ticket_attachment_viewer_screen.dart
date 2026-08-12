import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';

/// In-app preview of a ticket attachment URL with open-in-browser and download actions.
class TicketAttachmentViewerScreen extends StatefulWidget {
  const TicketAttachmentViewerScreen({
    super.key,
    required this.url,
    required this.suggestedFileName,
  });

  final String url;
  final String suggestedFileName;

  @override
  State<TicketAttachmentViewerScreen> createState() => _TicketAttachmentViewerScreenState();
}

class _TicketAttachmentViewerScreenState extends State<TicketAttachmentViewerScreen> {
  late final WebViewController _webViewController;
  var _loading = true;
  var _downloading = false;

  @override
  void initState() {
    super.initState();
    final uri = Uri.tryParse(widget.url);
    _webViewController = WebViewController()
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
      );
    if (uri != null && uri.hasScheme) {
      _webViewController.loadRequest(uri);
    } else {
      _loading = false;
    }
  }

  Future<void> _openInBrowser() async {
    final uri = Uri.tryParse(widget.url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _downloadToDevice() async {
    if (_downloading) return;
    setState(() => _downloading = true);
    try {
      final dio = Dio();
      Directory? dir = await getDownloadsDirectory();
      dir ??= await getApplicationDocumentsDirectory();

      var name = widget.suggestedFileName.trim();
      if (name.isEmpty || name == '/') {
        name = 'attachment';
      }
      if (!name.contains('.')) {
        name = '$name.bin';
      }
      final safeName = name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      var path = '${dir.path}/$safeName';
      if (await File(path).exists()) {
        final base = safeName.contains('.')
            ? safeName.substring(0, safeName.lastIndexOf('.'))
            : safeName;
        final ext = safeName.contains('.') ? safeName.substring(safeName.lastIndexOf('.')) : '';
        path = '${dir.path}/${base}_${DateTime.now().millisecondsSinceEpoch}$ext';
      }

      await dio.download(widget.url, path);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم الحفظ: $path')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذّر التحميل: $e')),
      );
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.white,
      appBar: AppBar(
        backgroundColor: CustomColorsManager.white,
        elevation: 0,
        foregroundColor: CustomColorsManager.black,
        title: CustomText(
          'عرض المرفق',
          style: CustomStyleManger.heading1.copyWith(fontSize: 16, color: CustomColorsManager.black),
        ),
        actions: [
          if (_downloading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: _downloadToDevice,
              tooltip: 'تحميل',
            ),
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: _openInBrowser,
            tooltip: 'فتح في المتصفح',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

String suggestedAttachmentFileName(String fileUrl, int docId) {
  try {
    final uri = Uri.parse(fileUrl);
    final seg = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    if (seg.isNotEmpty) return seg;
  } catch (_) {}
  return 'file_$docId';
}
