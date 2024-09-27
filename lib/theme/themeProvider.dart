
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeController extends GetxController {
  SharedPreferences? sharedPreferences;
  bool isDark = false;

  void setTheme() {
    isDark = !isDark;
    setSharedPreferences(isDark);

  }

  Future<void> setSharedPreferences(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool('theme', value);
  }

  ThemeProvider(bool theme){
    isDark = theme;
  }
}