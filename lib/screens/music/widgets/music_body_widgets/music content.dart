import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/music_model.dart';

class MusicContent extends StatelessWidget {
  const MusicContent({super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 30; // Spacing between Music Controller and border

    return Container(
      // color: Colors.deepPurpleAccent,
      padding: const EdgeInsets.symmetric(horizontal: spacing),
      child: Consumer<MusicModel>(
        builder: (BuildContext context, MusicModel musicModel, Widget? child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  musicModel.music.musicName.isNotEmpty
                      ? musicModel.music.musicName
                      : 'Unknown Title',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  musicModel.music.artistName.isNotEmpty
                      ? musicModel.music.artistName
                      : 'Unknown Artist',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
