import 'package:bsflutter/home_page/home/Widget/card_post.dart';
import 'package:bsflutter/home_page/home/request/subreddit_popular.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  State<StatefulWidget> createState() {
    return _Posts();
  }
}

class _Posts extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            title: const Text(
              "Reddicted",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                tooltip: 'Disconnect',
                onPressed: () {},
              )
            ]),
        body: CardPosts(data: widget.data),
    );
  }
}
