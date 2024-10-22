import 'package:fedora/app.dart';
import 'package:fedora/data/local_data.dart';
import 'package:fedora/provider/music_model.dart';
import 'package:fedora/repositories/music_repository.dart';
import 'package:fedora/usecases/music_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final localData = LocalData();
  final musicRepository = MusicRepository(localData);
  final musicService = MusicService(musicRepository);

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => MusicModel(musicService),
      child: const FedoraApp(),
    ),
  );
}
