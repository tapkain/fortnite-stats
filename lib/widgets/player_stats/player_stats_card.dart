import 'package:flutter/material.dart';
import 'package:fortnite_stats/model/player_data.dart';

class PlayerStatsCard extends StatelessWidget {
  final PlayerStats _playerStats;
  final bool renderAsCard;

  PlayerStatsCard(this._playerStats, {this.renderAsCard = true});

  ListTile tile(dynamic title, String subtitle, String image,
      TextTheme textTheme) {
    if (title == null) {
      return null;
    }

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
    final tiles = _buildTiles(context);
    return SizedBox(
      height: 75.0 * tiles.length,
      child: _buildBody(tiles),
    );
  }

  Widget _buildBody(List<Widget> tiles) {
    final body = Column(
      children: tiles,
    );

    if (renderAsCard) {
      return Card(
        child: body,
      );
    }
    return body;
  }

  List<Widget> _buildTiles(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return [
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
        _playerStats.wins,
        'Wins',
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
    ].where((w) => w != null).toList();
  }
}
