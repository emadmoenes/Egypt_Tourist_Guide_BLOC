part of 'theme_bloc.dart';

abstract class ThemeState {
  final String? theme;
  const ThemeState({this.theme});
}

class ThemeInitial extends ThemeState {
  const ThemeInitial({String? theme}) : super(theme: theme ?? 'light');
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(String theme) : super(theme: theme);
}
