part of 'theme_bloc.dart';

enum ThemeStatus {
  none,
  dark,
  light,
  error,
}

class ThemeState extends Equatable {
  const ThemeState({required this.themeMode, required this.status});

  final ThemeMode themeMode;
  final ThemeStatus status;

  ThemeState copyWith({
    ThemeMode? themeMode,
    ThemeStatus? status,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      status: status ?? ThemeStatus.none,
    );
  }

  @override
  List<Object> get props => [themeMode];
}
