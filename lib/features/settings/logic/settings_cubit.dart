import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/settings/models/app_settings_model.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setThemeMode(AppThemeMode mode) {
    final updatedSettings = state.settings.copyWith(themeMode: mode);
    emit(state.copyWith(settings: updatedSettings));
  }

  void setCurrency(Currency currency) {
    final updatedSettings = state.settings.copyWith(currency: currency);
    emit(state.copyWith(settings: updatedSettings));
  }

  void setDistanceUnit(DistanceUnit unit) {
    final updatedSettings = state.settings.copyWith(distanceUnit: unit);
    emit(state.copyWith(settings: updatedSettings));
  }

  void toggleNotifications(bool enabled) {
    final updatedSettings = state.settings.copyWith(notificationsEnabled: enabled);
    emit(state.copyWith(settings: updatedSettings));
  }

  void toggleAutoBackup(bool enabled) {
    final updatedSettings = state.settings.copyWith(autoBackup: enabled);
    emit(state.copyWith(settings: updatedSettings));
  }

  void resetSettings() {
    emit(const SettingsState());
  }
}

