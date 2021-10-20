import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

Future<List<HotPosts>> fetchHotPosts(int limit) async {
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
    return list;
  } else {
    debugPrint('/subreddits/popular?limit=$limit: ${response.statusCode}');
    throw Exception('Failed to load post hot information');
  }
}

class HotPosts {
  final String title;
  final String subreddit;
  final String selfText;
  final String selfTextHtml;
  final String subredditNamePrefixed;
  final String urlSubredditToPost;
  final int numComments;
  final String permalink;
  final String author;
  final List<dynamic> listUrlImage;
  final List<dynamic> listUrlVideo;

  HotPosts({
    required this.title,
    required this.subreddit,
    required this.selfText,
    required this.selfTextHtml,
    required this.subredditNamePrefixed,
    required this.urlSubredditToPost,
    required this.numComments,
    required this.permalink,
    required this.author,
    required this.listUrlImage,
    required this.listUrlVideo,
  });

  factory HotPosts.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    var listUrlImageConstructor = [];
    var listUrlVideoConstructor = [];

    if (data['preview'] != null) {
      data['preview']['images'].forEach(
          (item) => listUrlImageConstructor.add(item['source']['url']));
      data['preview']['videos'].forEach(
          (item) => listUrlVideoConstructor.add(item['source']['url']));
    }

    return HotPosts(
      title: data['title'],
      subreddit: data['subreddit'],
      selfText: data['selftext'],
      selfTextHtml: data['selftext_html'],
      subredditNamePrefixed: data['subreddit_name_prefixed'],
      urlSubredditToPost: data['url'],
      permalink: data['permalink'],
      numComments: data['num_comments'],
      author: data['author'],
      listUrlImage: listUrlImageConstructor,
      listUrlVideo: listUrlVideoConstructor,
    );
  }
}
