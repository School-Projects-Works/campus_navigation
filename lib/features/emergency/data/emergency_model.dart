import 'dart:convert';
import 'package:flutter/widgets.dart';

class EmergencyModel {
  String indexNumber;
  String name;
  String phoneNumber;
  String gender;
  String image;
  double lat;
  double lng;
  String description;
  int? createdAt;
  EmergencyModel({
    required this.indexNumber,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.image,
    required this.lat,
    required this.lng,
    required this.description,
    this.createdAt,
  });

  EmergencyModel copyWith({
    String? indexNumber,
    String? name,
    String? phoneNumber,
    String? gender,
    String? image,
    double? lat,
    double? lng,
    String? description,
    ValueGetter<int?>? createdAt,
  }) {
    return EmergencyModel(
      indexNumber: indexNumber ?? this.indexNumber,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      description: description ?? this.description,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'indexNumber': indexNumber,
      'name': name,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'image': image,
      'lat': lat,
      'lng': lng,
      'description': description,
      'createdAt': createdAt,
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      indexNumber: map['indexNumber'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyModel.fromJson(String source) => EmergencyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmergencyModel(indexNumber: $indexNumber, name: $name, phoneNumber: $phoneNumber, gender: $gender, image: $image, lat: $lat, lng: $lng, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EmergencyModel &&
      other.indexNumber == indexNumber &&
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.gender == gender &&
      other.image == image &&
      other.lat == lat &&
      other.lng == lng &&
      other.description == description &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return indexNumber.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      description.hashCode ^
      createdAt.hashCode;
  }
}
