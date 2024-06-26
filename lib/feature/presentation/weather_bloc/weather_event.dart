part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetCityWeatherEvent extends WeatherEvent {
  const GetCityWeatherEvent({
    this.latitude,
    this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
