import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/errors/bloc_errors.dart';
import 'package:flutter_weather_app/feature/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_city_weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required this.getCityWeather,
  }) : super(const WeatherState()) {
    on<GetCityWeatherEvent>(_onGetCityWeather);

    add(const GetCityWeatherEvent(
      latitude: 50.4500,
      longitude: 30.5233,
    ));
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
          error: const WeatherErrorLoading(message: ''),
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
