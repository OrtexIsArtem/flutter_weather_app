part of 'weather_bloc.dart';


class WeatherErrorLoading extends BlocError {
  const WeatherErrorLoading({
    required super.message,
  });
}

class WeatherState extends Equatable {
  const WeatherState({
    this.isLoading = false,
    this.error,
    this.currentWeather,
  });

  final bool isLoading;
  final WeatherErrorLoading? error;
  final WeatherEntity? currentWeather;

  WeatherState copyWith({
    bool? isLoading,
    WeatherErrorLoading? error,
    WeatherEntity? currentWeather,
  }) {
    return WeatherState(
      isLoading: isLoading ?? false,
      error: error ?? this.error,
      currentWeather: currentWeather ?? this.currentWeather,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        currentWeather,
      ];
}
