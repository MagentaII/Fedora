import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicController extends StatelessWidget {
  const MusicController({super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 30; // Spacing between Music Controller and border
    const double sliderSpacing = 8; // Spacing between Slider and border
    const double iconSpacing = 16; // Spacing between Shuffle/Repeat and border

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: spacing),
            child: Consumer<MusicModel>(
              builder:
                  (BuildContext context, MusicModel musicModel, Widget? child) {
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
              // child: const Column(
              //   children: [
              //     Align(
              //       alignment: Alignment.topLeft,
              //       child: Text(
              //         'Music Title',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 28,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //     ),
              //     Align(
              //       alignment: Alignment.topLeft,
              //       child: Text(
              //         'Artist',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
          const SizedBox(height: 20),
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle),
                  color: Colors.white,
                  iconSize: 96,
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
          )
        ],
      ),
    );
  }
}
