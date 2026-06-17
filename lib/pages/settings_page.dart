import 'package:flutter/material.dart';
import 'dart:io';
import '../services/icon_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _activeIcon = 'A';

  @override
  void initState() {
    super.initState();
    _loadIcon();
  }

  void _loadIcon() async {
    final icon = await IconService.getCurrentIcon();
    setState(() {
      _activeIcon = icon;
    });
  }

  void _updateIcon(String value) async {
    if (value == 'A') {
      await IconService.setIconA();
    } else {
      await IconService.setIconB();
    }
    setState(() {
      _activeIcon = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'App Icon',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            title: const Text('Icon A (Default)'),
            trailing: _activeIcon == 'A'
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () => _updateIcon('A'),
          ),
          ListTile(
            title: const Text('Icon B'),
            trailing: _activeIcon == 'B'
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () => _updateIcon('B'),
          ),
          if (Platform.isIOS)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'A system dialog will appear to confirm the change.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
