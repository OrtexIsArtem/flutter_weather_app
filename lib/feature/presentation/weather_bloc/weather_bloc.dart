import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/errors/bloc_errors.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_city_weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

/// Represents the BLoC responsible for managing weather-related data.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  /// Creates a [WeatherBloc] instance with the required dependencies.
  ///
  /// The [getCityWeather] function is used for fetching city weather data.
  WeatherBloc({
    required this.getCityWeather,
  }) : super(const WeatherState()) {
    /// Handles the event to get weather data for a city.
    on<GetCityWeatherEvent>(_onGetCityWeather);
  }

  final GetCityWeather getCityWeather;

  Future<void> _onGetCityWeather(
    GetCityWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrCityWeather = await getCityWeather(
      GetCityWeatherParams(
        latitude: event.latitude,
        longitude: event.longitude,
      ),
    );

    failureOrCityWeather.fold(
      (failure) {
        emit(state.copyWith(
          error: WeatherErrorLoading(message: failure.message ?? ''),
        ));
      },
      (WeatherEntity weather) {
        emit(state.copyWith(
          currentWeather: weather,
        ));
      },
    );
  }
}
