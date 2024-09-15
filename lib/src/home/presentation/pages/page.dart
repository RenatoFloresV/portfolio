import 'package:flutter/material.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/global/widgets/bottom_nav.widget.dart';
import 'package:portfolio_ds/lib.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              '../../../../../assets/windows_wallpaper.jpg',
              fit: BoxFit.cover,
            ),
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
