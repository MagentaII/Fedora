import 'package:flutter/material.dart';

import '../widgets/home_app_bar.dart';
import '../widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(),
            SizedBox(height: 16),
            Expanded(
              child: HomeBody(),
            ),
          ],
        ),
      ),
    );
  }
}
