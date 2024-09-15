part of 'weather_bloc.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChangeEvent extends ThemeEvent {
  final ThemeData theme;
  const ThemeChangeEvent({required this.theme});
  @override
  List<Object> get props => [theme];
}
