import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/errors/bloc_errors.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_all_city.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_last_city.dart';
import 'package:flutter_weather_app/feature/domain/usecases/save_city.dart';
import 'package:flutter_weather_app/feature/domain/usecases/search_cities.dart';

part 'city_event.dart';

part 'city_state.dart';

/// Represents the BLoC responsible for managing cities-related data.
class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc({
    required this.getAllCity,
    required this.searchCities,
    required this.saveCity,
    required this.getLastCity,
  }) : super(const CityState()) {
    on<GetAllCityEvent>(_onLoadCities);
    on<SearchCityEvent>(_onSearchCities);
    on<SelectCityEvent>(_onSelectCity);
    on<LoadLastCityEvent>(_onLoadLastCity);
    on<ClearSearchResultEvent>(_onClearSearchResult);
  }

  final GetAllCity getAllCity;
  final SearchCities searchCities;
  final SaveCity saveCity;
  final GetLastCity getLastCity;

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

  Future<void> _onSelectCity(
    SelectCityEvent event,
    Emitter<CityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final failureOrSave =
        await saveCity(SaveCityParams(city: event.selectedCity));
    failureOrSave.fold(
      (error) {
        if (error.runtimeType == ConnectionFailure) {
          return emit(state.copyWith(
            error: CityErrorLoading(message: _mapFailureToMessage(error)),
          ));
        }
        emit(state.copyWith(isLoading: false));
      },
      (isSuccess) {
        emit(state.copyWith(selectedCity: event.selectedCity));
      },
    );
  }

  Future<void> _onSearchCities(
    SearchCityEvent event,
    Emitter<CityState> emit,
  ) async {
    add(const GetAllCityEvent());
    emit(state.copyWith(
      isLoading: true,
      isSearching: true,
    ));
    if (event.query.isEmpty) {
      emit(state.copyWith(isSearching: false));
      return;
    }
    final failureOrCities =
        await searchCities(SearchCitiesParams(searchQuery: event.query));
    failureOrCities.fold(
      (failure) {
        emit(state.copyWith(
          error: CityErrorLoading(message: _mapFailureToMessage(failure)),
        ));
      },
      (cities) {
        emit(state.copyWith(searchedCities: cities));
      },
    );
  }

  Future<void> _onLoadLastCity(
    LoadLastCityEvent event,
    Emitter<CityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final failureOrCity = await getLastCity();
    failureOrCity.fold(
      (error) {
        emit(state.copyWith(
          error: CityErrorLoading(message: _mapFailureToMessage(error)),
        ));
      },
      (city) {
        emit(state.copyWith(
          selectedCity: city,
          isLoading: false,
        ));
      },
    );
  }

  void _onClearSearchResult(
    ClearSearchResultEvent event,
    Emitter<CityState> emit,
  ) {
    emit(state.copyWith(searchedCities: []));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Failed load cities from server';
      case CacheFailure:
        return 'Failed load cities from cache';
      case ConnectionFailure:
        return 'Failed need internet connection';
      default:
        return 'Unexpected Failure';
    }
  }
}
