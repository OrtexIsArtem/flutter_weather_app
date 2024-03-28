import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/constants/app_base_data.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';
import 'package:flutter_weather_app/feature/domain/repositories/weather_repository.dart';

class GetCityWeather extends UseCase<WeatherEntity, GetCityWeatherParams> {
  const GetCityWeather({
    required this.weatherRepository,
    required this.cityRepository,
  });

  final WeatherRepository weatherRepository;
  final CityRepository cityRepository;

  @override
  Future<Either<Failure, WeatherEntity>> call(
      GetCityWeatherParams params) async {
    final failureOrCity = await cityRepository.gatLastCity();
    late GetCityWeatherParams cityWeatherParams;

    if (failureOrCity.isLeft()) {
      cityWeatherParams = const GetCityWeatherParams(
        latitude: BaseLocation.latitude,
        longitude: BaseLocation.longitude,
      );
    } else {
      final city = failureOrCity.getOrElse(() => null);
      cityWeatherParams = GetCityWeatherParams(
        latitude: city?.lat ?? BaseLocation.latitude,
        longitude: city?.lng ?? BaseLocation.longitude,
      );
    }

    return weatherRepository.getWeatherNow(
      latitude: cityWeatherParams.latitude!,
      longitude: cityWeatherParams.longitude!,
    );
  }
}

class GetCityWeatherParams extends Equatable {
  const GetCityWeatherParams({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
