import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicImage extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;

  const MusicImage({
    super.key,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    double radius;
    if (imageHeight > 100) {
      radius = 12;
    } else {
      radius = 4;
    }
    return Consumer<MusicModel>(
      builder: (BuildContext context, MusicModel musicModel, Widget? child) {
        return Container(
          height: imageHeight,
          width: imageWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: AssetImage(
                musicModel.music.musicImage.isNotEmpty
                    ? musicModel.music.musicImage
                    : 'assets/images/default_album_art.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      // child: Container(
      //   height: imageHeight,
      //   width: imageWidth,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(radius),
      //     image: const DecorationImage(
      //       image: AssetImage('assets/images/default_album_art.jpg'),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
    );
  }
}
