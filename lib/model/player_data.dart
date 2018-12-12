import 'package:tuple/tuple.dart';

enum PlayerStatsType {
  solo, duo, squad
}

class PlayerStats {
  final int kills;
  final List<Tuple2<int, int>> placetop;
  final int matchesPlayed;
  final num kd;
  final num winrate;
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
          kills: json["kills_solo"],
          placetop: [
            Tuple2(1, json["placetop1_solo"]),
            Tuple2(10, json["placetop10_solo"]),
            Tuple2(25, json["placetop25_solo"]),
          ],
          matchesPlayed: json["matchesplayed_solo"],
          kd: json["kd_solo"],
          winrate: json["winrate_solo"],
          score: json["score_solo"],
          minutesPlayed: json["minutesplayed_solo"],
          lastmodified: json["lastmodified_solo"]
        ),

        PlayerStatsType.duo: PlayerStats(
            kills: json["kills_duo"],
            placetop: [
              Tuple2(1, json["placetop1_duo"]),
              Tuple2(5, json["placetop5_duo"]),
              Tuple2(12, json["placetop12_duo"]),
            ],
            matchesPlayed: json["matchesplayed_dDuo"],
            kd: json["kd_duo"],
            winrate: json["winrate_duo"],
            score: json["score_duo"],
            minutesPlayed: json["minutesplayed_duo"],
            lastmodified: json["lastmodified_duo"]
        ),

        PlayerStatsType.squad: PlayerStats(
            kills: json["kills_squad"],
            placetop: [
              Tuple2(1, json["placetop1_squad"]),
              Tuple2(3, json["placetop3_squad"]),
              Tuple2(6, json["placetop6_squad"]),
            ],
            matchesPlayed: json["matchesplayed_squad"],
            kd: json["kd_squad"],
            winrate: json["winrate_squad"],
            score: json["score_squad"],
            minutesPlayed: json["minutesplayed_squad"],
            lastmodified: json["lastmodified_squad"]
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
  final num winrate;
  final num kd;
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