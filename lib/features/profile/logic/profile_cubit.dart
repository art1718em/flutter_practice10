import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/profile/models/user_profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void loadProfile(String userId, String name, String email) {
    final profile = UserProfileModel(
      userId: userId,
      name: name,
      email: email,
      avatar: 'https://ui-avatars.com/api/?name=$name&size=200&background=random',
    );
    emit(state.copyWith(profile: profile));
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? drivingLicenseNumber,
    int? drivingExperienceYears,
  }) async {
    if (state.profile == null) return;

    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));

    final updatedProfile = state.profile!.copyWith(
      name: name,
      phone: phone,
      drivingLicenseNumber: drivingLicenseNumber,
      drivingExperienceYears: drivingExperienceYears,
    );

    emit(state.copyWith(
      profile: updatedProfile,
      isLoading: false,
      clearError: true,
    ));
  }

  void clearProfile() {
    emit(const ProfileState());
  }
}

