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
    return list;//amp;
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
    var listUrlImageConstructorTmp = [];
    var listUrlVideoConstructor = [];
    var listUrlVideoConstructorTmp = [];
    var listGallery = [];
    var galleryData = [];

    if (data['preview'] != null) {
      if (data['preview']['images'] != null) {
        data['preview']['images'].forEach(
            (item) => listUrlImageConstructor.add(item['source']['url']));
        for (var element in listUrlImageConstructor) {
          listUrlImageConstructorTmp.add(element.replaceAll("amp;", ""));
        }
      }
      if (data['preview']['videos'] != null) {
        data['preview']['videos'].forEach(
            (item) => listUrlVideoConstructor.add(item['source']['url']));
        for (var element in listUrlVideoConstructor) {
          listUrlVideoConstructorTmp.add(element.replaceAll("amp;", ""));
        }
      }
    }

    if (data['gallery_data'] != null) {
      if (data['gallery_data']['items'] != null) {
        data['gallery_data']['items'].map((item) => galleryData.add(item.media_id));
      }
    }

    if (galleryData.isNotEmpty) {
      for (var elem in galleryData) {
        var url = data['media_metadata'][elem]['s']['u'];
        listGallery.add(url.replaceAll("amp;", ""));
      }
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
      listUrlImage: listUrlImageConstructorTmp,
      listUrlVideo: listUrlVideoConstructor,
    );
  }
}
