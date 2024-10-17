import 'package:flutter/material.dart';

class MusicAnimations {
  final AnimationController musicViewAnimationController;
  final AnimationController bottomSheetAnimationController;

  MusicAnimations({
    required this.musicViewAnimationController,
    required this.bottomSheetAnimationController,
  });

  void dispose() {
    musicViewAnimationController.dispose();
    bottomSheetAnimationController.dispose();
  }

  void animateMusicView({
    required BuildContext context,
    required double musicViewHeight,
    required double targetHeight,
    required Function(double newHeight) updateHeight,
    required Function onCompleteExpand,
    required Function onCompleteCollapse,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final musicViewHeightAnimation = Tween<double>(
      begin: musicViewHeight,
      end: targetHeight,
    ).animate(CurvedAnimation(
      parent: musicViewAnimationController,
      curve: Curves.easeInOut,
    ));

    musicViewHeightAnimation.addListener(() {
      updateHeight(musicViewHeightAnimation.value);
    });

    musicViewAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (targetHeight == screenHeight) {
          onCompleteExpand();
        } else {
          onCompleteCollapse();
        }
      }
    });
  }

  // Smooth animation to expand or collapse the bottom sheet
  void animateBottomSheet({
    required BuildContext context,
    required double bottomSheetHeight,
    required Function(double newHeight) updateHeight,
    required Function onCompleteExpand,
    required Function onCompleteCollapse,
    required double targetHeight,
  }) {
    final bottomSheetHeightAnimation = Tween<double>(
      begin: bottomSheetHeight,
      end: targetHeight,
    ).animate(CurvedAnimation(
      parent: bottomSheetAnimationController,
      curve: Curves.easeInOut,
    ));
    bottomSheetHeightAnimation.addListener(() {
      updateHeight(bottomSheetHeightAnimation.value);
    });

    bottomSheetAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (targetHeight > bottomSheetHeight) {
          onCompleteExpand();
        } else {
          onCompleteCollapse();
        }
      }
    });

    bottomSheetAnimationController.forward(from: 0.0);
  }
}
