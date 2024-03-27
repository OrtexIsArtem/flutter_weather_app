import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/feature/presentation/city_bloc/city_bloc.dart';
import 'package:flutter_weather_app/feature/presentation/pages/home_page/home_page.dart';
import 'package:flutter_weather_app/feature/presentation/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/locator_service.dart';
import 'package:flutter_weather_app/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityBloc>(
          create: (context) => sl<CityBloc>()..add(const LoadLastCityEvent()),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) =>
              sl<WeatherBloc>()..add(const GetCityWeatherEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter weather app',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}
