import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio/global/widgets/bottom_nav.widget.dart';
import 'package:portfolio/src/_widgets/folder.widget.dart';
import 'package:portfolio/src/home/presentation/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:portfolio_ds/lib.dart';

import '../bloc_icons/icons_bloc.dart';

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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    DsText('${state.texts[index]} presionado')),
                          );
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
