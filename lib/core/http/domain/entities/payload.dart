import 'package:equatable/equatable.dart';

class PortfolioResponse<T> extends Equatable {
  const PortfolioResponse({
    required this.payload,
    this.statusCode = 200,
  });

  final T? payload;
  final int statusCode;

  factory PortfolioResponse.fromJson(T data) {
    return PortfolioResponse<T>(
      payload: data,
    );
  }

  @override
  List<Object?> get props => [payload];
}
