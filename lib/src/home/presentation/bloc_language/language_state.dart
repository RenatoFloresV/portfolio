part of 'language_bloc.dart';

enum LanguageStatus {
  none,
  initial,
  success,
  error,
}

class LanguageState extends Equatable {
  const LanguageState({required this.language, required this.status});

  final String language;
  final LanguageStatus status;

  LanguageState copyWith({
    String? language,
    LanguageStatus? status,
  }) {
    return LanguageState(
      language: language ?? this.language,
      status: status ?? LanguageStatus.none,
    );
  }

  @override
  List<Object> get props => [language];
}
