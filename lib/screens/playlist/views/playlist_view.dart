import 'dart:developer';

import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/fedora_sliver_app_bar.dart';
import '../widgets/playlist_body.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  void initState() {
    super.initState();
    log('initState');

    // 确保在 widget 构建完成后调用 loadPlaylist()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MusicModel>().loadPlaylist();
    });
  }

  @override
  Widget build(BuildContext context) {
    // context.read<MusicModel>().loadPlaylist();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF002626),
              Color(0xFF000000),
            ],
            stops: [
              0.1,
              1.0,
            ],
          ),
        ),
        child: const CustomScrollView(
          slivers: [
            FedoraSliverAppBar(title: 'Fedora Music',),
            PlaylistBody(),
          ],
        ),
      ),
    );
  }
}
