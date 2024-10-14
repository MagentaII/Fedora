import 'dart:developer';

import 'package:fedora/screens/music/widgets/music_app_bar.dart';
import 'package:fedora/screens/music/widgets/music_controller.dart';
import 'package:flutter/material.dart';

class MusicBody extends StatelessWidget {
  final double offsetY;
  final double opacity;
  final double imageHeight;
  final double musicViewHeight;
  final VoidCallback onCollapse;

  const MusicBody({
    super.key,
    required this.offsetY,
    required this.opacity,
    required this.imageHeight,
    required this.musicViewHeight,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    log('imageHeight : $imageHeight'); // [60, 350]
    log('offsetY1 : $offsetY'); // [-3, -396]
    log('musicViewHeight : $musicViewHeight'); // [72, 890]

    // Calculate the Y axis position for the MusicController to stay aligned with the bottom of the image
    double controllerOffsetY = musicViewHeight - imageHeight - 20;

    // Ensure the controller doesn't go off-screen
    if (controllerOffsetY < 0) {
      controllerOffsetY = 0;
    }

    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, 72),
            // Clamp to keep it within bounds
            child: MusicAppBar(onCollapse: onCollapse),
          ),
          Transform.translate(
            offset: Offset(0, controllerOffsetY),
            child: const MusicController(),
          ),
        ],
      ),
    );
  }
}
