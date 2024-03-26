import 'package:equatable/equatable.dart';

/// Represents a city entity with various properties such as name, coordinates, country, etc.
class CityEntity extends Equatable {
  /// Constructs a [CityEntity] instance with the provided parameters.
  const CityEntity({
    required this.city,
    required this.cityAscii,
    required this.lat,
    required this.lng,
    required this.country,
    required this.iso2,
    required this.iso3,
    required this.adminName,
    required this.capital,
    required this.population,
    required this.id,
  });

  /// The name of the city.
  final String city;

  /// The ASCII name of the city.
  final String cityAscii;

  /// The latitude coordinate of the city.
  final double lat;

  /// The longitude coordinate of the city.
  final double lng;

  /// The country where the city is located.
  final String country;

  /// The ISO2 code of the country.
  final String iso2;

  /// The ISO3 code of the country.
  final String iso3;

  /// The administrative name of the city.
  final String adminName;

  /// The capital status of the city.
  final String capital;

  /// The population of the city.
  final int population;

  /// The unique identifier of the city.
  final int id;

  @override
  List<Object> get props => [
        city,
        cityAscii,
        lat,
        lng,
        country,
        iso2,
        iso3,
        adminName,
        capital,
        population,
        id,
      ];

  /// Constructs a [CityEntity] instance from a JSON object.
  factory CityEntity.fromJson(Map<String, dynamic> json) {
    return CityEntity(
      city: json['city'],
      cityAscii: json['city_ascii'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      country: json['country'],
      iso2: json['iso2'],
      iso3: json['iso3'],
      adminName: json['admin_name'],
      capital: json['capital'],
      population: int.parse(json['population']),
      id: int.parse(json['id']),
    );
  }

  /// Converts the [CityEntity] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'city_ascii': cityAscii,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'country': country,
      'iso2': iso2,
      'iso3': iso3,
      'admin_name': adminName,
      'capital': capital,
      'population': population.toString(),
      'id': id.toString(),
    };
  }
}
