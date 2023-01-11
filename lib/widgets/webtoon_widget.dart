import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/screens/detail_screen.dart';

class WebtoonWidget extends StatefulWidget {
  final String title;
  final String thumb;
  final String id;

  const WebtoonWidget({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<WebtoonWidget> createState() => _WebtoonWidgetState();
}

class _WebtoonWidgetState extends State<WebtoonWidget> {
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

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: widget.id,
              thumb: widget.thumb,
              title: widget.title,
            ),
          ),
        ).then((value) => setState(() {}));
      },
      child: Column(
        children: [
          Hero(
            tag: widget.id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: isLiked
                    ? Border.all(
                        color: Colors.red,
                        width: 2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.network(widget.thumb),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 22,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
