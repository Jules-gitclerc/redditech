import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

Future<User> fetchUser() async {
  final LocalStorage storage = LocalStorage('user');
  final response = await get(Uri.parse('https://oauth.reddit.com/api/v1/me'), headers: {'authorization': 'Bearer ${storage.getItem('token')}'});

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('/api/v1/me: ${response.statusCode}');
    throw Exception('Failed to load user information');
  }
}

class User {
  final String displayName;
  final String avatarUrl;

  User({
    required this.displayName,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['name'],
      avatarUrl: json['icon_img'],
    );
  }
}