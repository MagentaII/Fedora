import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:fedora/screens/music/widgets/music_body_widgets/seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicSeekBar extends StatelessWidget {
  const MusicSeekBar({super.key});

  String formatDuration(Duration duration) {
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 30; // Spacing between Music Controller and border

    return Consumer<MusicModel>(
      builder: (BuildContext context, MusicModel musicModel, Widget? child) {
        return Container(
          // color: Colors.pink,
          child: StreamBuilder<PositionData>(
            stream: musicModel.positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              log('positionData duration: ${positionData?.duration ?? Duration.zero}');
              return Column(
                children: [
                  SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChanged: (dragPosition) {
                      log('dragPosition : $dragPosition');
                    },
                    onChangeEnd: (newPosition) {
                      context.read<MusicModel>().seekMusic(newPosition);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: spacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(
                              musicModel.dragValue ?? positionData?.position ?? Duration.zero),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          formatDuration(
                              positionData?.duration ?? Duration.zero),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
