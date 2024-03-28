import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';

/// Use case responsible for saving a city.
class SaveCity extends UseCase<bool, SaveCityParams> {
  /// Creates a [SaveCity] instance with the specified [cityRepository].
  ///
  /// The [cityRepository] is used for accessing city data.
  const SaveCity(this.cityRepository);

  /// The city repository used to retrieve city data.
  final CityRepository cityRepository;

  @override
  Future<Either<Failure, bool>> call(SaveCityParams params) async {
    return await cityRepository.saveCity(params.city);
  }
}

/// Parameters for saving a city.
class SaveCityParams extends Equatable {
  /// Creates a [SaveCityParams] instance with the specified [city].
  const SaveCityParams({
    required this.city,
  });

  /// The city entity to be saved.
  final CityEntity city;

  @override
  List<Object?> get props => [city];
}
