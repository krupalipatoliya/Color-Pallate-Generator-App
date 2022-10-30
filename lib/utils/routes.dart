
import 'package:flutter/cupertino.dart';

import '../views/homeScreen/pages/homepage.dart';
import 'appRoutes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().homePage: (context) => const HomePage()
};
