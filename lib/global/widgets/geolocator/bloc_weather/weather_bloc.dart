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
    print('Cargando clima para lat: ${event.lat}, lon: ${event.lon}');

    try {
      final res = await weatherRepository.getWeather(
        lat: event.lat,
        lon: event.lon,
      );

      emit(state.copyWith(status: WeatherStatus.hideLoading));

      res.fold(
        (l) {
          emit(state.copyWith(status: WeatherStatus.error));
          print('Error al obtener el clima: $l');
        },
        (r) {
          emit(state.copyWith(
            weatherData: r,
            status: WeatherStatus.success,
          ));
          print('Clima obtenido: $r');
        },
      );
    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.error));
      print('Error al cargar el clima: $e');
    }
  }

  FutureOr<void> _onGetCurrentLocationEvent(
      GetCurrentLocationEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.showLoading));
    print('Recibiendo evento de obtener ubicación');

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(status: WeatherStatus.error));
        print('Servicios de ubicación deshabilitados');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(status: WeatherStatus.error));
          print('Permiso de ubicación denegado');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(status: WeatherStatus.error));
        print('Permiso de ubicación denegado permanentemente');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      emit(state.copyWith(
          position: position, status: WeatherStatus.hideLoading));
      print('Ubicación obtenida: $position');

      add(LoadWeatherEvent(
        lat: position.latitude.toString(),
        lon: position.longitude.toString(),
      ));
    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.error));
      print('Error al obtener ubicación: $e');
    }
  }
}
