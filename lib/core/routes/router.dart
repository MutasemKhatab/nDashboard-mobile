import 'package:flutter/material.dart';
import 'route_paths.dart';
import '../../features/react_portal/presentation/pages/react_portal_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePaths.reactPortal:
      final args = settings.arguments as Map<String, dynamic>?;
      final initialUrl = args != null && args['initialUrl'] is String
          ? args['initialUrl'] as String
          : 'https://example.com';
      return MaterialPageRoute(
        builder: (_) => ReactPortalPage(initialUrl: initialUrl),
      );
    default:
      return null;
  }
}
