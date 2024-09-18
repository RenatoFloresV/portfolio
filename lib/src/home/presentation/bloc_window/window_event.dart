part of 'window_bloc.dart';

abstract class WindowEvent extends Equatable {
  const WindowEvent();

  @override
  List<Object> get props => [];
}

class ShowWindowEvent extends WindowEvent {
  final String url;
  final String id;
  final DsIconData? icon;
  final String name;

  const ShowWindowEvent({
    required this.url,
    required this.id,
    required this.icon,
    required this.name,
  });

  @override
  List<Object> get props => [url, id, name];
}

class CloseWindowEvent extends WindowEvent {
  final String id;

  const CloseWindowEvent(this.id);

  @override
  List<Object> get props => [id];
}

class MinimizeWindowEvent extends WindowEvent {
  final String id;

  const MinimizeWindowEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RestoreWindowEvent extends WindowEvent {
  final String id;

  const RestoreWindowEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SelectWindowEvent extends WindowEvent {
  final String id;

  const SelectWindowEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateWindowPositionEvent extends WindowEvent {
  final String id;
  final Offset newPosition;

  const UpdateWindowPositionEvent({
    required this.id,
    required this.newPosition,
  });

  @override
  List<Object> get props => [id, newPosition];
}

class UpdateWindowSizeEvent extends WindowEvent {
  final String id;
  final Size newSize;

  const UpdateWindowSizeEvent({
    required this.id,
    required this.newSize,
  });

  @override
  List<Object> get props => [id, newSize];
}

class MaximizeWindowEvent extends WindowEvent {
  final String id;
  final BuildContext context;

  const MaximizeWindowEvent({
    required this.id,
    required this.context,
  });

  @override
  List<Object> get props => [id, context];
}

class UpdateWebViewControllerEvent extends WindowEvent {
  final String id;
  final WebViewController controller;

  const UpdateWebViewControllerEvent({
    required this.id,
    required this.controller,
  });

  @override
  List<Object> get props => [id, controller];
}
