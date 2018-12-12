import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fortnite_stats/model/player_data_model.dart';

class HomeTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(),
        body: ScopedModel(
          model: PlayerDataModel(),
          child: PlayerStatsView(),
        ),
      ),
    );
  }
}
