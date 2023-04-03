import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/style.dart';
import 'package:kuaca_bali/helper/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferenceProvider({required this.preferencesHelper}) {
    _getTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  set enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _isDarkTheme = value;
    notifyListeners();
  }
}
