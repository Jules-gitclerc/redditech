import 'package:bsflutter/home_page/home/Widget/card_post.dart';
import 'package:bsflutter/home_page/home/request/subreddit_popular.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  List<HotPosts> hotPosts = [];
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    loadDataPosts(10);
  }

  Future loadDataPosts(limit) async {
    final LocalStorage storage = LocalStorage('user');
    final response = await get(
        Uri.parse('https://oauth.reddit.com/hot?limit=$limit&g=GLOBAL'),
        headers: {'authorization': 'Bearer ${storage.getItem('token')}'});
    List<HotPosts> list;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rest = data['data'];
      var deep = rest['children'] as List;

      list = deep.map<HotPosts>((json) => HotPosts.fromJson(json)).toList();
      setState(() {
        isLoading = false;
        hotPosts.addAll(list);
      });
      return; //amp;
    } else {
      debugPrint('/subreddits/popular?limit=$limit: ${response.statusCode}');
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: NotificationListener<ScrollNotification>(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: hotPosts.length,
                  itemBuilder: (context, index) {
                    return CardPosts(data: hotPosts[index]);
                  },
                ),
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    loadDataPosts(10);
                    setState(() {
                      isLoading = true;
                    });
                  }
                  return true;
                }),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
