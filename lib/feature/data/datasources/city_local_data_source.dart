import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_app/core/constants/app_local_keys.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/city_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Interface for a local data source that manages city data.
abstract interface class CityLocalDataSource {
  /// Retrieves all cities from the local cache.
  List<CityModel> getAllCityFromCache();

  /// Stores the given list of cities in the local cache.
  Future<bool> setCityToCache(List<CityModel> cities);

  /// Checks if there are any cities in the local cache.
  bool hasCitiesInCache();
}

/// Implementation of [CityLocalDataSource] that uses shared preferences to manage city data locally.
class CityLocalDataSourceImpl implements CityLocalDataSource {
  /// Constructs a [CityLocalDataSourceImpl] instance with the provided [sharedPreferences].
  const CityLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  List<CityModel> getAllCityFromCache() {
    final List<String> jsonCityList =
        sharedPreferences.getStringList(AppLocalKeys.cityList) ?? [];
    if (jsonCityList.isEmpty) {
      throw CacheException();
    }
    return jsonCityList
        .map((city) => CityModel.fromJson(json.decode(city)))
        .toList();
  }

  @override
  Future<bool> setCityToCache(List<CityModel> cities) async {
    final List<String> jsonCityList =
        cities.map((city) => json.encode(city.toJson())).toList();

    final response = await sharedPreferences.setStringList(
      AppLocalKeys.cityList,
      jsonCityList,
    );
    if (response) {
      await sharedPreferences.setBool(AppLocalKeys.cityListIsNotEmpty, true);
      debugPrint('cities are cached');
    }
    return Future.value(response);
  }

  @override
  bool hasCitiesInCache() {
    return sharedPreferences.getBool(AppLocalKeys.cityListIsNotEmpty) ?? false;
  }
}
