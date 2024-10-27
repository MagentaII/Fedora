import 'dart:math' hide log;

import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeekBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.white54,
            inactiveTrackColor: Colors.white30,
            trackHeight: 1.0,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 0.0, // 调整滑块圆形的半径
            ),
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: duration.inMilliseconds.toDouble(),
              value: min(
                duration.inMilliseconds.toDouble(),
                bufferedPosition.inMilliseconds.toDouble(),
              ),
              onChanged: (_) {},
            ),
          ),
        ),
        SliderTheme(
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
          child: Consumer<MusicModel>(
            builder: (BuildContext context, MusicModel musicModel, Widget? child) {
              return Slider(
                min: 0.0,
                max: duration.inMilliseconds.toDouble(),
                value: min(
                  duration.inMilliseconds.toDouble(),
                  musicModel.dragValue?.inMilliseconds.toDouble() ?? position.inMilliseconds.toDouble(),
                ),
                onChanged: (value) {
                  if (onChanged != null) {
                    context.read<MusicModel>().dragMusicPosition(value);
                    // onChanged!(Duration(milliseconds: value.round()));
                  }
                },
                onChangeEnd: (value) {
                  if (onChangeEnd != null) {
                    onChangeEnd!(Duration(milliseconds: value.round()));
                    context.read<MusicModel>().dragMusicPosition(null);
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
