# Flutter WebToon

## Flutter 의 fetcher

<https://pub.dev/packages/http>

```bash
flutter pub add http
```

### 사용 방식

```dart
// single request
import 'package:http/http.dart' as http;

var url = Uri.https('example.com', 'whatsit/create');
var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');

print(await http.read(Uri.https('example.com', 'foobar.txt')));

```

```dart
// multiple request
var client = http.Client();
try {
  var response = await client.post(
      Uri.https('example.com', 'whatsit/create'),
      body: {'name': 'doodle', 'color': 'blue'});
  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var uri = Uri.parse(decodedResponse['uri'] as String);
  print(await client.get(uri));
} finally {
  client.close();
}
```

### 요청 재시도

```dart
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

Future<void> main() async {
  final client = RetryClient(http.Client());
  try {
    print(await client.read(Uri.http('example.org', '')));
  } finally {
    client.close();
  }
}
```

## Flutter 의 webView

<https://pub.dev/packages/url_launcher/install>

```bash
flutter pub add url_launcher
```

### 사용 방식

[readme 참조](https://pub.dev/packages/url_launcher)

### 실제 예제

웹뷰가 열린다. 싱기방기

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  const Episode({Key? key, required this.episode, required this.webtoonId})
      : super(key: key);

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    ...
  }
}

```

## Flutter 의 Local storage

<https://pub.dev/packages/shared_preferences/install>

```bash
flutter pub add shared_preferences
```

### 사용방식

```dart
// Obtain shared preferences.
final prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
```

### 실제 사용 예제

screen/detail_screen.dart
저장소에서 가져온 후 state로 관리한다. 리액트랑 비슷한 것 같다.

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/services/app_service.dart';

import '../widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String thumb;
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      prefs.setStringList('likedToons', []);
    }
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');

    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    ...
  }
```
