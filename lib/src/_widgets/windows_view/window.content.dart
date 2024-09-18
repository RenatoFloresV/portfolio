import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WindowContent extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final Function(double, double) onResize;
  final VoidCallback onMaximize;
  final WebViewController controller;

  const WindowContent({
    super.key,
    required this.width,
    required this.height,
    required this.url,
    required this.onClose,
    required this.onMinimize,
    required this.onResize,
    required this.onMaximize,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: width,
      height: height,
      child: Column(
        children: [
          AppBar(
            title: const Text('Web Window'),
            actions: [
              IconButton(
                icon: const Icon(Icons.minimize),
                onPressed: onMinimize,
              ),
              IconButton(
                icon: const Icon(Icons.crop_square),
                onPressed: onMaximize,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
