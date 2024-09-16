import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/http/http.dart';
import 'package:portfolio/global/widgets/geolocator/domain/domain.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl(
    this.http,
  );

  final PortfolioHttp http;

  @override
  Future<Either<PortfolioResponseError, WeatherData>> getWeather({
    required String lat,
    required String lon,
  }) async {
    const String apiKey = String.fromEnvironment('API_KEY');

    final res = await http.get(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$lat,$lon&aqi=no');

    return res.match(
      (l) {
        return Either.left(l);
      },
      (r) {
        final weatherData = WeatherData.fromJson(r.payload);
        return Either.of(weatherData);
      },
    );
  }
}
