import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/http/http.dart';

abstract class WeatherRepository {
  Future<Either<PortfolioResponseError, bool>> getWeather({
    required String lat,
    required String lon,
  });
}
