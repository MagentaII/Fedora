import 'package:fedora/usecases/music_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/music.dart';

abstract class MusicProvider {
  void loadPlaylist();

  void selectAndPlayMusic(int index);

  void playMusic();

  void resumeMusic();

  void pauseMusic();
}

class MusicModel with ChangeNotifier implements MusicProvider {
  final MusicService _musicService;

  MusicModel(this._musicService);

  List<Music> _musics = [];
  bool _isLoading = false;
  Music _music = Music.empty();
  AudioPlayer _audioPlayer = AudioPlayer();

  List<Music> get musics => _musics;

  bool get isLoading => _isLoading;

  Music get music => _music;

  AudioPlayer get audioPlayer => _audioPlayer;

  @override
  void loadPlaylist() {
    _isLoading = true;
    notifyListeners();
    _audioPlayer = _musicService.loadMusics();
    _musics = _musicService.getAllMusic();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void selectAndPlayMusic(int index) {
    final musicId = _musicService.getMusicId(index);
    _music = _musicService.getMusicById(musicId);
    _musicService.playMusic(_music);
    notifyListeners();
  }

  @override
  void playMusic() {
    _musicService.playMusic(_music);
    notifyListeners();
  }

  @override
  void pauseMusic() {
    _musicService.pauseMusic(_music);
    notifyListeners();
  }

  @override
  void resumeMusic() {
    _musicService.resumeMusic(_music, _audioPlayer.position);
    notifyListeners();
  }
}
