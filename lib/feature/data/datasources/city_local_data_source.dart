import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_app/core/constants/app_local_keys.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/city_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Interface for a local data source that manages city data.
abstract interface class CityLocalDataSource {
  /// Retrieves all cities from the local cache.
  ///
  /// can throw [CacheException]
  List<CityModel> getAllCityFromCache();

  /// Stores the given list of cities in the local cache.
  ///
  /// can throw [CacheException]
  Future<bool> setCitiesToCache(List<CityModel> cities);

  /// Checks if there are any cities in the local cache.
  bool hasCitiesInCache();

  Future<bool> setCityToCache(CityModel city);

  Future<CityModel?> getLastCity();
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

    return jsonCityList
        .map((city) => CityModel.fromJson(json.decode(city)))
        .toList();
  }

  @override
  Future<bool> setCitiesToCache(List<CityModel> cities) async {
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

  @override
  Future<bool> setCityToCache(CityModel city) async {
    final jsonCity = json.encode(city.toJson());

    final response = await sharedPreferences.setString(
      AppLocalKeys.lastCity,
      jsonCity,
    );

    if (!response) throw CacheException();

    return Future.value(response);
  }

  @override
  Future<CityModel?> getLastCity() async {
    final jsonCity = sharedPreferences.getString(AppLocalKeys.lastCity);

    if (jsonCity == null || jsonCity.isEmpty) return null;
    final city = json.decode(jsonCity);
    return Future.value(CityModel.fromJson(city));
  }
}
