part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class AppThemeState extends ThemeState {
  final bool isDark;

  AppThemeState(this.isDark);
}
