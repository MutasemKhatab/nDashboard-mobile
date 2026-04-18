import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchExternalUrl(String url) async {
  try {
    final uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      return false;
    }
    final result = await launchUrl(uri, mode: LaunchMode.externalApplication);
    return result;
  } catch (e) {
    if (kDebugMode) {
      rethrow;
    }
    return false;
  }
}
