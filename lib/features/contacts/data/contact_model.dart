import 'dart:convert';

class ContactModel {
  String id;
  String name;
  String phoneNumber;
  String email;
  ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'email': email});
  
    return result;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContactModel &&
      other.id == id &&
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode;
  }
   static List<ContactModel> dummyContacts() {
    return [
      ContactModel(
        id: '1',
          email: 'clinic@aamusted.com',
          name: 'AAMUSTED Clinic',
          phoneNumber: '+233234567890'),
      ContactModel(
        id: '2',
          email: 'security@aamusted.com',
          name: 'AAMUSTED Security',
          phoneNumber: '+233234567890'),
      ContactModel(
        id: '3',
          email: 'residence@aamusted.com',
          name: 'AAMUSTED Residencey',
          phoneNumber: '+233234567890'),
      ContactModel(
        id: '4',
          email: 'administration@aamusted.com',
          name: 'AAMUSTED Administration',
          phoneNumber: '+233234567890'),
    ];
  }

}
