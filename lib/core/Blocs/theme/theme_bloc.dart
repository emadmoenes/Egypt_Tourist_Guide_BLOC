import 'package:egypt_tourist_guide/services/shared_prefs_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  String theme;
  ThemeBloc(this.theme) : super(ThemeInitial()) {
    on<InitEvent>(_init); // when app starts get theme from shared prefs
    on<ToggleThemeEvent>(_toggleTheme);
  }

  void _init(InitEvent event, Emitter<ThemeState> emit) async {
    theme = await SharedPrefsService.getTheme() ?? 'light';
    emit(ThemeInitial(theme: theme));
  }

  void _toggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    theme = event.theme;
    await SharedPrefsService.saveTheme(theme);
    emit(ThemeChanged(theme));
  }
}
