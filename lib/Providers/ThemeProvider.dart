
import 'package:flutter/material.dart';



class ThemeProvider extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get isDarkMode =>  _isDarkMode;
ThemeMode get themeMode=> _isDarkMode ? ThemeMode.dark : ThemeMode.light;

void toggelTheme(){
  _isDarkMode =!_isDarkMode;
  notifyListeners();
}

}