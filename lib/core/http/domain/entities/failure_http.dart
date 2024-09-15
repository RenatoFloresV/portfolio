import 'package:equatable/equatable.dart';

class PortfolioResponseError extends Equatable {
  const PortfolioResponseError({
    this.message = '',
    this.code = -1,
  });

  final String message;
  final int code;

  factory PortfolioResponseError.fromJson(Map<String, dynamic> data) {
    return PortfolioResponseError(
      code: data['code'] ?? -1,
      message: data['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message, code];
}
