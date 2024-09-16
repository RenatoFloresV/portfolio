import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/http/http.dart';
import 'package:portfolio/global/widgets/geolocator/domain/domain.dart';

abstract class WeatherRepository {
  Future<Either<PortfolioResponseError, WeatherData>> getWeather({
    required String lat,
    required String lon,
  });
}
