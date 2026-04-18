import 'package:flutter/material.dart';

class WebViewLoadingIndicator extends StatelessWidget {
  final double progress;
  const WebViewLoadingIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3,
      child: LinearProgressIndicator(
        value: progress < 0.0 ? 0.0 : (progress > 1.0 ? 1.0 : progress),
      ),
    );
  }
}
