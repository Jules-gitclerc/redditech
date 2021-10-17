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
                return Scaffold(
                    body: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Card(
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(snapshot.data!.avatarUrl),
                                    radius: 60.0,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(snapshot.data!.displayName)),
                                ],
                              ))),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 70,
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Karma'),
                                    Text(snapshot.data!.karma.toString())
                                  ],
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 70,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.money_outlined,
                                      size: 30.0,
                                    ),
                                    Text(snapshot.data!.coins.toString())
                                  ],
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 70,
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.child_friendly,
                                      size: 30.0,
                                    ),
                                    Text(snapshot.data!.numberFriend.toString())
                                  ],
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
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
