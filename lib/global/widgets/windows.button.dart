import 'package:flutter/material.dart';
import 'package:portfolio_ds/lib.dart';

class WindowsButton extends StatelessWidget {
  const WindowsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Perform action on button tap
          print('Windows button tapped');
        },
        child: DsIcon(
          icon: DsIcons.home,
          size: 40,
        ));
  }
}
