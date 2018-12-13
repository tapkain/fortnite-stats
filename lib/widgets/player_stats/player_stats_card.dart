import 'package:flutter/material.dart';
import 'package:fortnite_stats/model/player_data.dart';

class PlayerStatsCard extends StatelessWidget {
  final PlayerStats _playerStats;

  PlayerStatsCard(this._playerStats);

  ListTile tile(
      dynamic title, String subtitle, String image, TextTheme textTheme) {
    return ListTile(
      title: Text(
        title == 0 ? '--' : '$title',
        style: textTheme.title,
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.subtitle,
      ),
      leading: Image.asset(
        image,
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 75.0 * 6,
      child: Card(
          child: Column(
        children: <Widget>[
          tile(
            _playerStats.kills,
            'Kills',
            'assets/kills.png',
            textTheme,
          ),
          tile(
            _playerStats.matchesPlayed,
            'Matches played',
            'assets/games.png',
            textTheme,
          ),
          tile(
            _playerStats.kd,
            'Kill/Death Ratio',
            'assets/kill_death.png',
            textTheme,
          ),
          tile(
            _playerStats.winrate,
            'Winrate',
            'assets/wins.png',
            textTheme,
          ),
          tile(
            _playerStats.score,
            'Score',
            'assets/score.png',
            textTheme,
          ),
          tile(
            _playerStats.minutesPlayed,
            'Minutes played',
            'assets/time.png',
            textTheme,
          ),
        ],
      )),
    );
  }
}
