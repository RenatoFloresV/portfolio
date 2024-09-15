import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/http/domain/entities/failure_http.dart';
import 'package:portfolio/core/http/http.dart';
import 'package:portfolio/global/widgets/geolocator/domain/domain.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl(
    this.http,
  );

  final PortfolioHttp http;

  @override
  Future<Either<PortfolioResponseError, bool>> getWeather({
    required String lat,
    required String lon,
  }) async {
    const String apiKey = 'b3f9d3d3e5b0d7b7b0d7b7b0d7b7b7b0';
    final res = await http.put(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey');

    return res.match(
      (l) {
        return Either.left(l);
      },
      (r) {
        return Either.of(
          r.payload['passwordChanged'] ?? false,
        );
      },
    );
  }
}
