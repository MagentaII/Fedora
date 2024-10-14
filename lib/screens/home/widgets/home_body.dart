import 'package:fedora/screens/home/widgets/song_list_item.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const SongListItem());
  }
}
