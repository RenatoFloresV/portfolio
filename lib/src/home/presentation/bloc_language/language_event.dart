part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageChangeEvent extends LanguageEvent {
  final String language;

  const LanguageChangeEvent(this.language);

  @override
  List<Object> get props => [language];
}

class LoadLanguageEvent extends LanguageEvent {}
