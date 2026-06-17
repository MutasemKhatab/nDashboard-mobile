import 'dart:io';
import 'package:dynamic_app_icon_flutter_plus/dynamic_app_icon_flutter_plus.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconService {
  IconService._();

  static const _key = 'active_icon';
  static const _channel = MethodChannel('icon_service');

  static Future<void> setIconA() async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod('switchIcon', {
          'alias': 'MainActivityIconA',
        });
      } else {
        await DynamicAppIconFlutterPlus.setAlternateIconName(null);
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, 'A');
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> setIconB() async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod('switchIcon', {
          'alias': 'MainActivityIconB',
        });
      } else {
        await DynamicAppIconFlutterPlus.setAlternateIconName('IconB');
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, 'B');
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<String> getCurrentIcon() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'A';
  }
}
