import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/weather_model.dart';

abstract interface class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherNow({
    required double latitude,
    required double longitude,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  const WeatherRemoteDataSourceImpl({
    required this.client,
  });

  final Dio client;

  @override
  Future<WeatherModel> getWeatherNow({
    required double latitude,
    required double longitude,
  }) async {
    final response = await client.get(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true&timezone=auto',
    );

    if (response.statusCode != 200) throw ServerException();

    return WeatherModel.fromJson(response.data);
  }
}
