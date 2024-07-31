import 'dart:convert';

class ContactModel {
  final String name;
  final String phoneNumber;
  final String email;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  ContactModel copyWith({
    String? name,
    String? phoneNumber,
    String? email,
  }) {
    return ContactModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ContactModel(name: $name, phoneNumber: $phoneNumber, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactModel &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ phoneNumber.hashCode ^ email.hashCode;

  static List<ContactModel> dummyContacts() {
    return [
      ContactModel(email: 'clinic@aamusted.com',name: 'AAMUSTED Clinic',phoneNumber: '+233234567890'),
      ContactModel(email: 'security@aamusted.com',name: 'AAMUSTED Security',phoneNumber: '+233234567890'),
      ContactModel(email: 'residence@aamusted.com',name: 'AAMUSTED Residencey',phoneNumber: '+233234567890'),
      ContactModel(email: 'administration@aamusted.com',name: 'AAMUSTED Administration',phoneNumber: '+233234567890'),
    ];
  }
}
