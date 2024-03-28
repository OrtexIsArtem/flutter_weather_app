import 'package:flutter_weather_app/feature/domain/entities/city_entity.dart';

/// Represents a model of a city, extending the [CityEntity] class.
class CityModel extends CityEntity {
  const CityModel({
    required super.city,
    required super.lat,
    required super.lng,
    required super.country,
    required super.id,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      city: json['city'],
      lat: double.tryParse(json['lat'] as String) ?? 0,
      lng: double.tryParse(json['lng'] as String) ?? 0,
      country: json['country'],
      id: int.tryParse(json['id'] as String) ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'country': country,
      'id': id.toString(),
    };
  }
}
