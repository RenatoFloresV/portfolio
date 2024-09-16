part of 'language_bloc.dart';

enum LanguageStatus { none, loading, success, error }

class LanguageState extends Equatable {
  final String language;
  final LanguageStatus status;

  const LanguageState({required this.language, required this.status});

  LanguageState copyWith({String? language, LanguageStatus? status}) {
    return LanguageState(
      language: language ?? this.language,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [language, status];
}
