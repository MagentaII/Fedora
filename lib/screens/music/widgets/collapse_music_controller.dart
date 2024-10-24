import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:fedora/screens/music/widgets/music_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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

    return Consumer(
      builder: (BuildContext context, MusicModel musicModel, Widget? child) {
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
                        Column(
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
                    child: StreamBuilder<PlayerState>(
                      stream: musicModel.audioPlayer.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        return _playPauseButton(context,
                            audioPlayer: musicModel.audioPlayer,
                            playerState: playerState);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _playPauseButton(BuildContext context,
    {PlayerState? playerState, AudioPlayer? audioPlayer}) {
  log('click play button');
  final processingState = playerState?.processingState;
  final playingState = playerState?.playing;
  final currentPosition = audioPlayer?.position;

  if (processingState == ProcessingState.loading ||
      processingState == ProcessingState.buffering) {
    log('music Loading');
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      color: Colors.white,
      iconSize: 28,
      onPressed: () {
        log('loading........ / buffering........');
      },
    );
  } else if (playingState == false &&
      processingState == ProcessingState.ready &&
      currentPosition == Duration.zero) {
    log('music ready and pause after music Loading');
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      color: Colors.white,
      iconSize: 28,
      onPressed: () {
        log('Play Music');
        context.read<MusicModel>().playMusic();
      },
    );
  } else if (playingState == true &&
      processingState != ProcessingState.completed) {
    log('music playing');
    return IconButton(
      icon: const Icon(Icons.pause),
      color: Colors.white,
      iconSize: 28,
      onPressed: () {
        log('Pause Music');
        context.read<MusicModel>().pauseMusic();
      },
    );
  } else if (playingState == false &&
      processingState != ProcessingState.completed &&
      currentPosition != Duration.zero) {
    log('music pause after playing');
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      color: Colors.white,
      iconSize: 28,
      onPressed: () {
        log('resume Music');
        context.read<MusicModel>().resumeMusic();
      },
    );
  } else {
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      color: Colors.white,
      iconSize: 28,
      onPressed: () {
        log('click play button2');
      },
    );
  }
}
