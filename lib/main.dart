import 'package:colorpallategenerator/providers/color_pallate_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'utils/appRoutes.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<ColorPallateGenerator>(
          create: (context) => ColorPallateGenerator(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: (Provider.of<ThemeProvider>(context).obj.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        title: "Currency Converter App",
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.pink),
          primaryColor: Colors.pink,
          backgroundColor: Colors.pink.shade100,
          iconTheme: IconThemeData(
            color: Colors.pink.shade500,
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.black54),
          backgroundColor: Colors.black54,
          primaryColor: Colors.pink.shade900,
          iconTheme: const IconThemeData(
            color: Colors.pink,
          ),
        ),
        initialRoute: AppRoutes().homePage,
        routes: routes,
      ),
    );
  }
}
