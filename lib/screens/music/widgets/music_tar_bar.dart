import 'dart:developer';

import 'package:flutter/material.dart';

class MusicTarBar extends StatefulWidget {
  final double bottomSheetHeight;
  final VoidCallback onTap;

  const MusicTarBar({
    super.key,
    required this.bottomSheetHeight,
    required this.onTap,
  });

  @override
  State<MusicTarBar> createState() => _MusicTarBarState();
}

class _MusicTarBarState extends State<MusicTarBar>
    with SingleTickerProviderStateMixin {
  // Refers to the bottom sheet when the Music view is expanded.
  static const double minimumBottomSheetHeight = 96;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 48,
          // color: Colors.deepOrange,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor:
            widget.bottomSheetHeight <= minimumBottomSheetHeight
                ? Colors.white
                : Colors.white70,
            unselectedLabelStyle: TextStyle(
                fontWeight: widget.bottomSheetHeight <=
                    minimumBottomSheetHeight
                    ? FontWeight.bold
                    : FontWeight.w500),
            indicatorColor: Colors.white,
            indicator: widget.bottomSheetHeight <= minimumBottomSheetHeight
                ? const BoxDecoration()
                : null,
            dividerColor: widget.bottomSheetHeight <= minimumBottomSheetHeight
                ? Colors.transparent
                : null,
            tabs: [
              Tab(
                child: SizedBox(
                  width: screenWidth / 3,
                  child: const Center(
                    child: Text(
                      'UP NEXT',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: screenWidth / 3,
                  child: const Center(
                    child: Text(
                      'LYRICS',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: screenWidth / 3,
                  child: const Center(
                    child: Text(
                      'RELATED',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
            onTap: (_) {
              log('onTap');
              widget.onTap();
            },
          ),
        ),
        Transform.translate(
          offset: const Offset(0, 48),
          child: Container(
            width: double.infinity,
            // color: Colors.teal,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Center(
                  child: Text(
                    'Up Next - Content will go here',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Lyrics - Content will go here',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Related - Content will go here',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
