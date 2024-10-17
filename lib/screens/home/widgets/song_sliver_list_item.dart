import 'package:flutter/material.dart';

class SongSliverListItem extends StatelessWidget {
  const SongSliverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              leading: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  shape: BoxShape.rectangle,
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/default_album_art.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Music Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: const Text(
                'Artist',
                style: TextStyle(color: Colors.white70),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0),
              onTap: () {},
            ),
          );
        },
      ),
    );



    // return ListView.builder(
    //   padding: EdgeInsets.zero,
    //   itemCount: 20,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 4.0),
    //       child: ListTile(
    //         leading: Container(
    //           width: 60.0,
    //           height: 60.0,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(4),
    //             shape: BoxShape.rectangle,
    //             image: const DecorationImage(
    //               image: AssetImage('assets/images/default_album_art.jpg'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         title: const Text(
    //           'Music Title',
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //         subtitle: const Text('Artist', style: TextStyle(color: Colors.white70),),
    //         contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    //         onTap: () {},
    //       ),
    //     );
    //   },
    // );
  }
}
