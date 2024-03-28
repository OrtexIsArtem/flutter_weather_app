import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/core/constants/app_local_keys.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class WeatherLocalDataSource {
  /// Retrieves the last cached weather data.
  ///
  /// Throws a [CacheException] if there is no data in the cache.
  Future<WeatherModel> getLastCachedWeather();

  /// Caches the provided [weather] data.
  ///
  /// Returns `true` if the operation was successful, `false` otherwise.
  Future<bool> setWeatherToCache(WeatherModel weather);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  const WeatherLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<WeatherModel> getLastCachedWeather() async {
    final jsonWeather = sharedPreferences.getString(AppLocalKeys.lastWeather);
    if (jsonWeather == null || jsonWeather.isEmpty) {
      throw CacheException('No data in cache');
    }
    return WeatherModel.fromJsonCache(json.decode(jsonWeather));
  }

  @override
  Future<bool> setWeatherToCache(WeatherModel weather) async {
    final String jsonWeather = json.encode(weather.toJson());

    final bool response = await sharedPreferences.setString(
      AppLocalKeys.lastWeather,
      jsonWeather,
    );
    if (response) {
      await sharedPreferences.setBool(AppLocalKeys.cityListIsNotEmpty, true);
      debugPrint('Weather is cached');
    }
    return response;
  }
}
