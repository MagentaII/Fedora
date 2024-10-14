import 'dart:developer';
import 'package:fedora/screens/home/views/home_view.dart';
import 'package:fedora/screens/music/views/music_view.dart';
import 'package:flutter/material.dart';

/// MusicContainer manages the dynamic expansion and collapse of the Music View,
/// allowing users to adjust its size and visibility through gestures.

class MusicContainer extends StatefulWidget {
  const MusicContainer({super.key});

  @override
  State<MusicContainer> createState() => _MusicContainerState();
}

class _MusicContainerState extends State<MusicContainer> {
  static const double spacing = 30; // Spacing between image and border
  static const double appBarHeight = 72;
  static const double minimumMusicViewHeight = 72;
  static const double minimumImageSize = 60; // Height or Width
  static const double initialImageOffsetX = 20; // offset X
  static const double initialImageOffsetY = 7; // offset Y

  late double musicViewHeight;
  late double imageHeight;
  late double imageWidth;
  late double imageOffsetX;
  late double imageOffsetY;
  late double musicBodyOpacity; // Music Body's opacity (image not included)
  late double bottomMusicOpacity;

  @override
  void initState() {
    super.initState();
    collapseMusicView();
  }

  void collapseMusicView() {
    musicViewHeight = minimumMusicViewHeight; // 72.dp
    imageHeight = minimumImageSize; // 60.dp
    imageWidth = minimumImageSize; // 60.dp
    musicBodyOpacity = 0.0; // Music Body's opacity (image not included)
    bottomMusicOpacity = 1.0 - musicBodyOpacity;
    imageOffsetX = initialImageOffsetX; // 20
    imageOffsetY = initialImageOffsetY; // 7
  }

  void expandMusicView() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    musicViewHeight = screenHeight;
    imageWidth = screenWidth - (spacing * 2);
    imageHeight = imageWidth;
    musicBodyOpacity = 1.0; // Music Body's opacity (image not included)
    bottomMusicOpacity = 1.0 - musicBodyOpacity;
    imageOffsetX = (screenWidth - imageWidth) / 2;
    imageOffsetY = statusBarHeight + appBarHeight;
  }

  void dynamicCollapseAndExpandMusicView() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    double normalizedHeight =
        (musicViewHeight - 72) / (screenHeight - 72); // Normalization : [0, 1]

    double maximumImageSize = screenWidth - (spacing * 2);
    imageWidth = minimumImageSize +
        normalizedHeight * (maximumImageSize - minimumImageSize);
    imageHeight = imageWidth;

    // Calculate target position
    double imageTargetOffsetX = (screenWidth - imageWidth) / 2;
    double imageTargetOffsetY = statusBarHeight + appBarHeight;

    // Adjust position based on height
    imageOffsetX = initialImageOffsetX +
        normalizedHeight * (imageTargetOffsetX - initialImageOffsetX);
    imageOffsetY = initialImageOffsetY +
        normalizedHeight * (imageTargetOffsetY - initialImageOffsetY);

    // Calculate opacity based on height
    musicBodyOpacity = normalizedHeight;
    bottomMusicOpacity = 1.0 - musicBodyOpacity;
  }

  // Handle pan updates (drag)
  void _onPanUpdate(DragUpdateDetails details) {
    double newHeight = musicViewHeight - details.delta.dy;
    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      // Restrict height range, minimum 72px, maximum full screen height
      if (newHeight < minimumMusicViewHeight) {
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
                      musicBodyOpacity: musicBodyOpacity,
                      bottomMusicOpacity: bottomMusicOpacity,
                      imageHeight: imageHeight,
                      imageWidth: imageWidth,
                      imageOffsetX: imageOffsetX,
                      imageOffsetY: imageOffsetY,
                      musicViewHeight: musicViewHeight,
                      onCollapse: () {
                        setState(() {
                          collapseMusicView();
                        });
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
