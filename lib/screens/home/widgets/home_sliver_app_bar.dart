import 'package:flutter/material.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Color(0xFF002626),  // 设置非透明背景
      title: Text(
        'Fedora Music', // Title for the music list
        style: TextStyle(
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