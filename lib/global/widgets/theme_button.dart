import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/home/presentation/bloc_theme/theme_bloc.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select((ThemeBloc bloc) => bloc.state.themeMode);
    final isDarkMode = themeMode == ThemeMode.dark;

    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.brightness_low : Icons.brightness_high,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      onPressed: () => context.read<ThemeBloc>().add(
            ThemeChangeEvent(
              theme: isDarkMode ? ThemeMode.light : ThemeMode.dark,
            ),
          ),
    );
  }
}
