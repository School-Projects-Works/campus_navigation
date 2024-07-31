import 'dart:convert';

import 'package:campus_navigation/features/home/services/places_services.dart';
import 'package:flutter/widgets.dart';

class PlaceItem {
  String id;
  String name;
  double lat;
  double lng;
  String image;
  String? description;
  bool published;
  PlaceItem({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.image,
    this.description,
    required this.published,
  });

  PlaceItem copyWith({
    String? id,
    String? name,
    double? lat,
    double? lng,
    String? image,
    ValueGetter<String?>? description,
    bool? published,
  }) {
    return PlaceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      image: image ?? this.image,
      description: description != null ? description() : this.description,
      published: published ?? this.published,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'image': image,
      'description': description,
      'published': published,
    };
  }

  factory PlaceItem.fromMap(Map<String, dynamic> map) {
    return PlaceItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      description: map['description'],
      published: map['published'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceItem.fromJson(String source) =>
      PlaceItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceItem(id: $id, name: $name, lat: $lat, lng: $lng, image: $image, description: $description, published: $published)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaceItem &&
        other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.lng == lng &&
        other.image == image &&
        other.description == description &&
        other.published == published;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        image.hashCode ^
        description.hashCode ^
        published.hashCode;
  }

  static List<PlaceItem> dummyData() {
    List<PlaceItem> list = [];
    return [
      PlaceItem(
          id: PlacesServices.getPlaceId(),
          name: 'Main Building',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsqROZ4fBcP4pK8TEjDOXsZ34ngSjP7jSH0A&s',
          lat: 6.697565095577939,
          lng: -1.6815263097754813,
          description: 'Main Building',
          published: true),
      PlaceItem(
          id: PlacesServices.getPlaceId(),
          name: 'Library',
          image:
              'https://onuaonline.com/wp-content/uploads/2021/08/AAMUSTED-library.jpg',
          lat: 6.698227172213884,
          lng: -1.6818030880659585,
          description: 'Library',
          published: true),
    ];
  }
}
