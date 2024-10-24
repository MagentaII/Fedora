import 'dart:developer';

import 'package:fedora/models/music.dart';
import 'package:fedora/repositories/music_repository.dart';
import 'package:just_audio/just_audio.dart';

abstract class MusicServiceImpl {
  AudioPlayer loadMusics();

  List<Music> getAllMusic();

  String getMusicId(int index);

  Music getMusicById(String musicId);

  void playMusic(Music music);

  void resumeMusic(Music music, Duration currentPosition);

  void pauseMusic(Music music);
}

class MusicService implements MusicServiceImpl {
  final MusicRepository _musicRepository;
  final AudioPlayer _audioPlayer;

  MusicService(this._musicRepository, {AudioPlayer? audioPlayer})
      : _audioPlayer = audioPlayer ?? AudioPlayer();

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
  void pauseMusic(Music music) {
    final index = _audioPlayer.audioSource?.sequence.indexWhere((source) {
      log('music.musicPath : ${music.musicPath}');
      log('source.uri : ${(source as UriAudioSource).uri}');
      return (source as UriAudioSource).uri == Uri.parse('asset:///${music.musicPath}');
    });

    if (index != -1) {
      _audioPlayer.pause();
    } else {
      log('Music not found to pause');
    }
  }

  @override
  void playMusic(Music music) {
    final index = _audioPlayer.audioSource?.sequence.indexWhere((source) {
      log('music.musicPath : ${music.musicPath}');
      log('source.uri : ${(source as UriAudioSource).uri}');
      return (source as UriAudioSource).uri == Uri.parse('asset:///${music.musicPath}');
    });

    if (index != -1) {
      _audioPlayer.seek(Duration.zero, index: index);
      _audioPlayer.play();
    } else {
      log('Music not found to play');
    }
  }

  @override
  void resumeMusic(Music music, Duration currentPosition) {
    final index = _audioPlayer.audioSource?.sequence.indexWhere((source) {
      log('music.musicPath : ${music.musicPath}');
      log('source.uri : ${(source as UriAudioSource).uri}');
      return (source as UriAudioSource).uri == Uri.parse('asset:///${music.musicPath}');
    });

    if (index != -1) {
      _audioPlayer.seek(currentPosition, index: index);
      _audioPlayer.play();
    } else {
      log('Music not found to resume');
    }
  }
}
