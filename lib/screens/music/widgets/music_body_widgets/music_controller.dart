import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class MusicController extends StatelessWidget {
  const MusicController({super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 30; // Spacing between Music Controller and border
    const double sliderSpacing = 8; // Spacing between Slider and border
    const double iconSpacing = 16; // Spacing between Shuffle/Repeat and border

    return Consumer<MusicModel>(
      builder: (BuildContext context, MusicModel musicModel, Widget? child) {
        return Container(
          // color: Colors.indigoAccent,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: sliderSpacing),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // 已经过的轨道部分颜色
                    activeTrackColor: Colors.white,
                    // 未经过的轨道部分颜色
                    inactiveTrackColor: Colors.white30,
                    // 滑块的颜色
                    thumbColor: Colors.white,
                    // 滑块点击时的颜色
                    overlayColor: Colors.white.withOpacity(0.2),
                    // 轨道的高度
                    trackHeight: 2.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8.0, // 调整滑块圆形的半径
                    ),
                  ),
                  child: Slider(
                    value: 50,
                    max: 100.0,
                    min: 0.0,
                    onChanged: (value) {
                      // 滑块变化时的逻辑处理
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: spacing),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0:00',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '4:44',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
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
