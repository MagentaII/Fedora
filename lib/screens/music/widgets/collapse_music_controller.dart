import 'package:fedora/screens/music/widgets/music_image.dart';
import 'package:flutter/material.dart';

class CollapseMusicController extends StatelessWidget {
  const CollapseMusicController({super.key});

  @override
  Widget build(BuildContext context) {
    const double collapseMusicViewHeight = 72;
    const double minimumImageSize = 60; // Height or Width

    return Container(
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
              child: const Row(
                children: [
                  MusicImage(
                    imageHeight: minimumImageSize,
                    imageWidth: minimumImageSize,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Music Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Artist',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
    );
  }
}
