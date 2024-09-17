part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();

  @override
  List<Object> get props => [];
}

class WallpaperChangeEvent extends WallpaperEvent {
  final String wallpaperUrl;

  const WallpaperChangeEvent({required this.wallpaperUrl});

  @override
  List<Object> get props => [wallpaperUrl];
}

class LoadWallpaperEvent extends WallpaperEvent {}
