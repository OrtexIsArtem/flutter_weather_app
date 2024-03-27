import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';
import 'package:flutter_weather_app/core/usecases/usecases.dart';
import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';

/// Use case that retrieves a list of searched cities.
class SearchCities extends UseCase<List<CityEntity>, SearchCitiesParams> {
  /// Constructs a [SearchCities] instance with the provided [cityRepository].
  const SearchCities(this.cityRepository);

  /// The city repository used to retrieve city data.
  final CityRepository cityRepository;

  @override
  Future<Either<Failure, List<CityEntity>>> call([
    SearchCitiesParams? params,
  ]) async {
    return await cityRepository.searchCities(params?.searchQuery);
  }
}

class SearchCitiesParams extends Equatable {
  const SearchCitiesParams({
    required this.searchQuery,
  });

  final String searchQuery;

  @override
  List<Object?> get props => [searchQuery];
}
