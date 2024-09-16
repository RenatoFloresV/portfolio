part of 'weather_bloc.dart';

enum WeatherStatus {
  none,
  initial,
  showLoading,
  hideLoading,
  success,
  error,
}

class WeatherState extends Equatable {
  const WeatherState(
      {required this.weatherData,
      required this.status,
      required this.position});

  final WeatherData weatherData;
  final WeatherStatus status;
  final Position? position;

  WeatherState copyWith({
    WeatherData? weatherData,
    WeatherStatus? status,
    Position? position,
  }) {
    return WeatherState(
      weatherData: weatherData ?? this.weatherData,
      status: status ?? WeatherStatus.none,
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [weatherData, status];
}
