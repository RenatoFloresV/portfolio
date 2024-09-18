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
  List<Object> get props => [
        openWindows,
        minimizedWindows,
        status,
      ];
}

class WindowData extends Equatable {
  final String id;
  final String url;
  final DsIconData icon;
  final String name;
  final bool isMinimized;
  final bool isMaximized;
  final double zIndex;
  final Offset position;
  final Size size;
  final WebViewController? controller; // Agregado

  const WindowData({
    required this.id,
    required this.url,
    required this.icon,
    required this.name,
    required this.isMinimized,
    required this.isMaximized,
    required this.zIndex,
    required this.position,
    required this.size,
    this.controller, // Agregado
  });

  WindowData copyWith({
    String? id,
    String? url,
    DsIconData? icon,
    String? name,
    bool? isMinimized,
    bool? isMaximized,
    double? zIndex,
    Offset? position,
    Size? size,
    WebViewController? controller, // Agregado
  }) {
    return WindowData(
      id: id ?? this.id,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      isMinimized: isMinimized ?? this.isMinimized,
      isMaximized: isMaximized ?? this.isMaximized,
      zIndex: zIndex ?? this.zIndex,
      position: position ?? this.position,
      size: size ?? this.size,
      controller: controller ?? this.controller, // Agregado
    );
  }

  @override
  List<Object?> get props => [
        id,
        url,
        icon,
        name,
        isMinimized,
        isMaximized,
        zIndex,
        position,
        size,
        controller
      ];
}
