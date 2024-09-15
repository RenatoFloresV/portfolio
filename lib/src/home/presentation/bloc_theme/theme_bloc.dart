import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
            ThemeState(themeMode: ThemeData.dark(), status: ThemeStatus.none)) {
    on<ThemeChangeEvent>(_onThemeChange);
  }
  FutureOr<void> _onThemeChange(
      ThemeChangeEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(themeMode: event.theme));
  }
}
