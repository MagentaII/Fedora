import 'dart:async';
import 'dart:developer';

import 'package:fedora/models/music.dart';
import 'package:fedora/repositories/music_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../screens/music/widgets/music_body_widgets/seek_bar.dart';

abstract class MusicServiceImpl {
  AudioPlayer loadMusics();

  List<Music> getAllMusic();

  String getMusicId(int index);

  Music getMusicById(String musicId);

  void playMusic(Music music);

  void resumeMusic(Duration currentPosition);

  void pauseMusic();

  void seekMusic(Duration position);

  int nextMusic();

  int previousMusic();

  Future<void> shuffleMusic(bool isEnabled);

  MusicLoopMode toggleRepeatMode(MusicLoopMode currentMusicLoopMode);

  void dispose();
}

// ========================================================================== //
enum MusicLoopMode {
  off,
  all,
  one,
}

// ========================================================================== //
class MusicService implements MusicServiceImpl {
  final MusicRepository _musicRepository;
  final AudioPlayer _audioPlayer;
  MusicLoopMode musicLoopMode = MusicLoopMode.off;

  MusicService(this._musicRepository, {AudioPlayer? audioPlayer})
      : _audioPlayer = audioPlayer ?? AudioPlayer();

  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  // ======================================================================== //
  @override
  void dispose() {
    // _currentMusicIdController.close();
  }

  @override
  AudioPlayer loadMusics() {
    final musics = _musicRepository.getAllMusic();
    if (musics.isNotEmpty) {
      final audioSources = musics.map((music) {
        return AudioSource.asset(music.musicPath);
      }).toList();

      _audioPlayer
          .setAudioSource(
        ConcatenatingAudioSource(children: audioSources),
      )
          .catchError((error) {
        log("An error occurred: $error");
        return Duration.zero;
      });
    }

    return _audioPlayer;
  }

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

  @override
  void pauseMusic() {
    _audioPlayer.pause();
  }

  @override
  void playMusic(Music music) {
    final index = _audioPlayer.audioSource?.sequence.indexWhere((source) {
      return (source as UriAudioSource).uri ==
          Uri.parse('asset:///${music.musicPath}');
    });

    if (index != -1) {
      _audioPlayer.seek(Duration.zero, index: index);
      _audioPlayer.play();
    } else {
      log('Music not found to play');
    }
  }

  @override
  void resumeMusic(Duration currentPosition) {
    _audioPlayer.seek(currentPosition);
    _audioPlayer.play();
  }

  @override
  void seekMusic(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  int nextMusic() {
    int nextIndex = -1;
    if (musicLoopMode == MusicLoopMode.all) {
      nextIndex = _audioPlayer.nextIndex ?? 0;
      _audioPlayer.hasNext
          ? _audioPlayer.seekToNext()
          : _audioPlayer.seek(Duration.zero, index: 0);
    } else {
      nextIndex = _audioPlayer.nextIndex ?? -1;
      _audioPlayer.hasNext ? _audioPlayer.seekToNext() : null;
    }
    return nextIndex;
  }

  @override
  int previousMusic() {
    int previousIndex = _audioPlayer.previousIndex ?? -1;
    _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious() : null;
    return previousIndex;
  }

  @override
  Future<void> shuffleMusic(bool isEnabled) async {
    if (!isEnabled) {
      await _audioPlayer.shuffle();
    }
    await _audioPlayer.setShuffleModeEnabled(!isEnabled);
  }

  @override
  MusicLoopMode toggleRepeatMode(MusicLoopMode currentMusicLoopMode) {
    const cycleModes = [
      MusicLoopMode.off,
      MusicLoopMode.all,
      MusicLoopMode.one,
    ];

    final nextMusicLoopModeIndex =
        (cycleModes.indexOf(currentMusicLoopMode) + 1) % cycleModes.length;

    return cycleModes[nextMusicLoopModeIndex];
  }
}
