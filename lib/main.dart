import 'package:flutter/material.dart';
import 'package:flutter_weather_app/app.dart';
import 'package:flutter_weather_app/locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const App());
}
