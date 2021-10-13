import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class User {
  final String displayName;

  User({
    required this.displayName;
  })

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['userId'],
    );
  }
}