import 'package:fedora/screens/music/widgets/music_body.dart';
import 'package:fedora/screens/music/widgets/music_image.dart';
import 'package:flutter/material.dart';

import '../widgets/collapse_music_controller.dart';
import '../widgets/music_tar_bar.dart';

class MusicView extends StatelessWidget {
  final double musicBodyOpacity;
  final double bottomMusicOpacity;
  final double imageHeight;
  final double imageWidth;
  final double imageOffsetX;
  final double imageOffsetY;
  final double musicViewHeight;
  final double bottomSheetHeight;
  final double collapseMusicControllerOffsetY;
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
    required this.bottomSheetHeight,
    required this.collapseMusicControllerOffsetY,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    const double minimumImageSize = 60; // Height or Width
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
          Transform.translate(
            offset: Offset(0, collapseMusicControllerOffsetY),
            child: AnimatedOpacity(
              opacity: bottomMusicOpacity,
              duration: const Duration(milliseconds: 300),
              child: const CollapseMusicController(),
            ),
          ),
          Opacity(
            opacity: imageHeight == minimumImageSize ? 0.0 : 1.0,
            // opacity: 1.0,
            child: Transform.translate(
              offset: Offset(imageOffsetX, imageOffsetY),
              child: MusicImage(
                imageHeight: imageHeight,
                imageWidth: imageWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: bottomSheetHeight,
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              decoration: BoxDecoration(
                color: bottomSheetHeight <= 96
                    ? const Color(0xFF242424)
                    : const Color(0xFF343434),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: MusicTarBar(
                bottomSheetHeight: bottomSheetHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }


}
