import 'package:fedora/screens/container/music_container.dart';
import 'package:flutter/material.dart';

class FedoraAppView extends StatelessWidget {
  const FedoraAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fedora Music App',
      theme: ThemeData(useMaterial3: true),
      home: const MusicContainer(),
    );
  }
}
