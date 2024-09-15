import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Verifica si los servicios de ubicación están habilitados
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Los servicios de ubicación están deshabilitados.');
  }

  // Verifica el permiso de ubicación
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('El permiso de ubicación fue denegado.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'El permiso de ubicación está denegado permanentemente.');
  }

  // Obtén la ubicación actual
  return await Geolocator.getCurrentPosition();
}
