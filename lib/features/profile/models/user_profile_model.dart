class UserProfileModel {
  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final String? drivingLicenseNumber;
  final int? drivingExperienceYears;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.drivingLicenseNumber,
    this.drivingExperienceYears,
  });

  UserProfileModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? drivingLicenseNumber,
    int? drivingExperienceYears,
  }) {
    return UserProfileModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      drivingLicenseNumber: drivingLicenseNumber ?? this.drivingLicenseNumber,
      drivingExperienceYears: drivingExperienceYears ?? this.drivingExperienceYears,
    );
  }
}

