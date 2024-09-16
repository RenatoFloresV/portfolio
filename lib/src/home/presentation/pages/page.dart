import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:portfolio/global/widgets/bottom_nav.widget.dart';
import 'package:portfolio_ds/lib.dart';

import '../bloc_icons/icons_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<IconBloc>()..add(LoadInitialStateEvent()),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/windows_wallpaper.jpg',
                fit: BoxFit.cover,
              ),
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
                        feedback: Icon(state.icons[index],
                            size: 50.0, color: Colors.yellow),
                        childWhenDragging: Container(),
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: DsText(
                                      '${state.texts[index]} presionado')),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(state.icons[index],
                                  size: 50.0, color: Colors.yellow),
                              DsText(
                                state.texts[index],
                                style: TextStyle(color: context.colors.white),
                              ),
                            ],
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
      ),
    );
  }
}
