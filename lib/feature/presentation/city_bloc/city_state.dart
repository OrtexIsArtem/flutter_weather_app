part of 'city_bloc.dart';

class CityErrorLoading extends BlocError {
  const CityErrorLoading({
    required super.message,
  });
}

/// Represents the states of the CityBloc.
class CityState extends Equatable {
  const CityState({
    this.isLoading = false,
    this.isSearching = false,
    this.error,
    this.cities = const [],
    this.searchedCities = const [],
  });

  /// Indicates whether the cities are currently being loaded.
  final bool isLoading;

  /// Indicates whether the user is looking for cities in search
  final bool isSearching;

  /// The error message in case of a cities loading failure.
  final CityErrorLoading? error;

  /// The list of all cities.
  final List<CityEntity> cities;

  /// The list of cities that match the search criteria. Empty before search
  final List<CityEntity> searchedCities;

  CityState copyWith({
    bool? isLoading,
    bool? isSearching,
    CityErrorLoading? error,
    List<CityEntity>? cities,
    List<CityEntity>? searchedCities,
  }) {
    return CityState(
      isLoading: isLoading ?? false,
      isSearching: isSearching ?? this.isSearching,
      error: error,
      cities: cities ?? this.cities,
      searchedCities: searchedCities ?? this.searchedCities,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSearching,
        cities,
        searchedCities,
      ];
}
