import 'package:flutter/material.dart';
import 'package:ndashboard/features/react_portal/presentation/pages/react_portal_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'nDashboard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff855ba5)),
        ),
        home: const ReactPortalPage(
          initialUrl: 'http://129.121.77.116/apps/nDashboard',
        ),
      ),
    );
  }
}
