import 'package:egypt_tourist_guide/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDarkMode = false;
  String theme = 'light';

  ThemeBloc() : super(ThemeInitial(ThemeMode.light)) {
    on<InitEvent>(_init);
    // when app starts get theme_bloc from shared prefs
    on<ToggleThemeEvent>(_toggleTheme);
  }

  void _init(InitEvent event, Emitter<ThemeState> emit) async {
    theme = await SharedPrefsService.getStringData(key: "theme") ?? 'light';
    emit(ThemeInitial(theme == 'light' ? ThemeMode.light : ThemeMode.dark));
  }

  void _toggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    isDarkMode = !isDarkMode;
    ThemeMode themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    theme = isDarkMode ? 'dark' : 'light';
    await SharedPrefsService.saveStringData(key: "theme", value: theme);
    emit(ThemeChanged(themeMode));
  }
}
