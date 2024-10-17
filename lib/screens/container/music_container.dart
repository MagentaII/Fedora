import 'dart:developer';
import 'package:fedora/screens/home/views/home_view.dart';
import 'package:fedora/screens/music/views/music_view.dart';
import 'package:flutter/material.dart';

/// MusicContainer manages the dynamic expansion and collapse of the Music View,
/// allowing users to adjust its size and visibility through gestures.

enum MusicViewState {
  expanded, // Music view has been expanded
  collapsed, // Music view has been collapsed
  sliding, // Music view is in the process of expanding or collapsing
}

enum BottomSheetState {
  expanded, // Bottom sheet has been expanded
  collapsed, // Bottom sheet has been collapsed
  sliding, // Bottom sheet is in the process of expanding or collapsing
  hide, // Bottom sheet is hidden
}

class MusicContainer extends StatefulWidget {
  const MusicContainer({super.key});

  @override
  State<MusicContainer> createState() => _MusicContainerState();
}

class _MusicContainerState extends State<MusicContainer>
    with TickerProviderStateMixin {
  static const double spacing = 30; // Spacing between image and border
  static const double appBarHeight = 72;

  /// Music View
  static const double minimumMusicViewHeight = 72;

  /// Music View Image
  static const double minimumImageSize = 60; // Height or Width
  static const double initialImageOffsetX = 20; // initial image offset X
  static const double initialImageOffsetY = 7; // initial image offset Y

  /// Bottom Sheet
  // Refers to the bottom sheet when the Music view is expanded.
  static const double minimumBottomSheetHeight = 96;

  late double musicViewHeight;
  late double bottomSheetHeight;
  late double imageHeight;
  late double imageWidth;
  late double imageOffsetX;
  late double imageOffsetY;
  late double musicBodyOpacity; // Music Body's opacity (image not included)
  late double bottomMusicOpacity;
  late double collapseMusicControllerOffsetY;
  late MusicViewState musicViewState;
  late BottomSheetState bottomSheetState;

  /// Animation
  late AnimationController _musicViewAnimationController;
  late AnimationController _bottomSheetAnimationController;
  late Animation<double> _musicViewHeightAnimation;
  late Animation<double> _bottomSheetHeightAnimation;

  @override
  void initState() {
    super.initState();

    // initial MusicViewAnimationController
    _musicViewAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // initial BottomSheetAnimationController
    _bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    collapseMusicView();
  }

  @override
  void dispose() {
    _musicViewAnimationController.dispose();
    _bottomSheetAnimationController.dispose();
    super.dispose();
  }

  void collapseMusicView() {
    musicViewState = MusicViewState.collapsed;
    bottomSheetState = BottomSheetState.hide;

    musicViewHeight = minimumMusicViewHeight; // 72.dp
    bottomSheetHeight = 0;
    imageHeight = minimumImageSize; // 60.dp
    imageWidth = minimumImageSize; // 60.dp
    musicBodyOpacity = 0.0; // Music Body's opacity (image not included)
    bottomMusicOpacity = 1.0 - musicBodyOpacity;
    imageOffsetX = initialImageOffsetX; // 20
    imageOffsetY = initialImageOffsetY; // 7
    collapseMusicControllerOffsetY = 0.0;
  }

  void expandMusicView() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    musicViewState = MusicViewState.expanded;
    bottomSheetState = BottomSheetState.collapsed;

    musicViewHeight = screenHeight;
    bottomSheetHeight = minimumBottomSheetHeight; // 96
    imageWidth = screenWidth - (spacing * 2);
    imageHeight = imageWidth;
    musicBodyOpacity = 1.0; // Music Body's opacity (image not included)
    bottomMusicOpacity = 1.0 - musicBodyOpacity;
    imageOffsetX = (screenWidth - imageWidth) / 2;
    imageOffsetY = statusBarHeight + appBarHeight;
    collapseMusicControllerOffsetY = 0.0;
  }

  void dynamicCollapseAndExpandMusicView() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    musicViewState = MusicViewState.sliding;

    double normalizedHeight = (musicViewHeight - minimumMusicViewHeight) /
        (screenHeight - minimumMusicViewHeight); // Normalization : [0, 1]

    double maximumImageSize = screenWidth - (spacing * 2);
    imageWidth = minimumImageSize +
        normalizedHeight * (maximumImageSize - minimumImageSize);
    imageHeight = imageWidth;

    bottomSheetHeight = normalizedHeight * minimumBottomSheetHeight; // [0, 96]

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

  void collapseBottomSheet() {
    expandMusicView(); // Collapse Bottom Sheet is equivalent to Expand Music View
  }

  void expandBottomSheet() {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    bottomSheetState = BottomSheetState.expanded;

    bottomSheetHeight =
        screenHeight - (statusBarHeight + minimumMusicViewHeight);
    imageHeight = minimumImageSize; // 60.dp
    imageWidth = minimumImageSize; // 60.dp
    imageOffsetX = initialImageOffsetX; // 20
    imageOffsetY =
        initialImageOffsetY + statusBarHeight; // 7 + status bar height
    bottomMusicOpacity = 1.0;
    musicBodyOpacity = 1.0 - bottomMusicOpacity;
    collapseMusicControllerOffsetY = statusBarHeight;
  }

  void dynamicCollapseAndExpandBottomSheet() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    bottomSheetState = BottomSheetState.sliding;

    double normalizedHeight = (bottomSheetHeight - minimumBottomSheetHeight) /
        (screenHeight -
            statusBarHeight -
            minimumMusicViewHeight -
            minimumBottomSheetHeight); // Normalization : [0, 1]

    double maximumImageSize = screenWidth - (spacing * 2);
    imageWidth = minimumImageSize +
        (1 - normalizedHeight) * (maximumImageSize - minimumImageSize);
    imageHeight = imageWidth;

    // Calculate target position
    double imageTargetOffsetX = (screenWidth - imageWidth) / 2;
    double imageTargetOffsetY = statusBarHeight + appBarHeight;

    // Adjust position based on height
    imageOffsetX = initialImageOffsetX +
        (1 - normalizedHeight) * (imageTargetOffsetX - initialImageOffsetX);
    imageOffsetY = (initialImageOffsetY + statusBarHeight) +
        (1 - normalizedHeight) *
            (imageTargetOffsetY - (initialImageOffsetY + statusBarHeight));

    bottomMusicOpacity = normalizedHeight;
    musicBodyOpacity = 1.0 - bottomMusicOpacity;

    double collapseMusicControllerTargetOffsetY = statusBarHeight;

    collapseMusicControllerOffsetY =
        normalizedHeight * collapseMusicControllerTargetOffsetY;
  }

  // Handle pan updates (drag)
  void _onPanUpdate(DragUpdateDetails details) {
    log('details_music_view : ${details.delta.dy}'); // > 0 Down、< 0 Up
    final screenHeight = MediaQuery.of(context).size.height;

    double newMusicViewHeight = musicViewHeight - details.delta.dy;

    setState(() {
      // Restrict height range, minimum 72px, maximum full screen height
      if (newMusicViewHeight < minimumMusicViewHeight) {
        collapseMusicView();
      } else if (newMusicViewHeight >= screenHeight) {
        expandMusicView();
      } else {
        musicViewHeight = newMusicViewHeight;
        dynamicCollapseAndExpandMusicView();
      }
    });
  }

  void _onPanUpdateBottomSheet(DragUpdateDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    double newBottomSheetHeight = bottomSheetHeight - details.delta.dy;

    setState(() {
      if (newBottomSheetHeight < minimumBottomSheetHeight) {
        collapseBottomSheet();
      } else if (newBottomSheetHeight >=
          screenHeight - (statusBarHeight + minimumMusicViewHeight)) {
        expandBottomSheet();
      } else {
        bottomSheetHeight = newBottomSheetHeight;
        dynamicCollapseAndExpandBottomSheet();
      }
    });
  }

  // Smooth animation to expand or collapse the music view
  void animateMusicView(double targetHeight) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Create a Tween animation to transition from the current height to the target height
    _musicViewHeightAnimation = Tween<double>(
      begin: musicViewHeight,
      end: targetHeight,
    ).animate(CurvedAnimation(
      parent: _musicViewAnimationController,
      curve: Curves.easeInOut, // Use a smooth transition curve
    ))
      ..addListener(() {
        setState(() {
          musicViewHeight = _musicViewHeightAnimation.value;
          dynamicCollapseAndExpandMusicView(); // Dynamically update the view state
        });
      });

    _musicViewAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (targetHeight == screenHeight) {
            expandMusicView();
          } else if (targetHeight == minimumMusicViewHeight) {
            collapseMusicView();
          }
        });
      }
    });

    // Start the animation
    _musicViewAnimationController.forward(from: 0.0);
  }

  // Smooth animation to expand or collapse the bottom sheet
  void animateBottomSheet(double targetHeight) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    // Create a Tween animation to transition from the current height to the target height
    _bottomSheetHeightAnimation = Tween<double>(
      begin: bottomSheetHeight,
      end: targetHeight,
    ).animate(CurvedAnimation(
      parent: _bottomSheetAnimationController,
      curve: Curves.easeInOut, // Use a smooth transition curve
    ))
      ..addListener(() {
        setState(() {
          bottomSheetHeight = _bottomSheetHeightAnimation.value;
          dynamicCollapseAndExpandBottomSheet(); // Dynamically update the bottom sheet state
        });
      });

    _bottomSheetAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (targetHeight == (screenHeight - (statusBarHeight + minimumMusicViewHeight))) {
            expandBottomSheet();
          } else if (targetHeight == minimumBottomSheetHeight) {
            collapseBottomSheet();
          }
        });
      }
    });

    // Start the animation
    _bottomSheetAnimationController.forward(from: 0.0);
  }

  // Handle pan end (release)
  void _onPanEnd(DragEndDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    log('on Pan End, musicViewHeight : $musicViewHeight');
    log('on Pan End, bottomSheetHeight : $bottomSheetHeight');
    log('screenHeight : $screenHeight');
    setState(() {
      if (musicViewHeight > screenHeight / 2 &&
          musicViewHeight < screenHeight) {
        animateMusicView(screenHeight);
      } else if (musicViewHeight <= screenHeight / 2 &&
          musicViewHeight > minimumMusicViewHeight) {
        animateMusicView(minimumMusicViewHeight);
      }

      if (bottomSheetHeight > screenHeight / 2) {
        animateBottomSheet(
            screenHeight - (statusBarHeight + minimumMusicViewHeight));
      } else if (bottomSheetHeight <= screenHeight / 2 &&
          bottomSheetHeight >= minimumBottomSheetHeight) {
        animateBottomSheet(minimumBottomSheetHeight);
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
            onPanUpdate: (details) {
              if (musicViewState == MusicViewState.expanded &&
                  bottomSheetState == BottomSheetState.collapsed) {
                if (details.delta.dy < 0) {
                  _onPanUpdateBottomSheet(details);
                } else if (details.delta.dy > 0) {
                  _onPanUpdate(details);
                }
              } else if (musicViewState == MusicViewState.expanded &&
                  bottomSheetState != BottomSheetState.collapsed) {
                _onPanUpdateBottomSheet(details);
              } else if (musicViewState != MusicViewState.expanded) {
                _onPanUpdate(details);
              }
            },
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
                    bottomSheetHeight: bottomSheetHeight,
                    collapseMusicControllerOffsetY:
                        collapseMusicControllerOffsetY,
                    onCollapse: () {
                      setState(() {
                        animateMusicView(minimumMusicViewHeight);
                      });
                    },
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
