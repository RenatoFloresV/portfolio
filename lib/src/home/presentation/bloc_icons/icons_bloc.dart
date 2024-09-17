import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:portfolio_ds/lib.dart';

part 'icons_event.dart';
part 'icons_state.dart';

class IconBloc extends Bloc<IconEvent, IconState> {
  final StorageService _storageService;

  IconBloc(this._storageService)
      : super(IconState(
          icons: [
            null,
            DsIcons.trash,
            null,
            null,
            null,
            null,
          ],
          texts: const [
            'Documents',
            'Recycle bin',
            'Rick and Morty',
            'Paladins',
            'Music',
            'Photos'
          ],
          positions: const [
            Offset(100, 100),
            Offset(200, 200),
            Offset(300, 300),
            Offset(400, 400),
            Offset(500, 500),
            Offset(600, 600),
          ],
          function: [
            () {
              print('Click en documents');
            },
            () {
              print('Click en recycle bin');
            },
            () {
              print('Click en rick and morty');
            },
            () {
              print('Click en paladins');
            },
            () {
              print('Click en music');
            },
            () {
              print('Click en photos');
            },
          ],
        )) {
    on<UpdateIconPositionEvent>(_onUpdateIconPosition);
    on<SaveIconStateEvent>(_onSaveIconState);
    on<ChangeLanguageEvent>(_onChangeLanguageEvent);
    on<LoadInitialStateEvent>(_loadInitialState);
  }

  Future<void> _loadInitialState(
      LoadInitialStateEvent event, Emitter<IconState> emit) async {
    try {
      final positions = await _storageService.getIconsPositions();
      final language = await _storageService.getLanguage();

      emit(state.copyWith(
        positions: positions.isEmpty ? state.positions : positions,
        language: language ?? state.language,
      ));
    } catch (e) {
      // Handle any errors if needed
      print('Error loading initial state: $e');
    }
  }

  void _onUpdateIconPosition(
      UpdateIconPositionEvent event, Emitter<IconState> emit) {
    final updatedPositions = List<Offset>.from(state.positions);
    updatedPositions[event.index] = event.newPosition;

    emit(state.copyWith(positions: updatedPositions));

    add(SaveIconStateEvent());
  }

  void _onSaveIconState(
      SaveIconStateEvent event, Emitter<IconState> emit) async {
    try {
      await _storageService.saveIconsPositions(state.positions);
    } catch (e) {
      // Handle any errors if needed
      print('Error saving icon state: $e');
    }
  }

  void _onChangeLanguageEvent(
      ChangeLanguageEvent event, Emitter<IconState> emit) async {
    try {
      await _storageService.saveLanguage(event.language);
      emit(state.copyWith(language: event.language));
    } catch (e) {
      // Handle any errors if needed
      print('Error changing language: $e');
    }
  }
}
