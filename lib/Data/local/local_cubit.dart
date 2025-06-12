import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// State for the LocaleCubit
class LocaleState {
  final Locale locale;

  LocaleState(this.locale);
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(_getInitialLocale()));

  // Determine the initial locale (e.g., from system settings or a default)
  static Locale _getInitialLocale() {
    // You might want to load this from shared_preferences or similar in a real app
    // For now, it defaults to English, or system locale if supported.
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (['en', 'ar'].contains(systemLocale.languageCode)) {
      return systemLocale;
    }
    return const Locale('en'); // Default to English
  }

  // Method to set a new locale
  void setLocale(Locale newLocale) {
    if (state.locale != newLocale && ['en', 'ar'].contains(newLocale.languageCode)) {
      emit(LocaleState(newLocale));
    }
  }

  // Method to toggle between English and Arabic
  void toggleLocale() {
    if (state.locale.languageCode == 'en') {
      emit(LocaleState(const Locale('ar')));
    } else {
      emit(LocaleState(const Locale('en')));
    }
  }
}
