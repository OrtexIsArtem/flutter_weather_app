import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/platform/network_info.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_local_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_remote_data_source.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';

/// Implementation of [CityRepository] that retrieves city data from remote and
/// local data sources, handling network and cache-related operations.
class CityRepositoryImpl implements CityRepository {
  /// Constructs a [CityRepositoryImpl] instance.
  ///
  /// Requires instances of [CityRemoteDataSource], [CityLocalDataSource], and [NetworkInfo].
  const CityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final CityRemoteDataSource remoteDataSource;
  final CityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CityEntity>>> getAllCity() async {
    final bool hasCitiesInCache = localDataSource.hasCitiesInCache();
    if (hasCitiesInCache) {
      try {
        final localCity = localDataSource.getAllCityFromCache();
        return Right(localCity);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    if (await networkInfo.isConnected) {
      try {
        final remoteCity = await remoteDataSource.getAllCity();
        localDataSource.setCityToCache(remoteCity);
        return Right(remoteCity);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
