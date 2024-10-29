import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../../usecases/music_service.dart';

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
              StreamBuilder<bool>(
                stream: musicModel.audioPlayer.shuffleModeEnabledStream,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  return _shuffleButton(context, snapshot.data ?? false);
                },
              ),
              IconButton(
                onPressed: () {
                  context.read<MusicModel>().previousMusic();
                },
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
                onPressed: () {
                  context.read<MusicModel>().nextMusic();
                },
                icon: const Icon(Icons.skip_next),
                color: Colors.white,
                iconSize: 40,
              ),
              _repeatButton(
                context,
                musicModel.musicLoopMode,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ========================================================================== //
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

Widget _shuffleButton(BuildContext context, bool isEnabled) {
  return IconButton(
    icon: Icon(
      Icons.shuffle,
      color: isEnabled ? Colors.white : Colors.white38,
      size: 28,
    ),
    onPressed: () async {
      await context.read<MusicModel>().shuffleMusic(isEnabled);
    },
  );
}

Widget _repeatButton(BuildContext context, MusicLoopMode musicLoopMode) {
  const cycleModes = [
    MusicLoopMode.off,
    MusicLoopMode.all,
    MusicLoopMode.one,
  ];

  final icons = [
    const Icon(Icons.repeat_sharp, color: Colors.white38, size: 28),
    const Icon(Icons.repeat_sharp, color: Colors.white, size: 28),
    const Icon(Icons.repeat_one_sharp, color: Colors.white, size: 28),
  ];

  final index = cycleModes.indexOf(musicLoopMode);

  return IconButton(
    icon: icons[index],
    onPressed: () {
      context.read<MusicModel>().toggleRepeatMode(musicLoopMode);
    },
  );
}
