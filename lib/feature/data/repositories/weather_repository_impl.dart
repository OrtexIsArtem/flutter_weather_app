import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/constants/app_base_data.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/platform/network_info.dart';
import 'package:flutter_weather_app/feature/data/datasources/weather_local_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_weather_app/feature/data/models/weather_model.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localeDataSource,
    required this.networkInfo,
  });

  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localeDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherNow({
    required double? latitude,
    required double? longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final WeatherModel weather = await remoteDataSource.getWeatherNow(
          latitude: latitude ?? BaseLocation.latitude,
          longitude: longitude ?? BaseLocation.longitude,
        );
        await localeDataSource.setWeatherToCache(weather);
        return Right(weather);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final weather = await localeDataSource.getLastCachedWeather();
        return Right(weather);
      } on CacheException catch(e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
