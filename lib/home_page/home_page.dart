import 'dart:async';

import 'package:bsflutter/home_page/home/home.dart';
import 'package:bsflutter/home_page/my_profile/my_profile.dart';
import 'package:flutter/material.dart';

typedef MainRouter = void Function(int value);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.switchMainRouter})
      : super(key: key);

  final MainRouter switchMainRouter;

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final Widget _home = const Home();
  final Widget _myProfile = const MyProfile();
  static const timeout = Duration(seconds: 3);
  static const ms = Duration(milliseconds: 1);

  Timer startTimeout([int? milliseconds]) {
    var duration = milliseconds == null
        ? timeout
        : ms * milliseconds; //TODO faire le refresh de token
    return Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    debugPrint("hello cela fait 3 seconds");
  }

  String getNameApp() {
    if (selectedIndex == 0) {
      return "Redditech";
    } else {
      return "Profile";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            getNameApp(),
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              tooltip: 'Disconnect',
              onPressed: () {
                widget.switchMainRouter(0);
              },
            )
          ]),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon((selectedIndex == 0 ? Icons.home : Icons.home_outlined), color: Colors.white),
            title: const Text("Home", style: TextStyle(color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: Icon((selectedIndex == 1 ? Icons.person : Icons.person_outline), color: Colors.white),
            title: const Text("Profile", style: TextStyle(color: Colors.white)),
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _home;
    } else {
      return _myProfile;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
