import 'package:equatable/equatable.dart';

/// Represents a city entity with various properties such as name, coordinates, country, etc.
class CityEntity extends Equatable {
  /// Constructs a [CityEntity] instance with the provided parameters.
  const CityEntity({
    required this.city,
    required this.lat,
    required this.lng,
    required this.country,
    required this.id,
  });

  /// The name of the city.
  final String city;

  /// The latitude coordinate of the city.
  final double lat;

  /// The longitude coordinate of the city.
  final double lng;

  /// The country where the city is located.
  final String country;

  /// The unique identifier of the city.
  final int id;

  @override
  List<Object> get props => [
        city,
        lat,
        lng,
        country,
        id,
      ];

  /// Constructs a [CityEntity] instance from a JSON object.
  factory CityEntity.fromJson(Map<String, dynamic> json) {
    return CityEntity(
      city: json['city'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      country: json['country'],
      id: int.parse(json['id']),
    );
  }

  /// Converts the [CityEntity] instance to a JSON object.
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
