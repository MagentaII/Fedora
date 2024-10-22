import 'package:fedora/models/music.dart';
import 'package:fedora/repositories/music_repository.dart';

abstract class MusicServiceImpl {
  List<Music> getAllMusic();
  String getMusicId(int index);
  Music getMusicById(String musicId);
}

class MusicService implements MusicServiceImpl {
  final MusicRepository _musicRepository;

  MusicService(this._musicRepository);

  @override
  List<Music> getAllMusic() {
    return _musicRepository.getAllMusic();
  }

  @override
  Music getMusicById(String musicId) {
    return _musicRepository.getMusicById(musicId);
  }

  @override
  String getMusicId(int index) {
    return _musicRepository.getMusicId(index);
  }

}