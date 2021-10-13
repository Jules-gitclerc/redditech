import 'package:bsflutter/home_page/my_profile/request/user.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyProfile();
  }
}

class _MyProfile extends State<MyProfile> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.avatarUrl == null) {
                return Text('${snapshot.error}');
              } else {
                return CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data!.avatarUrl),
                );
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}