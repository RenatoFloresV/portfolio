import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/http/domain/entities/failure_http.dart';
import 'package:portfolio/core/http/domain/entities/payload.dart';
import 'package:portfolio/core/http/domain/repository.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';

/// PortfolioDioHttp
class PortfolioDioHttp extends PortfolioHttp {
  PortfolioDioHttp({
    Dio? dioInstance,
    String? baseUrl,
    this.appName = 'ASAP',
    List<Interceptor> interceptors = const [],
    this.appVersion = '',
    this.countryCode = 'CR',
    this.langCode = 'es',
    this.os = '',
    this.userAgent = '',
    this.transactionId = '',
    this.deviceVersion = '',
    this.deviceUuid = '',
    this.aditionalHeaders = const {},
    this.enableLogs = true,
    this.enableSentry = true,
  }) {
    _dioInstance = (dioInstance ?? Dio())
      ..options.baseUrl =
          baseUrl ?? const String.fromEnvironment('BASE_URL_PRODUCTION')
      ..options.followRedirects = false
      ..options.connectTimeout = const Duration(seconds: 25)
      ..options.receiveTimeout = const Duration(seconds: 25);

    _addDefaultHeaders();
    if (enableLogs) {
      _addLogInterceptor();
    }
    _dioInstance.interceptors.addAll(interceptors);
  }

  late Dio _dioInstance;

  // HTTP headers
  final String appName;
  final String appVersion;
  final String countryCode;
  final String langCode;
  final String os;
  final String userAgent;
  final String deviceVersion;
  final String transactionId;
  final String deviceUuid;
  final Map<String, dynamic> aditionalHeaders;

  final bool enableLogs;
  final bool enableSentry;

  Dio get dio => _dioInstance;

  void addHeaders(Map<String, dynamic>? headers) {
    if (headers != null) {
      _dioInstance.options.headers.addAll(headers);
    }
  }

  void updateHeader(String key, String value) {
    _dioInstance.options.headers
        .update(key, (_) => value, ifAbsent: () => value);
  }

  void setAuthToken(String token) {
    if (token.isNotEmpty) {
      _dioInstance.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dioInstance.options.headers.remove('Authorization');
    }
  }

  void updateCountry(String countryCode) {
    _dioInstance.options.headers['X-Country'] = countryCode;
  }

  void removeHeader(String header) {
    _dioInstance.options.headers.remove(header);
  }

  void _addDefaultHeaders() {
    _dioInstance.options.headers = {
      Headers.contentTypeHeader: Headers.jsonContentType,
      Headers.acceptHeader: Headers.jsonContentType,
      HttpHeaders.acceptEncodingHeader: 'gzip',
      'os': os,
      'App-name': appName,
      'App-version': appVersion,
      'User-Agent': userAgent,
      'device-uuid': deviceUuid,
      'X-Country': countryCode,
      'X-Lang': langCode,
      'X-App-Version': appVersion,
      'X-Device-Version': deviceVersion,
      'X-Transaction-ID': transactionId,
      'X-Device-Uuid': deviceUuid,
      'X-Policy-Version': 1,
      ...aditionalHeaders,
    };
  }

  void _addLogInterceptor() {
    _dioInstance.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: false,
        logRequestHeaders: true,
        logResponseHeaders: false,
      ),
    );
  }

  @override
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.get<T>(url, queryParameters: queryParameters);
      return Either.of(_copyResponse<T>(res));
    } on DioException catch (e) {
      return Either.left(PortfolioResponseError(
        // // code: e.response?.statusCode ?? -1,
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> patch<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    body,
  }) async {
    try {
      final res =
          await dio.patch(url, data: body, queryParameters: queryParameters);
      return Either.of(_copyResponse<T>(res));
    } on DioException catch (e) {
      return Either.left(PortfolioResponseError(
        // code: e.response?.statusCode ?? -1,
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res =
          await dio.post<T>(url, data: body, queryParameters: queryParameters);
      return Either.of(_copyResponse<T>(res));
    } on DioException catch (e) {
      return Either.left(PortfolioResponseError(
        // code: e.response?.statusCode ?? -1,
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    body,
  }) async {
    try {
      final res =
          await dio.put(url, data: body, queryParameters: queryParameters);
      return Either.of(_copyResponse<T>(res));
    } on DioException catch (e) {
      return Either.left(PortfolioResponseError(
        // code: e.response?.statusCode ?? -1,
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> delete<T>(
      String url) async {
    try {
      final res = await dio.delete(url);
      return Either.of(_copyResponse<T>(res));
    } on DioException catch (e) {
      return Either.left(PortfolioResponseError(
        // code: e.response?.statusCode ?? -1,
        message: e.message ?? '',
      ));
    }
  }

  PortfolioResponse<T> _copyResponse<T>(Response? response) {
    try {
      return PortfolioResponse<T>.fromJson(response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
