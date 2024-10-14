import 'package:fedora/screens/music/widgets/bottom_music_controller.dart';
import 'package:fedora/screens/music/widgets/music_body.dart';
import 'package:flutter/material.dart';

class MusicView extends StatelessWidget {
  final double offsetY;
  final double opacity;
  final double imageHeight;
  final double musicViewHeight;
  final VoidCallback onCollapse;

  const MusicView({
    super.key,
    required this.offsetY,
    required this.opacity,
    required this.imageHeight,
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
            offsetY: offsetY,
            opacity: opacity,
            imageHeight: imageHeight,
            musicViewHeight: musicViewHeight,
            onCollapse: onCollapse,
          ),
          AnimatedOpacity(
            opacity: 1.0 - opacity,
            duration: const Duration(milliseconds: 300),
            child: const BottomMusicController(),
          ),
        ],
      ),
    );
  }
}
