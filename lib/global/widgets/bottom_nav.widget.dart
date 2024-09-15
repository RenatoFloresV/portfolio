import 'package:flutter/material.dart';

import 'package:portfolio_ds/lib.dart';

import 'widget.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ThemeButton(),
          const WindowsButton(),
          DsHorizontalSpace.sm,
          const SearchTextField(),
          const Spacer(),
          const LanguageSelector()
        ],
      ),
    );
  }
}
