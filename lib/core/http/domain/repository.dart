import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/http/domain/entities/failure_http.dart';

import 'entities/payload.dart';

/// An abstract class representing an HTTP repository.
///
/// This class defines methods for making various HTTP requests using the Either type from fpdart.
/// The Either type allows us to represent successful responses (wrapped in Right) and potential errors (wrapped in Left).
abstract class PortfolioHttp {
  /// Performs a GET request to the specified URL.
  ///
  /// This method returns a Future<Either<HttpError, HttpResponse>>.
  /// On success, the right side of the Either will contain an HttpResponse object with the response data.
  /// On error, the left side of the Either will contain an HttpError object with details about the error.

  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  /// Performs a POST request to the specified URL.
  ///
  /// This method takes the URL, optional query parameters, and an optional body as arguments.
  /// It returns a Future<Either<HttpError, PortfolioResponse>>`, similar to the get method.
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
  });

  /// Performs a PUT request to the specified URL.
  ///
  /// This method has the same structure as the post method, allowing for PUT requests with optional query parameters and a body.
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    body,
  });

  /// Performs a PATCH request to the specified URL.
  ///
  /// This method is similar to post and put, allowing for PATCH requests with optional parameters.
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> patch<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    body,
  });

  /// Performs a DELETE request to the specified URL.
  ///
  /// This method takes the URL as an argument and returns a Future<Either<HttpError, PortfolioResponse>>.
  Future<Either<PortfolioResponseError, PortfolioResponse<T>>> delete<T>(
      String url);
}
