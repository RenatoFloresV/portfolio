import 'package:flutter/material.dart';
import 'package:portfolio/src/home/presentation/bloc_window/window_bloc.dart';

class MinimizedWindow extends StatelessWidget {
  final WindowData windowData;
  final VoidCallback onRestore;

  const MinimizedWindow({
    super.key,
    required this.windowData,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 150,
      height: 30,
      child: Row(
        children: [
          Text(windowData.url, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.restore, color: Colors.white),
            onPressed: onRestore,
          ),
        ],
      ),
    );
  }
}
