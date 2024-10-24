import 'dart:developer';

import 'package:fedora/screens/music/widgets/music_body_widgets/music%20content.dart';
import 'package:fedora/screens/music/widgets/music_body_widgets/music_app_bar.dart';
import 'package:fedora/screens/music/widgets/music_body_widgets/music_controller.dart';
import 'package:flutter/material.dart';

class MusicBody extends StatelessWidget {
  final double musicBodyOpacity;
  final double imageHeight;
  final double imageOffsetY;
  final VoidCallback onCollapse;

  const MusicBody({
    super.key,
    required this.musicBodyOpacity,
    required this.imageHeight,
    required this.imageOffsetY,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    // Spacing between MusicImage and Music Content / Spacing between Music Content and Music Controller
    const double spacing = 20;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    log('imageHeight : $imageHeight'); // [60, 350]

    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.pink,
      child: AnimatedOpacity(
        opacity: musicBodyOpacity,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, statusBarHeight),
              // Clamp to keep it within bounds
              child: MusicAppBar(onCollapse: onCollapse),
            ),
            Transform.translate(
              offset: Offset(0, imageOffsetY + imageHeight + spacing),
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    MusicContent(),
                    SizedBox(height: spacing),
                    MusicController(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
