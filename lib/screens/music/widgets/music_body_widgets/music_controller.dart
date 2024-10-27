import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class MusicController extends StatelessWidget {
  const MusicController({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSpacing = 16; // Spacing between Shuffle/Repeat and border

    return Consumer<MusicModel>(
      builder: (BuildContext context, MusicModel musicModel, Widget? child) {
        return Container(
          // color: Colors.teal,
          padding: const EdgeInsets.symmetric(horizontal: iconSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shuffle),
                color: Colors.white,
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_previous),
                color: Colors.white,
                iconSize: 40,
              ),
              StreamBuilder<PlayerState>(
                stream: musicModel.audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  return _playPauseButton(context,
                      audioPlayer: musicModel.audioPlayer,
                      playerState: playerState);
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_next),
                color: Colors.white,
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.repeat_sharp),
                color: Colors.white,
                iconSize: 28,
              ),
            ],
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
      icon: const Icon(Icons.play_circle),
      color: Colors.white,
      iconSize: 96,
      onPressed: () {
        log('loading........ / buffering........');
      },
    );
  } else if (playingState == false &&
      processingState == ProcessingState.ready &&
      currentPosition == Duration.zero) {
    log('music ready and pause after music Loading');
    return IconButton(
      icon: const Icon(Icons.play_circle),
      color: Colors.white,
      iconSize: 96,
      onPressed: () {
        log('Play Music');
        context.read<MusicModel>().playMusic();
      },
    );
  } else if (playingState == true &&
      processingState != ProcessingState.completed) {
    log('music playing');
    return IconButton(
      icon: const Icon(Icons.pause_circle),
      color: Colors.white,
      iconSize: 96,
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
      icon: const Icon(Icons.play_circle),
      color: Colors.white,
      iconSize: 96,
      onPressed: () {
        log('resume Music');
        context.read<MusicModel>().resumeMusic();
      },
    );
  } else {
    return IconButton(
      icon: const Icon(Icons.play_circle),
      color: Colors.white,
      iconSize: 96,
      onPressed: () {
        log('click play button2');
      },
    );
  }
}
