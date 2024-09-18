part of 'window_bloc.dart';

enum WindowStatus { none, success, error }

class WindowState extends Equatable {
  final List<WindowData> openWindows;
  final List<WindowData> minimizedWindows;
  final WindowStatus status;

  const WindowState({
    required this.openWindows,
    this.minimizedWindows = const [],
    this.status = WindowStatus.none,
  });

  WindowState copyWith({
    List<WindowData>? openWindows,
    List<WindowData>? minimizedWindows,
    WindowStatus? status,
  }) {
    return WindowState(
      openWindows: openWindows ?? this.openWindows,
      minimizedWindows: minimizedWindows ?? this.minimizedWindows,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [openWindows, minimizedWindows, status];
}

class WindowData extends Equatable {
  final String url;
  final String id;
  final bool isMinimized;
  final DsIconData icon;
  final String name;

  const WindowData({
    required this.url,
    required this.id,
    this.isMinimized = false,
    required this.icon,
    required this.name,
  });

  WindowData copyWith({
    String? url,
    String? id,
    bool? isMinimized,
    DsIconData? icon,
    String? name,
  }) {
    return WindowData(
      url: url ?? this.url,
      id: id ?? this.id,
      isMinimized: isMinimized ?? this.isMinimized,
      icon: icon ?? this.icon,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [url, id, isMinimized, icon, name];
}
