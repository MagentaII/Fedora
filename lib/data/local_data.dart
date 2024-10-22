import '../models/music.dart';

abstract class LocalDataImpl {
  List<Music> getAllMusic();

  String getMusicId(int index);

  Music getMusicById(String musicId);
}

class LocalData implements LocalDataImpl {
  List<Music> musics = [
    Music(
      musicId: '1',
      musicName: 'Playing with Light',
      artistName: 'Roie Shpigler',
      musicImage: 'assets/images/playing_with_light_image.jpg',
      musicPath: 'musics/playing_with_light.mp3',
    ),
    Music(
      musicId: '2',
      musicName: 'Hopscotch',
      artistName: 'Louis Adrien',
      musicImage: 'assets/images/hopscotch_image.jpg',
      musicPath: 'musics/hopscotch.mp3',
    ),
    Music(
      musicId: '3',
      musicName: 'Woodcraft',
      artistName: 'Ziv Moran',
      musicImage: 'assets/images/woodcraft_image.jpg',
      musicPath: 'musics/woodcraft.mp3',
    ),
  ];

  @override
  List<Music> getAllMusic() {
    return musics;
  }

  @override
  Music getMusicById(String musicId) {
    final music =
        musics.firstWhere((music) => music.musicId == musicId, orElse: () {
      throw Exception('Music not found, music id : $musicId');
    });
    return music;
  }

  @override
  String getMusicId(int index) {
    final musicId = musics[index].musicId;
    return musicId;
  }
}
