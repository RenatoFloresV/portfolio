class WeatherData {
  final Location? location;
  final CurrentWeather? current;

  WeatherData({this.location, this.current});

  factory WeatherData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return WeatherData();
    }
    return WeatherData(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
    );
  }
}

class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? localtimeEpoch;
  final String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.timezone,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Location();
    }
    return Location(
      name: json['name'] as String?,
      region: json['region'] as String?,
      country: json['country'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      timezone: json['tz_id'] as String?,
      localtimeEpoch: json['localtime_epoch'] as int?,
      localtime: json['localtime'] as String?,
    );
  }
}

class CurrentWeather {
  final String? lastUpdated;
  final double? tempC;
  final double? tempF;
  final bool? isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final int? windDegree;
  final String? windDir;
  final double? pressureMb;
  final double? pressureIn;
  final double? precipMm;
  final double? precipIn;
  final int? humidity;
  final int? cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final double? dewpointC;
  final double? dewpointF;
  final double? visibilityKm;
  final double? visibilityMiles;
  final double? uv;
  final double? gustMph;
  final double? gustKph;

  CurrentWeather({
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.dewpointC,
    this.dewpointF,
    this.visibilityKm,
    this.visibilityMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CurrentWeather();
    }
    return CurrentWeather(
      lastUpdated: json['last_updated'] as String?,
      tempC: (json['temp_c'] as num?)?.toDouble(),
      tempF: (json['temp_f'] as num?)?.toDouble(),
      isDay: json['is_day'] == 1,
      condition: Condition.fromJson(json['condition']),
      windMph: (json['wind_mph'] as num?)?.toDouble(),
      windKph: (json['wind_kph'] as num?)?.toDouble(),
      windDegree: json['wind_degree'] as int?,
      windDir: json['wind_dir'] as String?,
      pressureMb: (json['pressure_mb'] as num?)?.toDouble(),
      pressureIn: (json['pressure_in'] as num?)?.toDouble(),
      precipMm: (json['precip_mm'] as num?)?.toDouble(),
      precipIn: (json['precip_in'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
      cloud: json['cloud'] as int?,
      feelslikeC: (json['feelslike_c'] as num?)?.toDouble(),
      feelslikeF: (json['feelslike_f'] as num?)?.toDouble(),
      dewpointC: (json['dewpoint_c'] as num?)?.toDouble(),
      dewpointF: (json['dewpoint_f'] as num?)?.toDouble(),
      visibilityKm: (json['vis_km'] as num?)?.toDouble(),
      visibilityMiles: (json['vis_miles'] as num?)?.toDouble(),
      uv: (json['uv'] as num?)?.toDouble(),
      gustMph: (json['gust_mph'] as num?)?.toDouble(),
      gustKph: (json['gust_kph'] as num?)?.toDouble(),
    );
  }
}

class Condition {
  final String? text;
  final String? icon;
  final int? code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Condition();
    }
    return Condition(
      text: json['text'] as String?,
      icon: json['icon'] as String?,
      code: json['code'] as int?,
    );
  }
}
