import 'package:fedora/data/local_data.dart';
import '../models/music.dart';

abstract class MusicRepositoryImpl {
  List<Music> getAllMusic();

  String getMusicId(int index);

  Music getMusicById(String musicId);
}

class MusicRepository implements MusicRepositoryImpl {
  final LocalData _localData;

  MusicRepository(this._localData);

  @override
  List<Music> getAllMusic() {
    return _localData.getAllMusic();
  }

  @override
  Music getMusicById(String musicId) {
    return _localData.getMusicById(musicId);
  }

  @override
  String getMusicId(int index) {
    return _localData.getMusicId(index);
  }
}
