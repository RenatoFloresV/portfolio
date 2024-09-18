import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_ds/portfolio_ds.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'window_event.dart';
part 'window_state.dart';

class WindowBloc extends Bloc<WindowEvent, WindowState> {
  WindowBloc() : super(const WindowState(openWindows: [])) {
    on<ShowWindowEvent>(_onShowWindow);
    on<CloseWindowEvent>(_onCloseWindow);
    on<MinimizeWindowEvent>(_onMinimizeWindow);
    on<RestoreWindowEvent>(_onRestoreWindow);
    on<SelectWindowEvent>(_onSelectWindow);
    on<UpdateWindowPositionEvent>(_onUpdateWindowPosition);
    on<UpdateWindowSizeEvent>(_onUpdateWindowSize);
    on<MaximizeWindowEvent>(_onMaximizeWindow);
    on<UpdateWebViewControllerEvent>(_onUpdateWebViewController);
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
        isMinimized: false,
        isMaximized: false,
        zIndex: 0,
        position: const Offset(0, 0),
        size: const Size(600, 400),
      ),
    );

    if (existingWindow.id.isEmpty) {
      windows.add(WindowData(
        url: event.url,
        id: event.id,
        icon: event.icon ?? DsIcons.folderLight,
        name: event.name,
        isMinimized: false,
        isMaximized: false,
        zIndex: windows.isEmpty
            ? 1
            : windows.map((w) => w.zIndex).reduce((a, b) => a > b ? a : b) + 1,
        position: existingWindow.position,
        size: existingWindow.size,
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
      add(SelectWindowEvent(id: event.id));
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onSelectWindow(SelectWindowEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);

    final maxZIndex = windows.isNotEmpty
        ? windows.map((w) => w.zIndex).reduce((a, b) => a > b ? a : b)
        : 0.0;

    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(zIndex: maxZIndex + 1.0);
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onUpdateWindowPosition(
      UpdateWindowPositionEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);
    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(position: event.newPosition);
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onUpdateWindowSize(
      UpdateWindowSizeEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);
    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(size: event.newSize);
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onMaximizeWindow(MaximizeWindowEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);
    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(
        isMaximized: !window.isMaximized,
        size: window.isMaximized
            ? window.size
            : Size(MediaQuery.of(event.context).size.width,
                MediaQuery.of(event.context).size.height - 50),
      );
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }

  void _onUpdateWebViewController(
      UpdateWebViewControllerEvent event, Emitter<WindowState> emit) {
    final windows = List<WindowData>.from(state.openWindows);
    final index = windows.indexWhere((window) => window.id == event.id);

    if (index != -1) {
      final window = windows[index];
      windows[index] = window.copyWith(controller: event.controller);
    }

    emit(state.copyWith(openWindows: windows, status: WindowStatus.success));
  }
}
