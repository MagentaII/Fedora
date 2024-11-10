import 'package:flutter/material.dart';

class FedoraSliverAppBar extends StatelessWidget {
  final String title;

  const FedoraSliverAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: const Color(0xFF002626),
      // 设置非透明背景
      title: Text(
        title, // Title for the music list
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // final double statusBarHeight = MediaQuery.of(context).padding.top;
    //
    // return Container(
    //   padding: EdgeInsets.only(top: statusBarHeight + 16, left: 16),
    //   width: double.infinity,
    //   color: Colors.teal,
    //   child: const Text(
    //     'Fedora Music', // Title for the music list
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 28,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );
  }
}
