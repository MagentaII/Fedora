import 'package:flutter/material.dart';

class CollapseMusicController extends StatelessWidget {
  const CollapseMusicController({super.key});

  @override
  Widget build(BuildContext context) {
    const double collapseMusicViewHeight = 72;

    return Container(
        height: collapseMusicViewHeight, // 72
        width: double.infinity,
        color: const Color(0XFF242424),
        child: Padding(
          padding: const EdgeInsets.only(left: 100, top: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Music Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Artist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              )
            ],
          ),
        ));
  }
}
