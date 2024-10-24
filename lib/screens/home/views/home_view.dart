import 'package:fedora/provider/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_sliver_app_bar.dart';
import '../widgets/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

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
            HomeSliverAppBar(),
            HomeBody(),
          ],
        ),
      ),
    );
  }
}
