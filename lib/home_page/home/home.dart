import 'package:bsflutter/home_page/home/Widget/card_post.dart';
import 'package:bsflutter/home_page/home/request/subreddit_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:html_unescape/html_unescape.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  late Future<List<HotPosts>> futureHotPosts;

  @override
  void initState() {
    super.initState();
    futureHotPosts = fetchHotPosts(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<HotPosts>>(
          future: futureHotPosts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(3.0),
                itemBuilder: (context, index) {
                  return CardPosts(data: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
