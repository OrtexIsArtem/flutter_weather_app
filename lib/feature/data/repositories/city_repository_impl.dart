import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/constants/app_base_data.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/platform/network_info.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_local_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_remote_data_source.dart';
import 'package:flutter_weather_app/feature/data/models/city_model.dart';
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
        final List<CityModel> localCities =
            localDataSource.getAllCityFromCache();
        return Right(localCities);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    if (await networkInfo.isConnected) {
      try {
        final List<CityModel> remoteCity = await remoteDataSource.getAllCity();
        localDataSource.setCitiesToCache(remoteCity);
        return Right(remoteCity);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> searchCities(String? query) async {
    try {
      if (query == null || query.isEmpty) return const Right([]);

      final List<CityModel> allLocalCities =
          localDataSource.getAllCityFromCache();
      final List<CityModel> filteredCities = allLocalCities.where((city) {
        return city.city.toLowerCase().contains(query.toLowerCase()) ||
            city.country.toLowerCase().contains(query.toLowerCase());
      }).toList();

      return Right(filteredCities);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveCity(CityEntity city) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(ConnectionFailure());
    }
    try {
      final res = await localDataSource.setCityToCache(city as CityModel);
      return Right(res);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CityEntity?>> gatLastCity() async {
    try {
      final CityModel? city = await localDataSource.getLastCity();
      if (city != null) {
        return Right(city);
      }
      if (await networkInfo.isConnected) {
        final List<CityModel> remoteCity = await remoteDataSource.getAllCity();
        localDataSource.setCitiesToCache(remoteCity);
        final CityModel defaultCity = remoteCity.firstWhere(
          (city) =>
              city.city.toLowerCase() == BaseLocation.cityName.toLowerCase(),
        );
        await localDataSource.setCityToCache(defaultCity);

        return Right(defaultCity);
      } else {
        return const Left(ConnectionFailure());
      }
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
