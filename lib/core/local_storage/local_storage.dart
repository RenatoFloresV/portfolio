import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _languageKey = 'language';
  static const String _iconsPositionsKey = 'icons_positions';

  static const String _themeKey = 'theme';

  Future<void> saveThemeMode(ThemeData themeData) async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = jsonEncode({
      'brightness': themeData.brightness.toString(),
    });
    await prefs.setString(_themeKey, themeModeString);
  }

  Future<ThemeData?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeKey);
    if (themeModeString == null) {
      return null;
    }
    try {
      final themeModeMap = jsonDecode(themeModeString);
      final brightness = themeModeMap['brightness'] as String;
      return brightness == 'Brightness.light'
          ? ThemeData.light()
          : ThemeData.dark();
    } catch (e) {
      print('Error parsing theme mode: $e');
      return null;
    }
  }

  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey);
  }

  Future<void> saveIconsPositions(List<Offset> positions) async {
    final prefs = await SharedPreferences.getInstance();
    final positionsString = positions.map((p) => '${p.dx},${p.dy}').join(';');
    await prefs.setString(_iconsPositionsKey, positionsString);
  }

  Future<List<Offset>> getIconsPositions() async {
    final prefs = await SharedPreferences.getInstance();
    final positionsString = prefs.getString(_iconsPositionsKey) ?? '';
    if (positionsString.isEmpty) {
      return [];
    }
    try {
      return positionsString.split(';').map((p) {
        final parts = p.split(',');
        return Offset(double.parse(parts[0]), double.parse(parts[1]));
      }).toList();
    } catch (e) {
      print('Error al parsear posiciones de iconos: $e');
      return [];
    }
  }
}
