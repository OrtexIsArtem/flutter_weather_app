import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/data/models/city_model.dart';

/// Interface for a remote data source that manages city data.
abstract interface class CityRemoteDataSource {
  /// Retrieves all cities from the remote data source.
  Future<List<CityModel>> getAllCity();
}

/// Implementation of [CityRemoteDataSource] that retrieves city data from a remote server using Dio.
class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  /// Constructs a [CityRemoteDataSourceImpl] instance with the provided [client].
  const CityRemoteDataSourceImpl({
    required this.client,
  });

  final Dio client;

  @override
  Future<List<CityModel>> getAllCity() async {
    final response = await client.get(
        'https://raw.githubusercontent.com/JetSetExpert/cities-json/master/data/cities.json');

    if (response.statusCode != 200) throw ServerException();

    final List<CityModel> cities = (json.decode(response.data) as List)
        .map((json) => CityModel.fromJson(json))
        .toList();

    return cities;
  }
}
