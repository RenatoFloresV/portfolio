import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/home/presentation/bloc_window/window_bloc.dart';
import 'package:portfolio_ds/lib.dart';

import 'widget.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final windowState = context.watch<WindowBloc>().state;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const WeatherWidget(),
          const Spacer(),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: windowState.openWindows
                  .where((window) => window.isMinimized)
                  .length,
              itemBuilder: (context, index) {
                final minimizedWindow = windowState.openWindows
                    .where((window) => window.isMinimized)
                    .toList()[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<WindowBloc>()
                        .add(RestoreWindowEvent(minimizedWindow.id));
                  },
                  child: Tooltip(
                    message: minimizedWindow.name,
                    child: DsBtnIcon(
                      icon: minimizedWindow.icon,
                      onPressed: () {
                        context
                            .read<WindowBloc>()
                            .add(RestoreWindowEvent(minimizedWindow.id));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              const WindowsButton(),
              DsHorizontalSpace.sm,
              const SearchTextField(),
            ],
          ),
          const Spacer(),
          const Spacer(),
          const Row(
            children: [
              LanguageSelector(),
              ThemeButton(),
            ],
          ),
        ],
      ),
    );
  }
}
