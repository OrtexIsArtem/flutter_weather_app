import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/constants/app_base_data.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';
import 'package:flutter_weather_app/feature/domain/repositories/weather_repository.dart';

/// Use case responsible for fetching weather data for a city.
class GetCityWeather extends UseCase<WeatherEntity, GetCityWeatherParams> {
  /// Creates a [GetCityWeather] instance with the required dependencies.
  ///
  /// The [weatherRepository] is used for accessing weather data,
  /// and the [cityRepository] is used for accessing city data.
  const GetCityWeather({
    required this.weatherRepository,
    required this.cityRepository,
  });

  final WeatherRepository weatherRepository;
  final CityRepository cityRepository;

  /// Executes the use case to fetch weather data for a city.
  ///
  /// This method first attempts to retrieve the last saved city using the [cityRepository].
  /// If successful, it creates [GetCityWeatherParams] with the latitude and longitude of the last saved city.
  /// If the last saved city is not available, it uses the default latitude and longitude from [BaseLocation].
  ///
  /// Finally, it calls [getWeatherNow] on the [weatherRepository] with the latitude and longitude
  /// obtained from the previous steps to fetch the current weather data for the city.
  ///
  /// Parameters:
  ///   - params: The parameters required for fetching weather data. Not used directly in this method.
  ///
  /// Returns:
  ///   - A [Future] that resolves to an [Either] containing either a [Failure] if the operation fails,
  ///     or a [WeatherEntity] with the current weather data.
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

/// Parameters for fetching weather data for a city.
class GetCityWeatherParams extends Equatable {
  /// Creates a [GetCityWeatherParams] instance with the specified latitude and longitude.
  const GetCityWeatherParams({
    required this.latitude,
    required this.longitude,
  });

  /// The latitude of the city.
  final double? latitude;

  /// The longitude of the city.
  final double? longitude;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
