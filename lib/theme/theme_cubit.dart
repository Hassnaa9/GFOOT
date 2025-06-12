import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ThemeState defines the state for our theme Cubit
class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeState &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode);

  @override
  int get hashCode => themeMode.hashCode;
}

class ThemeCubit extends Cubit<ThemeState> {
  // Initialize with ThemeMode.system, no loading from local storage
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));

  // Directly emit the new theme mode without saving to shared preferences
  void setThemeMode(ThemeMode newThemeMode) {
    emit(ThemeState(themeMode: newThemeMode));
  }

  void toggleTheme(bool isDark) {
    setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void setSystemTheme() {
    setThemeMode(ThemeMode.system);
  }
}