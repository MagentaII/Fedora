import 'dart:async';
import 'dart:developer';

import 'package:fedora/usecases/music_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/music.dart';
import '../screens/music/widgets/music_body_widgets/seek_bar.dart';

abstract class MusicProvider {
  void loadPlaylist();

  void selectAndPlayMusic(int index);

  void playMusic();

  void resumeMusic();

  void pauseMusic();

  void dragMusicPosition(double? value);

  void seekMusic(Duration position);

  void nextMusic();

  void previousMusic();

  Future<void> shuffleMusic(bool isEnabled);

  void toggleRepeatMode(MusicLoopMode musicLoopMode);
}

// ========================================================================== //
class MusicModel with ChangeNotifier implements MusicProvider {
  final MusicService _musicService;

  MusicModel(this._musicService) {
    _musicService.positionDataStream.listen((positionData) {
      if (positionData.position >=
          positionData.duration - const Duration(milliseconds: 200)) {
        log("completed");
        log('positionData.position : ${positionData.position}');
        log('positionData.duration : ${positionData.duration - const Duration(milliseconds: 200)}');
        _handlePlaybackCompletion();
      }
    });
  }

  // ======================================================================== //
  List<Music> _musics = [];
  bool _isLoading = false;
  Music _music = Music.empty();
  AudioPlayer _audioPlayer = AudioPlayer();
  Duration? _dragValue;

  MusicLoopMode _musicLoopMode = MusicLoopMode.off;

  // ======================================================================== //
  List<Music> get musics => _musics;

  bool get isLoading => _isLoading;

  Music get music => _music;

  AudioPlayer get audioPlayer => _audioPlayer;

  Duration? get dragValue => _dragValue;

  // LoopMode get loopMode => _loopMode;

  MusicLoopMode get musicLoopMode => _musicLoopMode;

  Stream<PositionData> get positionDataStream =>
      _musicService.positionDataStream;

  // ======================================================================== //
  @override
  void dispose() {
    _musicService.dispose();
    super.dispose();
  }

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
    _musicService.pauseMusic();
    notifyListeners();
  }

  @override
  void resumeMusic() {
    _musicService.resumeMusic(_audioPlayer.position);
    notifyListeners();
  }

  @override
  void dragMusicPosition(double? value) {
    _dragValue = value == null ? null : Duration(milliseconds: value.round());
    notifyListeners();
  }

  @override
  void seekMusic(Duration newPosition) {
    _musicService.seekMusic(newPosition);
    notifyListeners();
  }

  @override
  void nextMusic() {
    _musicService.musicLoopMode = _musicLoopMode;
    final nextIndex = _musicService.nextMusic();
    final musicId = _musicService.getMusicId(nextIndex);
    log('next musicId : $musicId');
    _music = _musicService.getMusicById(musicId);
    notifyListeners();
  }

  @override
  void previousMusic() {
    final previousIndex = _musicService.previousMusic();
    final musicId = _musicService.getMusicId(previousIndex);
    log('previous musicId : $musicId');
    _music = _musicService.getMusicById(musicId);
    notifyListeners();
  }

  @override
  Future<void> shuffleMusic(bool isEnabled) async {
    await _musicService.shuffleMusic(isEnabled);
    notifyListeners();
  }

  @override
  void toggleRepeatMode(MusicLoopMode currentMusicLoopMode) {
    _musicLoopMode = _musicService.toggleRepeatMode(currentMusicLoopMode);
    notifyListeners();
  }

  void _handlePlaybackCompletion() {
    switch (_musicLoopMode) {
      case MusicLoopMode.one:
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.play();
        break;
      case MusicLoopMode.all:
        nextMusic();
        break;
      case MusicLoopMode.off:
        log('MusicLoopMode.off, nextMusic');
        nextMusic();
        break;
    }
  }
}
