import 'player_data.dart';

enum FortniteTop10Queries {
  kills, wins, score, minutes
}

class FortniteTop10 {
  List<PlayerStats> players;

  FortniteTop10({this.players});

  factory FortniteTop10.fromJson(Map<String, dynamic> json) {
    final items = json['entries'] as List;
    return FortniteTop10(
      players: items.map((item) {
        return PlayerStats(
          username: item['username'],
          kills: int.parse(item['kills']),
          wins: item['wins'],
          matchesPlayed: int.parse(item['matches']),
          minutesPlayed: int.parse(item['minutes']),
          score: int.parse(item['score']),
          kd: num.parse(item['kd']),
          platform: item['platform'],
          rank: item['rank'],
        );
      }).toList(),
    );
  }
}
