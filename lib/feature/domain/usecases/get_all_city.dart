import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';

/// Use case that retrieves a list of all cities.
class GetAllCity extends UseCase<List<CityEntity>, NoParams> {
  /// Constructs a [GetAllCity] instance with the provided [cityRepository].
  const GetAllCity(this.cityRepository);

  /// The city repository used to retrieve city data.
  final CityRepository cityRepository;

  @override
  Future<Either<Failure, List<CityEntity>>> call([NoParams? params]) async {
    return await cityRepository.getAllCity();
  }
}
