import 'package:fedora/provider/music_model.dart';
import 'package:fedora/screens/music/widgets/music_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollapseMusicController extends StatelessWidget {
  final VoidCallback onTap;

  const CollapseMusicController({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double collapseMusicViewHeight = 72;
    const double minimumImageSize = 60; // Height or Width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: collapseMusicViewHeight, // 72
        width: double.infinity,
        color: const Color(0XFF242424),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(left: 20, top: 7),
                child: Row(
                  children: [
                    const MusicImage(
                      imageHeight: minimumImageSize,
                      imageWidth: minimumImageSize,
                    ),
                    const SizedBox(width: 16),
                    Consumer<MusicModel>(
                      builder: (BuildContext context, MusicModel musicModel,
                          Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              musicModel.music.musicName.isNotEmpty
                                  ? musicModel.music.musicName
                                  : 'Unknown Title',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              musicModel.music.artistName.isNotEmpty
                                  ? musicModel.music.artistName
                                  : 'Unknown Artist',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Music Title',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ),
                      //     Text(
                      //       'Artist',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
