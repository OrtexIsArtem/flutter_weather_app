import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';

class SaveCity extends UseCase<bool, SaveCityParams> {
  const SaveCity(this.cityRepository);

  /// The city repository used to retrieve city data.
  final CityRepository cityRepository;

  @override
  Future<Either<Failure, bool>> call(SaveCityParams params) async {
    return await cityRepository.saveCity(params.city);
  }
}

class SaveCityParams extends Equatable {
  const SaveCityParams({
    required this.city,
  });

  final CityEntity city;

  @override
  List<Object?> get props => [city];
}
