import 'dart:convert';

class EmergencyModel {
  String id;
  String title;
  String name;
  String phoneNumber;
  String gender;
  String? image;
  double lat;
  double lng;
  String status;
  String description;
  int? createdAt;
  EmergencyModel({
    required this.id,
    required this.title,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    this.image,
    required this.lat,
    required this.lng,
    this.status = 'pending',
    required this.description,
    this.createdAt,
  });

  EmergencyModel copyWith({
    String? id,
    String? title,
    String? name,
    String? phoneNumber,
    String? gender,
    String? image,
    double? lat,
    double? lng,
    String? status,
    String? description,
    int? createdAt,
  }) {
    return EmergencyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'name': name});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender});
    if (image != null) {
      result.addAll({'image': image});
    }
    result.addAll({'lat': lat});
    result.addAll({'lng': lng});
    result.addAll({'status': status});
    result.addAll({'description': description});
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }

    return result;
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'],
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyModel.fromJson(String source) =>
      EmergencyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmergencyModel(id: $id, title: $title, name: $name, phoneNumber: $phoneNumber, gender: $gender, image: $image, lat: $lat, lng: $lng, status: $status, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmergencyModel &&
        other.id == id &&
        other.title == title &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.gender == gender &&
        other.image == image &&
        other.lat == lat &&
        other.lng == lng &&
        other.status == status &&
        other.description == description &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        gender.hashCode ^
        image.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        status.hashCode ^
        description.hashCode ^
        createdAt.hashCode;
  }

  static EmergencyModel defualt() {
    return EmergencyModel(
      id: '',
      title: '',
      name: '',
      phoneNumber: '',
      gender: '',
      lat: 0.0,
      lng: 0.0,
      description: '',
    );
  }
}
