import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import '../../repositories/settings_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc(this.settingsRepository) : super(SettingsInitial()) {
    
    // При старте грузим сохраненные настройки
    on<LoadSettings>((event, emit) async {
      final notifications = await settingsRepository.getNotifications();
      final sound = await settingsRepository.getSound();
      final isDark = await settingsRepository.getDarkTheme();
      emit(SettingsUpdated(notifications, sound, isDark));
    });

    on<ToggleNotifications>((event, emit) async {
      final currentState = state is SettingsUpdated
          ? state as SettingsUpdated
          : const SettingsUpdated(true, true, false);

      final newValue = !currentState.notificationsEnabled;
      await settingsRepository.saveNotifications(newValue);
      emit(SettingsUpdated(newValue, currentState.soundEnabled, currentState.isDarkTheme));
    });

    on<ToggleSound>((event, emit) async {
      final currentState = state is SettingsUpdated
          ? state as SettingsUpdated
          : const SettingsUpdated(true, true, false);

      final newValue = !currentState.soundEnabled;
      await settingsRepository.saveSound(newValue);
      emit(SettingsUpdated(currentState.notificationsEnabled, newValue, currentState.isDarkTheme));
    });

    // Обработка темы
    on<ToggleTheme>((event, emit) async {
      final currentState = state is SettingsUpdated
          ? state as SettingsUpdated
          : const SettingsUpdated(true, true, false);

      final newValue = !currentState.isDarkTheme;
      await settingsRepository.saveDarkTheme(newValue);
      emit(SettingsUpdated(currentState.notificationsEnabled, currentState.soundEnabled, newValue));
    });
  }
}