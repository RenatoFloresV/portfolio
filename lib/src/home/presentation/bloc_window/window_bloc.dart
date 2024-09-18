import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portfolio_ds/lib.dart';

part 'window_event.dart';
part 'window_state.dart';

class WindowBloc extends Bloc<WindowEvent, WindowState> {
  WindowBloc() : super(const WindowState(openWindows: [])) {
    on<ShowWindowEvent>(_onShowWindow);
    on<CloseWindowEvent>(_onCloseWindow);
    on<MinimizeWindowEvent>(_onMinimizeWindow);
    on<RestoreWindowEvent>(_onRestoreWindow);
  }

  void _onShowWindow(ShowWindowEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);

    final existingWindow = windows.firstWhere(
      (window) => window.id == event.id,
      orElse: () => WindowData(
        url: '',
        id: '',
        icon: DsIcons.folderDark,
        name: 'Unnamed Window',
      ),
    );

    if (existingWindow.id.isEmpty) {
      windows.add(WindowData(
        url: event.url,
        id: event.id,
        icon: event.icon ?? DsIcons.folderLight,
        name: event.name,
      ));
    } else {
      windows.removeWhere((window) => window.id == event.id);
      windows.add(existingWindow.copyWith(isMinimized: false));
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onCloseWindow(CloseWindowEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);

    windows.removeWhere((window) => window.id == event.id);

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onMinimizeWindow(MinimizeWindowEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);

    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(isMinimized: true);
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onRestoreWindow(RestoreWindowEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);

    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(isMinimized: false);
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }
}
