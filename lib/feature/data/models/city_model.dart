import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';

/// Represents a model of a city, extending the [CityEntity] class.
class CityModel extends CityEntity {
  const CityModel({
    required super.city,
    required super.cityAscii,
    required super.lat,
    required super.lng,
    required super.country,
    required super.iso2,
    required super.iso3,
    required super.adminName,
    required super.capital,
    required super.population,
    required super.id,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      city: json['city'],
      cityAscii: json['city_ascii'],
      lat: double.tryParse(json['lat'] as String) ?? 0,
      lng: double.tryParse(json['lng'] as String) ?? 0,
      country: json['country'],
      iso2: json['iso2'],
      iso3: json['iso3'],
      adminName: json['admin_name'],
      capital: json['capital'],
      population: int.tryParse(json['population'] as String) ?? 0,
      id: int.tryParse(json['id'] as String) ?? 0,
    );
  }

  @override
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
