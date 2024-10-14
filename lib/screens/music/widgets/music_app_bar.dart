import 'package:flutter/material.dart';

class MusicAppBar extends StatelessWidget {
  final VoidCallback onCollapse;

  const MusicAppBar({super.key, required this.onCollapse});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        IconButton(
          onPressed: onCollapse,
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}
