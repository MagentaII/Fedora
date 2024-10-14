import 'dart:developer';

import 'package:fedora/screens/home/views/home_view.dart';
import 'package:fedora/screens/music/views/music_view.dart';
import 'package:fedora/screens/music/widgets/music_image.dart';
import 'package:flutter/material.dart';

class MusicContainer extends StatefulWidget {
  const MusicContainer({super.key});

  @override
  State<MusicContainer> createState() => _MusicContainerState();
}

class _MusicContainerState extends State<MusicContainer> {
  final double spacing = 30; // Spacing between image and border

  late double musicViewHeight;
  late double imageHeight;
  late double imageWidth;
  late double imageOffsetX;
  late double imageOffsetY;
  late double scale; // Not used yet
  late double opacity; // Music Body's opacity

  @override
  void initState() {
    super.initState();
    collapseMusicView();
  }

  void collapseMusicView() {
    musicViewHeight = 72;
    imageHeight = 60;
    imageWidth = 60;
    scale = imageHeight / 60; // Not used yet
    opacity = 0.0; // Music Body's opacity
    imageOffsetX = 20;
    imageOffsetY = -3;
  }

  void expandMusicView() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    musicViewHeight = screenHeight;
    imageWidth = screenWidth - (spacing * 2);
    imageHeight = imageWidth;
    scale = imageHeight / 60; // Not used yet
    opacity = 1.0; // Music Body's opacity
    imageOffsetX = (screenWidth - imageWidth) / 2;
    imageOffsetY = -(screenHeight - imageHeight - 72 - 72);
  }

  void dynamicCollapseAndExpandMusicView() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust image size based on height, scaling between 60 and 300
    double normalizedHeight =
        (musicViewHeight - 72) / (screenHeight - 72); // Normalization : [0, 1]
    log('normalizedHeight : $normalizedHeight');
    imageHeight =
        60 + normalizedHeight * (350 - 60); // Image scales from 60 to 300
    imageWidth = 60 + normalizedHeight * (350 - 60); // Width scales accordingly
    scale = imageHeight / 60;

    // Calculate target position
    double targetOffsetX = (screenWidth - imageWidth) / 2;
    double targetOffsetY = (screenHeight - imageHeight - 72 - 72);

    // Adjust position based on height
    imageOffsetX = 20 + normalizedHeight * (targetOffsetX - 20);
    imageOffsetY = -3 - normalizedHeight * (targetOffsetY + 3);

    // Calculate opacity based on height
    opacity = normalizedHeight;
  }

  // Handle pan updates (drag)
  void _onPanUpdate(DragUpdateDetails details) {
    double newHeight = musicViewHeight - details.delta.dy;
    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      // Restrict height range, minimum 72px, maximum full screen height
      if (newHeight < 72) {
        collapseMusicView();
      } else if (newHeight > screenHeight) {
        expandMusicView();
      } else {
        musicViewHeight = newHeight;
        dynamicCollapseAndExpandMusicView();
      }
    });
  }

  // Handle pan end (release)
  void _onPanEnd(DragEndDetails details) {
    setState(() {
      // If height is greater than 450, expand to full screen
      if (musicViewHeight > 450) {
        expandMusicView();
      }
      // Otherwise, collapse back to original size
      else if (musicViewHeight <= 450) {
        collapseMusicView();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log('offsetX : $imageOffsetX, offsetY : $imageOffsetY');
    log('scale : $scale');
    return Scaffold(
      body: Stack(
        children: [
          const HomeView(),
          // home
          // library
          GestureDetector(
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Stack(
              children: [
                //  Music View
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MusicView(
                      offsetY: imageOffsetY,
                      opacity: opacity,
                      imageHeight: imageHeight,
                      musicViewHeight: musicViewHeight,
                      onCollapse: () {
                        setState(() {
                          collapseMusicView();
                        });
                      }),
                ),
                //  Music Image
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Transform.translate(
                    offset: Offset(imageOffsetX, imageOffsetY),
                    child: MusicImage(
                      imageHeight: imageHeight,
                      imageWidth: imageWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
