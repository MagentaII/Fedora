import 'package:flutter/material.dart';

class MusicAppBar extends StatelessWidget {
  final VoidCallback onCollapse;

  const MusicAppBar({super.key, required this.onCollapse});

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 72;
    return Container(
      height: appBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onCollapse,
            icon: const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
