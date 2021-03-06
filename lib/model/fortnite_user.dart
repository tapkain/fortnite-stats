enum FortnitePlatform { pc, xb1, ps4 }
enum FortniteGameType { savetheworld, battleroyale }
enum FortniteSeason { alltime, season4, season5, season6, season7, current }

class FortniteUser {
  final String uid;
  final String username;
  final List<String> platforms;
  final List<String> seasons;

  FortniteUser({this.uid, this.username, this.platforms, this.seasons});

  factory FortniteUser.fromJson(Map<String, dynamic> json) {
    return FortniteUser(
      uid: json['uid'],
      username: json['username'],
      platforms: new List<String>.from(json['platforms']),
      seasons: new List<String>.from(json['seasons']),
    );
  }
}
