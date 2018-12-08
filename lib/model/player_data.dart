import 'package:tuple/tuple.dart';

enum PlayerStatsType {
  solo, duo, squad
}

class PlayerStats {
  final int kills;
  final List<Tuple2<int, int>> placetop;
  final int matchesPlayed;
  final int kd;
  final int winrate;
  final int score;
  final int minutesPlayed;
  final int lastmodified;

  PlayerStats({
    this.kills, this.placetop, this.matchesPlayed, this.kd, this.winrate,
    this.score, this.minutesPlayed, this.lastmodified
  });
}

class AllPlayerStats {
  final Map<PlayerStatsType, PlayerStats> playerStats;

  AllPlayerStats({this.playerStats});

  factory AllPlayerStats.fromJson(Map<String, dynamic> json) {
    return AllPlayerStats(
      playerStats: {
        PlayerStatsType.solo: PlayerStats(
          kills: json["killsSolo"],
          placetop: [
            Tuple2(1, json["placetop1Solo"]),
            Tuple2(10, json["placetop10Solo"]),
            Tuple2(25, json["placetop25Solo"]),
          ],
          matchesPlayed: json["matchesPlayedSolo"],
          kd: json["kdSolo"],
          winrate: json["winrateSolo"],
          score: json["scoreSolo"],
          minutesPlayed: json["minutesPlayedSolo"],
          lastmodified: json["lastmodifiedSolo"]
        ),

        PlayerStatsType.duo: PlayerStats(
            kills: json["killsDuo"],
            placetop: [
              Tuple2(1, json["placetop1Duo"]),
              Tuple2(5, json["placetop5Duo"]),
              Tuple2(12, json["placetop12Duo"]),
            ],
            matchesPlayed: json["matchesPlayedDuo"],
            kd: json["kdDuo"],
            winrate: json["winrateDuo"],
            score: json["scoreDuo"],
            minutesPlayed: json["minutesPlayedDuo"],
            lastmodified: json["lastmodifiedDuo"]
        ),

        PlayerStatsType.squad: PlayerStats(
            kills: json["killsSquad"],
            placetop: [
              Tuple2(1, json["placetop1Squad"]),
              Tuple2(3, json["placetop3Squad"]),
              Tuple2(6, json["placetop6Squad"]),
            ],
            matchesPlayed: json["matchesPlayedSquad"],
            kd: json["kdSquad"],
            winrate: json["winrateSquad"],
            score: json["scoreSquad"],
            minutesPlayed: json["minutesPlayedSquad"],
            lastmodified: json["lastmodifiedSquad"]
        ),
      }
    );
  }
}

class PlayerStatsTotal {
  final int kills;
  final int wins;
  final int matchesplayed;
  final int minutesplayed;
  final int hoursplayed;
  final int score;
  final int winrate;
  final int kd;
  final int lastupdate;

  PlayerStatsTotal({
    this.kills, this.wins, this.matchesplayed, this.minutesplayed,
    this.hoursplayed, this.score, this.winrate, this.kd, this.lastupdate
  });

  factory PlayerStatsTotal.fromJson(Map<String, dynamic> json) {
    return PlayerStatsTotal(
      kills: json["kills"],
      wins: json["wins"],
      matchesplayed: json["matchesplayed"],
      minutesplayed: json["minutesplayed"],
      hoursplayed: json["hoursplayed"],
      score: json["score"],
      winrate: json["winrate"],
      kd: json["kd"],
      lastupdate: json["lastupdate"]
    );
  }
}

class PlayerData {
  final String username;
  final String platform;
  final int timestamp;
  final String window;
  final AllPlayerStats stats;
  final PlayerStatsTotal totals;

  PlayerData({
    this.username, this.platform, this.timestamp, this.window,
    this.stats, this.totals
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      username: json["username"],
      platform: json["platform"],
      timestamp: json["timestamp"],
      window: json["window"],
      stats: AllPlayerStats.fromJson(json["stats"]),
      totals: PlayerStatsTotal.fromJson(json["totals"])
    );
  }
}