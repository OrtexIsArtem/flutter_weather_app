import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/weather_model.dart';

/// Base URL for the Open Meteo API.
const String _baseUrl = 'https://api.open-meteo.com/v1';

/// An interface for fetching weather data from a remote data source.
abstract interface class WeatherRemoteDataSource {
  /// Fetches the current weather information for the given [latitude] and [longitude].
  ///
  /// Throws a [ServerException] if there is an error fetching data from the server.
  Future<WeatherModel> getWeatherNow({
    required double latitude,
    required double longitude,
  });
}

/// Implementation of the [WeatherRemoteDataSource] interface.
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  /// Creates a [WeatherRemoteDataSourceImpl] instance with the specified [client].
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
