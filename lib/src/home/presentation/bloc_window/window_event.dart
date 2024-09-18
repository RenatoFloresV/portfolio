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
