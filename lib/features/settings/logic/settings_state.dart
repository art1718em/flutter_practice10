import 'package:equatable/equatable.dart';
import 'package:flutter_practice10/features/settings/models/app_settings_model.dart';

class SettingsState extends Equatable {
  final AppSettingsModel settings;

  const SettingsState({
    this.settings = const AppSettingsModel(),
  });

  SettingsState copyWith({
    AppSettingsModel? settings,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object> get props => [settings];
}

