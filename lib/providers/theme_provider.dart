import '../models/app_theme.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme obj = AppTheme(isDark: false);

  void changeTheme() {
    obj.isDark = !obj.isDark;
    notifyListeners();
  }
}
