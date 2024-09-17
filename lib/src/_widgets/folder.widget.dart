import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/home/presentation/bloc_theme/theme_bloc.dart';
import 'package:portfolio_ds/lib.dart';

class FolderWidget extends StatelessWidget {
  const FolderWidget({
    required this.name,
    this.icon,
    this.color,
    super.key,
  });

  final String name;
  final DsIconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: Modular.get<ThemeBloc>(),
      builder: (context, state) {
        final isLightTheme = state.status == ThemeStatus.light;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DsIcon(
              icon: icon ??
                  (isLightTheme ? DsIcons.folderDark : DsIcons.folderLight),
              size: 48.0,
              color: color,
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
