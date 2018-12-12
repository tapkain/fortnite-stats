import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/home_tab_bar.dart';

class FortniteApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortnite Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomeTabBar()
    );
  }
}