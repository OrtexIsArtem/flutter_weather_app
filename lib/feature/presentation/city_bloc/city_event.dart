part of 'city_bloc.dart';

/// Represents the events that can be dispatched to the CityBloc.
@immutable
abstract class CityEvent extends Equatable {
  const CityEvent();
}

/// Represents the event to get all cities.
class GetAllCityEvent extends CityEvent {
  const GetAllCityEvent();

  @override
  List<Object?> get props => [];
}

/// Represents the event to search cities by [query].
class SearchCityEvent extends CityEvent {
  const SearchCityEvent({
    required this.query,
  });

  final String query;

  @override
  List<Object?> get props => [query];
}
