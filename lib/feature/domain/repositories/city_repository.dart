import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';

/// Repository for managing city data, providing methods for retrieving cities from
/// different sources such as a remote server and local cache.
abstract class CityRepository {
  /// Retrieves a list of cities, from cache if possible, or remotely.
  ///
  /// Returns a [List] of [CityEntity] if successful, or a [Failure] otherwise.
  Future<Either<Failure, List<CityEntity>>> getAllCity();
}
