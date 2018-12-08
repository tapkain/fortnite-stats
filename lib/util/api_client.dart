import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fortnite_stats/model/fortnite_user.dart';
import 'package:fortnite_stats/model/player_data.dart';

class _FortniteHttpClient extends http.BaseClient {
  final http.Client _inner;

  _FortniteHttpClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = '<Insert api key here>';
    request.headers['Content-Type'] = 'application/json';
    return _inner.send(request);
  }
}

class ApiClient {
  static final _apiClient = ApiClient._internal();
  final _client = _FortniteHttpClient(http.Client());
  final String _baseUrl = 'https://fortnite-public-api.theapinetwork.com/prod09/';

  ApiClient._internal();
  factory ApiClient() => _apiClient;

  Future<FortniteUser> fetchUser(String username) async {
    final request = http.Request('GET', Uri.parse(_baseUrl + 'users/id'));
    request.bodyFields = {'username': username};
    final response = await _client.send(request);

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return FortniteUser.fromJson(json.decode(body));
    } else {
      throw Exception('Failed to fetch user $username');
    }
  }

  Future<PlayerData> fetchPlayerData(
      FortniteUser user,
      FortnitePlatform platform,
      FortniteSeason season) async {
    final request = http.Request('GET', Uri.parse(_baseUrl + 'users/public/br_stats'));

    request.bodyFields = {
      'user_id': user.uid,
      'platform': platform.toString().split('.').last,
      'season': season.toString().split('.').last
    };

    final response = await _client.send(request);
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return PlayerData.fromJson(json.decode(body));
    } else {
      throw Exception('Failed to fetch player data for ${user.username}');
    }
  }
}