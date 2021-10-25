import 'package:bsflutter/home_page/my_profile/request/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bsflutter/home_page/home_page.dart';
import 'package:bsflutter/login/login_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsProfile();
  }
}

class _SettingsProfile extends State<SettingsProfile> {
  late Future<User> futureUser;
  bool isSwitched_1 = false;
  bool isSwitched_2 = true;
  bool isSwitched_3 = true;
  bool isSwitched_4 = true;
  bool isSwitched_5 = true;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

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
      body: Center(
          child: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: SettingsList(
              sections: [
                SettingsSection(
                  title: 'Profile Category',
                  tiles: [
                    SettingsTile.switchTile(
                      title: 'NSFW',
                      leading: const FaIcon(FontAwesomeIcons.eye),
                      switchValue: isSwitched_1,
                      onToggle: (value) {
                        setState(() {
                          isSwitched_1 = value;
                        });
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Advanced',
                  tiles: [
                    SettingsTile.switchTile(
                      title: 'Allow people to follow you',
                      leading: const FaIcon(FontAwesomeIcons.userShield),
                      switchValue: snapshot.data!.acceptFollowers,
                      onToggle: (value) {
                        setState(() {
                          isSwitched_2 = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: 'Content visibility',
                      leading: const FaIcon(FontAwesomeIcons.glasses),
                      switchValue: snapshot.data!.showMedia,
                      onToggle: (value) {
                        setState(() {
                          isSwitched_3 = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: 'Active in communities visibility',
                      leading: const FaIcon(FontAwesomeIcons.universalAccess),
                      switchValue: snapshot.data!.showPresence,
                      onToggle: (value) {
                        setState(() {
                          isSwitched_4 = value;
                        });
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Content preferences',
                  tiles: [
                    SettingsTile.switchTile(
                      title: 'Autoplay media',
                      leading: const FaIcon(FontAwesomeIcons.playCircle),
                      switchValue: snapshot.data!.autoplay,
                      onToggle: (value) {
                        setState(() {
                          isSwitched_5 = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}
