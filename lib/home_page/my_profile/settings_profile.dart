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
  bool isSwitched_2 = false;
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
                        switchActiveColor: Colors.indigo,
                        leading: const FaIcon(FontAwesomeIcons.eye),
                        switchValue: snapshot.data!.nsfw,
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
                        switchActiveColor: Colors.indigo,
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
                        switchActiveColor: Colors.indigo,
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
                        switchActiveColor: Colors.indigo,
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
                        switchActiveColor: Colors.indigo,
                        leading: const FaIcon(FontAwesomeIcons.playCircle),
                        switchValue: snapshot.data!.autoplay,
                        onToggle: (value) {
                          setState(() {
                            isSwitched_5 = value;
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        title: 'Adult content',
                        switchActiveColor: Colors.indigo,
                        leading: const FaIcon(FontAwesomeIcons.male),
                        switchValue: snapshot.data!.autoplay,
                        onToggle: (value) {
                          setState(() {
                            isSwitched_5 = value;
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        title: 'Reduce Animations',
                        switchActiveColor: Colors.indigo,
                        leading: const FaIcon(FontAwesomeIcons.compressAlt),
                        switchValue: snapshot.data!.autoplay,
                        onToggle: (value) {
                          setState(() {
                            isSwitched_5 = value;
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        title: 'Community themes',
                        switchActiveColor: Colors.indigo,
                        leading: const FaIcon(FontAwesomeIcons.mobile),
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
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 25, right: 25, top: 5),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60))),
          ),
          child: const Text('Validate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ),
    );
  }
}
