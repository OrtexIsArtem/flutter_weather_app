import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/weather_model.dart';

const String _baseUrl = 'https://api.open-meteo.com/v1';

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
    try {
      final response = await client.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current_weather': true,
          'timezone': 'auto'
        },
      );

      return WeatherModel.fromJsonApi(response.data);
    } catch (e) {
      throw ServerException();
    }
  }
}
