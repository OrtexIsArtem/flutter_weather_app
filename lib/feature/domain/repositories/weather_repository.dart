import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';

/// A repository for retrieving weather information.
///
/// The [WeatherRepository] provides methods to fetch weather data
/// either from a remote data source or from a local cache, depending
/// on the network connectivity status.
abstract class WeatherRepository {
  /// Retrieves the current weather information based on the provided
  /// latitude and longitude coordinates.
  ///
  /// If the network is available, the repository fetches the data from
  /// a remote data source and caches it locally. If the network is not
  /// available, the repository retrieves the last cached weather data.
  ///
  /// Throws a [ServerFailure] if there is an error while fetching data
  /// from the remote server, and throws a [CacheFailure] if there is an
  /// error while retrieving data from the local cache.
  ///
  /// Returns a [Right] containing the [WeatherEntity] if the operation
  /// is successful, or a [Left] containing a [Failure] otherwise.
  Future<Either<Failure, WeatherEntity>> getWeatherNow({
    required double latitude,
    required double longitude,
  });
}
