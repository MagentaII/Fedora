import 'package:flutter/material.dart';

import '../../widgets/fedora_sliver_app_bar.dart';

class PodcastView extends StatelessWidget {
  const PodcastView({super.key});

  @override
  Widget build(BuildContext context) {
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
            FedoraSliverAppBar(title: 'Fedora Podcast'),
          ],
        ),
      ),
    );
  }
}
