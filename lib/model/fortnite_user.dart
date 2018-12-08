class FortniteUser {
  final String uid;
  final String username;
  final List<String> platforms;
  final List<String> seasons;

  FortniteUser({this.uid, this.username, this.platforms, this.seasons});

  factory FortniteUser.fromJson(Map<String, dynamic> json) {
    return FortniteUser(
      uid: json["uid"],
      username: json["username"],
      platforms: json["platforms"],
      seasons: json["seasons"]
    );
  }
}