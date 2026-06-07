import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/settings/settings_event.dart';
import '../blocs/settings/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          // Значения по умолчанию
          bool notifications = true;
          bool sound = true;
          bool isDark = false;

          // Подхватываем актуальные значения из BLoC
          if (state is SettingsUpdated) {
            notifications = state.notificationsEnabled;
            sound = state.soundEnabled;
            isDark = state.isDarkTheme;
          }

          return Column(
            children: [
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text("Темная тема"),
                secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                value: isDark,
                onChanged: (_) {
                  context.read<SettingsBloc>().add(ToggleTheme());
                },
              ),
              SwitchListTile(
                title: const Text("Уведомления"),
                secondary: const Icon(Icons.notifications),
                value: notifications,
                onChanged: (_) {
                  context.read<SettingsBloc>().add(ToggleNotifications());
                },
              ),
              SwitchListTile(
                title: const Text("Звук"),
                secondary: const Icon(Icons.volume_up),
                value: sound,
                onChanged: (_) {
                  context.read<SettingsBloc>().add(ToggleSound());
                },
              ),
              const Spacer(), // Отталкивает кнопку вниз
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text("Выйти из профиля"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.redAccent, // Красная кнопка выхода
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}