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
  final DsIconData icon;
  final String name;
  final bool isMinimized;
  final double zIndex;
  final Offset position;

  const WindowData({
    required this.url,
    required this.id,
    required this.icon,
    required this.name,
    required this.isMinimized,
    required this.zIndex,
    required this.position,
  });

  WindowData copyWith({
    String? url,
    String? id,
    DsIconData? icon,
    String? name,
    bool? isMinimized,
    double? zIndex,
    Offset? position,
  }) {
    return WindowData(
      url: url ?? this.url,
      id: id ?? this.id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      isMinimized: isMinimized ?? this.isMinimized,
      zIndex: zIndex ?? this.zIndex,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props =>
      [url, id, icon, name, isMinimized, zIndex, position];
}
