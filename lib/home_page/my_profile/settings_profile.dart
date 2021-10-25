import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
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
  bool isLoading = false;
  bool nsfw = false;
  bool acceptFollowers = false;
  bool showPresence = true;
  bool isSwitched_5 = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future loadSettings() async {
    setState(() {
      isLoading = true;
    });
    final LocalStorage storage = LocalStorage('user');
    final response = await get(
        Uri.parse('https://oauth.reddit.com/api/v1/me/prefs'),
        headers: {'authorization': 'Bearer ${storage.getItem('token')}'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        nsfw = data['over_18'];
        acceptFollowers = data['enable_followers'];
        showPresence = data['show_presence'];
      });
    } else {
      debugPrint('/api/v1/me: ${response.statusCode}');
    }
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {

    Future patchSettings() async {
      setState(() {
        isLoading = true;
      });
      final LocalStorage storage = LocalStorage('user');
      var body = jsonEncode({
        'over_18': nsfw,
        'enable_followers': acceptFollowers,
        'show_presence' : showPresence,
      });
      final response = await patch(
          Uri.parse('https://oauth.reddit.com/api/v1/me/prefs'),
          body: body,
          headers: {'authorization': 'Bearer ${storage.getItem('token')}'});

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print('error');
      }
      setState(() {
        isLoading = false;
      });
    }

    if (isLoading) {
      return Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0,
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white),
          body: Center(
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'Profile Category',
              tiles: [
                SettingsTile.switchTile(
                  title: 'NSFW',
                  switchActiveColor: Colors.indigo,
                  leading: const FaIcon(FontAwesomeIcons.eye),
                  switchValue: nsfw,
                  onToggle: (value) {
                    setState(() {
                      nsfw = value;
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
                  switchValue: acceptFollowers,
                  onToggle: (value) {
                    setState(() {
                      acceptFollowers = value;
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Active in communities visibility',
                  switchActiveColor: Colors.indigo,
                  leading: const FaIcon(FontAwesomeIcons.universalAccess),
                  switchValue: showPresence,
                  onToggle: (value) {
                    setState(() {
                      showPresence = value;
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
                  switchValue: isSwitched_5,
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
                  switchValue: isSwitched_5,
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
                  switchValue: isSwitched_5,
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
                  switchValue: isSwitched_5,
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 25, right: 25, top: 5),
        child: ElevatedButton(
          onPressed: () {
            patchSettings();
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
