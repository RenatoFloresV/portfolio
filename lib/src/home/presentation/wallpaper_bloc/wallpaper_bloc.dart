import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:portfolio/core/local_storage/local_storage.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  final StorageService _storageService;

  WallpaperBloc(this._storageService)
      : super(const WallpaperState(
          wallpaperUrl: '',
          status: WallpaperStatus.none,
        )) {
    on<WallpaperChangeEvent>(_onWallpaperChange);
    on<LoadWallpaperEvent>(_onLoadWallpaper);

    add(LoadWallpaperEvent());
  }

  Future<void> _onLoadWallpaper(
      LoadWallpaperEvent event, Emitter<WallpaperState> emit) async {
    try {
      final wallpaperUrl = await _storageService.getWallpaperUrl();
      emit(state.copyWith(wallpaperUrl: wallpaperUrl ?? ''));
    } catch (e) {
      print('Error loading wallpaper: $e');
      emit(state.copyWith(wallpaperUrl: ''));
    }
  }

  FutureOr<void> _onWallpaperChange(
      WallpaperChangeEvent event, Emitter<WallpaperState> emit) async {
    try {
      await _storageService.saveWallpaperUrl(event.wallpaperUrl);
      emit(state.copyWith(wallpaperUrl: event.wallpaperUrl));
    } catch (e) {
      print('Error saving wallpaper: $e');
    }
  }
}
