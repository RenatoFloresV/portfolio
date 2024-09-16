part of 'icons_bloc.dart';

abstract class IconEvent extends Equatable {
  const IconEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialStateEvent extends IconEvent {}

class UpdateIconPositionEvent extends IconEvent {
  final int index;
  final Offset newPosition;

  const UpdateIconPositionEvent({
    required this.index,
    required this.newPosition,
  });

  @override
  List<Object> get props => [index, newPosition];
}

class SaveIconStateEvent extends IconEvent {}

class ChangeLanguageEvent extends IconEvent {
  final String language;

  const ChangeLanguageEvent({required this.language});

  @override
  List<Object> get props => [language];
}
