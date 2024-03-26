import 'package:flutter/material.dart';
import 'package:flutter_weather_app/feature/presentation/pages/home_page/home_page.dart';
import 'package:flutter_weather_app/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter weather app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
