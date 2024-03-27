import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.time,
    required this.temperature,
    required this.windSpeed,
    required this.speedUnit,
  });

  final String time;
  final double temperature;
  final double windSpeed;
  final String speedUnit;

  @override
  List<Object> get props => [
        time,
        temperature,
        windSpeed,
        speedUnit,
      ];

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
      time: json['current_weather']['time'],
      temperature: json['current_weather']['temperature'],
      windSpeed: json['current_weather']['windspeed'],
      speedUnit: json['current_weather_units']['windspeed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature': temperature,
      'windspeed': windSpeed,
      'speedUnit': speedUnit,
    };
  }
}
