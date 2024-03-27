import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  /// Constructs a [WeatherModel] instance with the provided parameters.
  const WeatherModel({
    required super.time,
    required super.temperature,
    required super.windSpeed,
    required super.speedUnit,
  });

  @override
  List<Object> get props => [
        time,
        temperature,
        windSpeed,
        speedUnit,
      ];

  /// Constructs a [WeatherEntity] instance from a JSON object.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: json['current_weather']['time'],
      temperature: json['current_weather']['temperature'],
      windSpeed: json['current_weather']['windspeed'],
      speedUnit: json['current_weather_units']['windspeed'],
    );
  }

  /// Converts the [WeatherEntity] instance to a JSON object.
  @override
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature': temperature,
      'windspeed': windSpeed,
      'speedUnit': speedUnit,
    };
  }
}
