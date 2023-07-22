

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {

  Locale? _appLocale ;
  Locale? get appLocal => _appLocale ;


  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return null;
    }
    String local = prefs.getString('language_code') ?? 'en';
    _appLocale = Locale(local.toString());
    return null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type ==const Locale("es")) {
      print(type);
      _appLocale =const Locale("es");
      await prefs.setString('language_code', 'es');
      await prefs.setString('countryCode', 'es');
    } else {
      print(type);
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'en');
    }
    notifyListeners();
  }
}