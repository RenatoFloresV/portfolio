import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import 'package:portfolio/global/widgets/geolocator/domain/domain.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.weatherRepository)
      : super(WeatherState(
          weatherData: WeatherData.fromJson({}),
          status: WeatherStatus.none,
          position: null,
        )) {
    on<LoadWeatherEvent>(_onLoadWeatherEvent);
    on<GetCurrentLocationEvent>(_onGetCurrentLocationEvent);
  }
  final WeatherRepository weatherRepository;

  FutureOr<void> _onLoadWeatherEvent(
      LoadWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.showLoading));

    final res = await weatherRepository.getWeather(
      lat: event.lat,
      lon: event.lon,
    );

    emit(state.copyWith(status: WeatherStatus.hideLoading));

    res.fold(
      (l) {
        emit(state.copyWith(status: WeatherStatus.error));
      },
      (r) {
        emit(state.copyWith(
          weatherData: r,
          status: WeatherStatus.success,
        ));
      },
    );
  }

  FutureOr<void> _onGetCurrentLocationEvent(
      GetCurrentLocationEvent event, Emitter<WeatherState> emit) async {
    // Emitimos el estado de carga mientras obtenemos la ubicación
    emit(state.copyWith(status: WeatherStatus.showLoading));

    // Comprobamos los permisos de ubicación
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(state.copyWith(status: WeatherStatus.error));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(status: WeatherStatus.error));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(state.copyWith(status: WeatherStatus.error));
      return;
    }

    // Obtenemos la ubicación actual
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    emit(state.copyWith(position: position, status: WeatherStatus.hideLoading));

    // Después de obtener la posición, disparamos el evento para cargar el clima
    add(LoadWeatherEvent(
      lat: position.latitude.toString(),
      lon: position.longitude.toString(),
    ));
  }
}
