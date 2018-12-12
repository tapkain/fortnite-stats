import 'package:flutter/material.dart';
import 'package:fortnite_stats/model/player_data.dart';

class PlayerStatsQuery extends StatelessWidget {
  final PlayerData _playerData;

  PlayerStatsQuery(this._playerData);

  Widget filterRow() {
    return Row(
      children: <Widget>[
        OutlineButton(
          child: Text(_playerData.window),
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          borderSide: BorderSide(color: Colors.amber),
        ),
        SizedBox(width: 16,),
        OutlineButton(
          child: Text('Solo'),
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          borderSide: BorderSide(color: Colors.redAccent),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.favorite),
                SizedBox(width: 16,),
                Text(_playerData.username, style: Theme.of(context).textTheme.display1,),
              ],
            ),
            filterRow()
          ],
        ),
      ),
      )
    );
  }
}