import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/models/webtoon_detail.dart';
import 'package:toonflix/models/webtoon_episode.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      final toon = WebtoonDetailModel.fromJson(webtoon);
      return toon;
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
    String id,
  ) async {
    List<WebtoonEpisodeModel> webtoonEpisodeInstances = [];
    final url = Uri.parse('$baseUrl/$id/latest');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoonEpisodes = jsonDecode(response.body);
      for (var webtoonEpisode in webtoonEpisodes) {
        final toon = WebtoonEpisodeModel.fromJson(webtoonEpisode);
        webtoonEpisodeInstances.add(toon);
      }
      return webtoonEpisodeInstances;
    }
    throw Error();
  }
}
