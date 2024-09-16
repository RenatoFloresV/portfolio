import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService _storageService;

  ThemeBloc(this._storageService)
      : super(
            ThemeState(themeMode: ThemeData.dark(), status: ThemeStatus.none)) {
    on<ThemeChangeEvent>(_onThemeChange);
    on<LoadThemeEvent>(_onLoadTheme);

    add(LoadThemeEvent());
  }

  Future<void> _onLoadTheme(
      LoadThemeEvent event, Emitter<ThemeState> emit) async {
    try {
      final themeMode = await _storageService.getThemeMode();
      final themeData = themeMode ?? ThemeData.dark();
      emit(state.copyWith(themeMode: themeData));
    } catch (e) {
      print('Error loading theme: $e');

      emit(state.copyWith(themeMode: ThemeData.dark()));
    }
  }

  FutureOr<void> _onThemeChange(
      ThemeChangeEvent event, Emitter<ThemeState> emit) async {
    try {
      await _storageService.saveThemeMode(event.theme);
      emit(state.copyWith(themeMode: event.theme));
    } catch (e) {
      print('Error saving theme: $e');
    }
  }
}
