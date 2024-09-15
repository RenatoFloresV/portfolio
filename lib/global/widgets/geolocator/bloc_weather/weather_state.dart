part of 'weather_bloc.dart';

enum ThemeStatus {
  none,
  initial,
  success,
  error,
}

class ThemeState extends Equatable {
  const ThemeState({required this.themeMode, required this.status});

  final ThemeData themeMode;
  final ThemeStatus status;

  ThemeState copyWith({
    ThemeData? themeMode,
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
