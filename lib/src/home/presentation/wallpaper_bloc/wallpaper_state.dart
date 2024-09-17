part of 'wallpaper_bloc.dart';

enum WallpaperStatus {
  none,
  initial,
  success,
  error,
}

class WallpaperState extends Equatable {
  const WallpaperState({required this.wallpaperUrl, required this.status});

  final String wallpaperUrl;
  final WallpaperStatus status;

  WallpaperState copyWith({
    String? wallpaperUrl,
    WallpaperStatus? status,
  }) {
    return WallpaperState(
      wallpaperUrl: wallpaperUrl ?? this.wallpaperUrl,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [wallpaperUrl, status];
}
