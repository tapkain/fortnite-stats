import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fortnite_stats/model/fortnite_user.dart';
import 'package:fortnite_stats/model/player_data.dart';

class _FortniteHttpClient extends http.BaseClient {
  final String _baseUrl = 'https://fortnite-public-api.theapinetwork.com/prod09/';
  final String _apiKey = <API KEY HERE>;
  final http.Client _inner;

  _FortniteHttpClient(this._inner);

  void _log(http.BaseRequest r) {
    final request = r as http.Request;
    print('${request.method} ${request.url.toString()}');
    print(request.body);
    request.headers.forEach((key, value) {
      print('$key: $value');
    });
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = _apiKey;
    _log(request);
    return _inner.send(request);
  }

  Future<Map<String, dynamic>> apiGet(String query, Map<String, String> body) async {
    final request = http.Request('POST', Uri.parse(_baseUrl + query));
    request.bodyFields = body;
    final response = await send(request);

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return json.decode(body);
    } else {
      throw Exception('Invalid status code - ${response.statusCode}');
    }
  }
}

class ApiClient {
  static final _apiClient = ApiClient._internal();
  final _client = _FortniteHttpClient(http.Client());

  ApiClient._internal();
  factory ApiClient() => _apiClient;

  Future<FortniteUser> fetchUser(String username) async {
    final json = await _client.apiGet('users/id', {'username': username});
    return FortniteUser.fromJson(json);
  }

  Future<PlayerData> fetchPlayerData(
      FortniteUser user,
      FortnitePlatform platform,
      FortniteSeason season) async {
    final json = await _client.apiGet('users/public/br_stats', {
      'user_id': user.uid,
      'platform': platform.toString().split('.').last,
      'season': season.toString().split('.').last
    });
    return PlayerData.fromJson(json);
  }
}