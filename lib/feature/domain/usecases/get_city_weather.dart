import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/weather_repository.dart';

class GetCityWeather extends UseCase<WeatherEntity, GetCityWeatherParams> {
  const GetCityWeather(this.weatherRepository);

  final WeatherRepository weatherRepository;

  @override
  Future<Either<Failure, WeatherEntity>> call(
      GetCityWeatherParams params) async {
    return await weatherRepository.getWeatherNow(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class GetCityWeatherParams extends Equatable {
  const GetCityWeatherParams({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
