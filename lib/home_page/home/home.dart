import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final LocalStorage storage = LocalStorage('user');

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(storage.getItem('token')));
  }
}