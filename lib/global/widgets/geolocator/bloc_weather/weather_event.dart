part of 'weather_bloc.dart';

class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadWeatherEvent extends WeatherEvent {
  final String lat;
  final String lon;
  const LoadWeatherEvent({required this.lat, required this.lon});
  @override
  List<Object> get props => [lat, lon];
}

class GetCurrentLocationEvent extends WeatherEvent {
  const GetCurrentLocationEvent();
  @override
  List<Object> get props => [];
}
