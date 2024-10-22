import 'package:fedora/usecases/music_service.dart';
import 'package:flutter/material.dart';

import '../models/music.dart';

abstract class MusicProvider {
  void loadPlaylist();
  void selectAndPlayMusic(int index);
}

class MusicModel with ChangeNotifier implements MusicProvider{
  final MusicService _musicService;

  MusicModel(this._musicService);

  List<Music> _musics = [];
  bool _isLoading = false;
  Music _music = Music.empty();

  List<Music> get musics => _musics;

  bool get isLoading => _isLoading;

  Music get music => _music;

  @override
  void loadPlaylist() {
    _isLoading = true;
    notifyListeners();

    _musics = _musicService.getAllMusic();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void selectAndPlayMusic(int index) {
    final musicId = _musicService.getMusicId(index);
    _music = _musicService.getMusicById(musicId);
    notifyListeners();
  }
}
