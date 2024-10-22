import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongSliverListItem extends StatelessWidget {
  const SongSliverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicModel>(
      builder: (BuildContext context, MusicModel musicModel, Widget? child) {
        if (musicModel.isLoading == true) {
          log('Loading......');
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (musicModel.musics.isEmpty) {
          log('No music found');
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('No music found'),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: musicModel.musics.length,
            (context, index) {
              final music = musicModel.musics[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage(
                          music.musicImage.isNotEmpty
                              ? music.musicImage
                              : 'assets/images/default_album_art.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    music.musicName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    music.artistName,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  onTap: () {
                    // Select and Play Music
                    context.read<MusicModel>().selectAndPlayMusic(index);
                  },
                ),
              );
            },
          ),
        );
      },
    );

    // return ListView.builder(
    //   padding: EdgeInsets.zero,
    //   itemCount: 20,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 4.0),
    //       child: ListTile(
    //         leading: Container(
    //           width: 60.0,
    //           height: 60.0,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(4),
    //             shape: BoxShape.rectangle,
    //             image: const DecorationImage(
    //               image: AssetImage('assets/images/default_album_art.jpg'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         title: const Text(
    //           'Music Title',
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //         subtitle: const Text('Artist', style: TextStyle(color: Colors.white70),),
    //         contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    //         onTap: () {},
    //       ),
    //     );
    //   },
    // );
  }
}
