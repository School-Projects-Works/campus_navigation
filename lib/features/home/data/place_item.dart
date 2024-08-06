import 'dart:convert';
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

static PlaceItem defualt(){
  return PlaceItem(
    id: '',
    name: '',
    lat: 0.0,
    lng: 0.0,
    image: '',
    description: '',
    published: false,
  );
}
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
}
