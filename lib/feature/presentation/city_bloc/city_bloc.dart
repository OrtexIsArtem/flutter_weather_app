import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/errors/bloc_errors.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_all_city.dart';

part 'city_event.dart';

part 'city_state.dart';

/// Represents the BLoC responsible for managing cities-related data.
class CityBloc extends Bloc<CityEvent, CityState> {
  final GetAllCity getAllCity;

  CityBloc({
    required this.getAllCity,
  }) : super(const CityState()) {
    on<GetAllCityEvent>(_onLoadCities);
  }

  Future<void> _onLoadCities(
    GetAllCityEvent event,
    Emitter<CityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrCities = await getAllCity();
    failureOrCities.fold(
      (failure) {
        emit(state.copyWith(
          error: CityErrorLoading(message: _mapFailureToMessage(failure)),
        ));
      },
      (cities) {
        emit(state.copyWith(cities: cities));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Failed load cities from server';
      case CacheException:
        return 'Failed load cities from cache';
      default:
        return 'Unexpected Failure';
    }
  }
}
