import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/home/presentation/bloc_theme/theme_bloc.dart';
import 'package:portfolio_ds/lib.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      TextTheme textTheme = createTextTheme(context, "Noto Sans", "Noto Sans");
      PortfolioMaterialTheme theme = PortfolioMaterialTheme(textTheme);

      return IconButton(
        icon: Icon(
          state.themeMode == theme.dark()
              ? Icons.brightness_low
              : Icons.brightness_high,
          color:
              state.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
        ),
        onPressed: () => context.read<ThemeBloc>().add(ThemeChangeEvent(
            theme: state.themeMode == theme.light()
                ? theme.dark()
                : theme.light())),
      );
    });
  }
}
