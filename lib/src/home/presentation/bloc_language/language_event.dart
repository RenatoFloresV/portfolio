part of 'language_bloc.dart';

class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageChangeEvent extends LanguageEvent {
  final String language;
  const LanguageChangeEvent({required this.language});
  @override
  List<Object> get props => [language];
}
