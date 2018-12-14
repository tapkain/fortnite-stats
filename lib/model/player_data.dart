import 'package:tuple/tuple.dart';

enum PlayerStatsType {
  solo, duo, squad, total
}

class PlayerStats {
  final String username;
  final int kills;
  final List<Tuple2<int, int>> placetop;
  final int matchesPlayed;
  final num kd;
  final num winrate;
  final String wins;
  final int score;
  final int minutesPlayed;
  final int lastmodified;
  final int rank;
  final String platform;

  PlayerStats({
    this.kills, this.placetop, this.matchesPlayed, this.kd, this.winrate,
    this.score, this.minutesPlayed, this.lastmodified, this.username, this.wins,
    this.rank, this.platform
  });
}

class AllPlayerStats {
  final Map<String, PlayerStats> playerStats;

  AllPlayerStats({this.playerStats});

  factory AllPlayerStats.fromJson(Map<String, dynamic> json) {
    final stats = json["stats"];
    final totals = json["totals"];
    return AllPlayerStats(
      playerStats: {
        PlayerStatsType.solo.toString().split('.').last: PlayerStats(
          kills: stats["kills_solo"],
          placetop: [
            Tuple2(1, stats["placetop1_solo"]),
            Tuple2(10, stats["placetop10_solo"]),
            Tuple2(25, stats["placetop25_solo"]),
          ],
          matchesPlayed: stats["matchesplayed_solo"],
          kd: stats["kd_solo"],
          winrate: stats["winrate_solo"],
          score: stats["score_solo"],
          minutesPlayed: stats["minutesplayed_solo"],
          lastmodified: stats["lastmodified_solo"]
        ),

        PlayerStatsType.duo.toString().split('.').last: PlayerStats(
            kills: stats["kills_duo"],
            placetop: [
              Tuple2(1, stats["placetop1_duo"]),
              Tuple2(5, stats["placetop5_duo"]),
              Tuple2(12, stats["placetop12_duo"]),
            ],
            matchesPlayed: stats["matchesplayed_duo"],
            kd: stats["kd_duo"],
            winrate: stats["winrate_duo"],
            score: stats["score_duo"],
            minutesPlayed: stats["minutesplayed_duo"],
            lastmodified: stats["lastmodified_duo"]
        ),

        PlayerStatsType.squad.toString().split('.').last: PlayerStats(
            kills: stats["kills_squad"],
            placetop: [
              Tuple2(1, stats["placetop1_squad"]),
              Tuple2(3, stats["placetop3_squad"]),
              Tuple2(6, stats["placetop6_squad"]),
            ],
            matchesPlayed: stats["matchesplayed_squad"],
            kd: stats["kd_squad"],
            winrate: stats["winrate_squad"],
            score: stats["score_squad"],
            minutesPlayed: stats["minutesplayed_squad"],
            lastmodified: stats["lastmodified_squad"]
        ),

        PlayerStatsType.total.toString().split('.').last: PlayerStats(
            kills: totals["kills"],
            placetop: [],
            matchesPlayed: totals["matchesplayed"],
            kd: totals["kd"],
            winrate: totals["winrate"],
            score: totals["score"],
            minutesPlayed: totals["minutesplayed"],
            lastmodified: totals["lastupdate"]
        ),
      }
    );
  }
}

class PlayerData {
  final String username;
  final String platform;
  final int timestamp;
  final String window;
  final AllPlayerStats stats;

  PlayerData({
    this.username, this.platform, this.timestamp, this.window, this.stats
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      username: json["username"],
      platform: json["platform"],
      timestamp: json["timestamp"],
      window: json["window"],
      stats: AllPlayerStats.fromJson(json)
    );
  }
}