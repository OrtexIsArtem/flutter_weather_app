import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';

/// Use case responsible for retrieving the last saved city.
class GetLastCity extends UseCase<CityEntity?, NoParams?> {
  /// Creates a [GetLastCity] instance with the specified [cityRepository].
  ///
  /// The [cityRepository] is used for accessing city data.
  const GetLastCity(this.cityRepository);

  final CityRepository cityRepository;

  @override
  Future<Either<Failure, CityEntity?>> call([NoParams? params]) async {
    return await cityRepository.gatLastCity();
  }
}
