import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/global/widgets/widget.dart';
import 'package:portfolio/src/_widgets/folder.widget.dart';
import 'package:portfolio_ds/portfolio_ds.dart';

import '../../../_widgets/web_view.widget.dart';
import '../bloc_icons/icons_bloc.dart';
import '../bloc_window/window_bloc.dart';
import '../wallpaper_bloc/wallpaper_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<WallpaperBloc, WallpaperState>(
            builder: (context, state) {
              return Positioned.fill(
                child: Image.asset(
                  state.wallpaperUrl.isNotEmpty
                      ? state.wallpaperUrl
                      : 'assets/windows_wallpaper.jpg',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          BlocBuilder<IconBloc, IconState>(
            builder: (context, state) {
              return Stack(
                children: List.generate(state.icons.length, (index) {
                  return Positioned(
                    left: state.positions[index].dx,
                    top: state.positions[index].dy,
                    child: Draggable<Offset>(
                      data: state.positions[index],
                      feedback: FolderWidget(
                        name: '',
                        color: context.colors.onSurfaceVariant.withOpacity(0.5),
                        icon: state.icons[index],
                      ),
                      childWhenDragging: Container(),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 2) {
                            context.read<WindowBloc>().add(
                                  ShowWindowEvent(
                                    url:
                                        'https://animated-liger-6fba84.netlify.app',
                                    id: 'react-window',
                                    name: 'React Window',
                                    icon: state.icons[index],
                                  ),
                                );
                          } else if (index == 3) {
                            context.read<WindowBloc>().add(
                                  ShowWindowEvent(
                                    url:
                                        'https://boisterous-capybara-db9d88.netlify.app',
                                    id: 'flutter-examples',
                                    name: 'Flutter Examples',
                                    icon: state.icons[index],
                                  ),
                                );
                          }
                        },
                        child: FolderWidget(
                          name: state.texts[index],
                          icon: state.icons[index],
                        ),
                      ),
                      onDragEnd: (details) {
                        context.read<IconBloc>().add(
                              UpdateIconPositionEvent(
                                index: index,
                                newPosition: details.offset,
                              ),
                            );
                      },
                    ),
                  );
                }),
              );
            },
          ),
          BlocBuilder<WindowBloc, WindowState>(
            builder: (context, state) {
              final sortedWindows = List<WindowData>.from(state.openWindows)
                ..sort((a, b) => a.zIndex.compareTo(b.zIndex));
              return Stack(
                children: sortedWindows
                    .where((window) => !window.isMinimized)
                    .map((window) {
                  return WebProjectWindow(
                    id: window.id,
                    key: ValueKey(window.id),
                    size: window.size,
                    url: window.url,
                    isMinimized: window.isMinimized,
                    isMaximized: window.isMaximized,
                    position: window.position,
                    webViewController: window.controller,
                    onClose: () {
                      context
                          .read<WindowBloc>()
                          .add(CloseWindowEvent(window.id));
                    },
                    onMinimize: () {
                      context
                          .read<WindowBloc>()
                          .add(MinimizeWindowEvent(window.id));
                    },
                    onRestore: () {
                      context
                          .read<WindowBloc>()
                          .add(RestoreWindowEvent(window.id));
                    },
                    onSelect: () {
                      context
                          .read<WindowBloc>()
                          .add(SelectWindowEvent(id: window.id));
                    },
                  );
                }).toList(),
              );
            },
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavWidget(),
          ),
        ],
      ),
    );
  }
}
