import 'package:fedora/screens/music/widgets/music_body.dart';
import 'package:fedora/screens/music/widgets/music_image.dart';
import 'package:flutter/material.dart';

import '../widgets/collapse_music_controller.dart';

class MusicView extends StatelessWidget {
  final double musicBodyOpacity;
  final double bottomMusicOpacity;
  final double imageHeight;
  final double imageWidth;
  final double imageOffsetX;
  final double imageOffsetY;
  final double musicViewHeight;
  final VoidCallback onCollapse;

  const MusicView({
    super.key,
    required this.musicBodyOpacity,
    required this.bottomMusicOpacity,
    required this.imageHeight,
    required this.imageWidth,
    required this.imageOffsetX,
    required this.imageOffsetY,
    required this.musicViewHeight,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: musicViewHeight,
      width: double.infinity,
      color: const Color(0XFF242424),
      child: Stack(
        children: [
          MusicBody(
            musicBodyOpacity: musicBodyOpacity,
            imageHeight: imageHeight,
            imageOffsetY: imageOffsetY,
            onCollapse: onCollapse,
          ),
          AnimatedOpacity(
            opacity: bottomMusicOpacity,
            duration: const Duration(milliseconds: 300),
            child: const CollapseMusicController(),
          ),
          Transform.translate(
            offset: Offset(imageOffsetX, imageOffsetY),
            child: MusicImage(
              imageHeight: imageHeight,
              imageWidth: imageWidth,
            ),
          )
        ],
      ),
    );
  }
}
