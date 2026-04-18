import 'package:flutter/material.dart';
import 'package:nleads/features/react_portal/presentation/pages/react_portal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nLeads',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color(0xff9acd32))),
      home: const ReactPortalPage(
        initialUrl: 'http://129.121.77.116/apps/nLeads/',
      ),
    );
  }
}
