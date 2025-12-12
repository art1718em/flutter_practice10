class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime registrationDate;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.registrationDate,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? registrationDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }
}

