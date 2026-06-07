import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {} // Событие начальной загрузки

class ToggleNotifications extends SettingsEvent {}

class ToggleSound extends SettingsEvent {}

class ToggleTheme extends SettingsEvent {} // Событие переключения темы