import 'package:bsflutter/home_page/my_profile/request/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bsflutter/home_page/home_page.dart';
import 'package:bsflutter/login/login_page.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsProfile();
  }
}

class _SettingsProfile extends State<SettingsProfile> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            tooltip: 'Go back',
            onPressed: () {
              Navigator.pop(context);
            },
          )),
    );
  }
}
