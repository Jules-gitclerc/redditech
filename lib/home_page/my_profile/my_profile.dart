import 'package:bsflutter/home_page/my_profile/request/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: buildImage(snapshot.data!.avatarUrl),
                    ),
                    const SizedBox(height: 10),
                    buildName(
                        snapshot.data!.displayName, snapshot.data!.idUser),
                    const SizedBox(height: 40),
                    buildKarmaCoin(
                        snapshot.data!.karma.toString(),
                        snapshot.data!.coins.toString(),
                        MediaQuery.of(context).size.width),
                    const SizedBox(height: 40),
                    Row(children: const [
                      Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )),
                    ]),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 7,
                      margin: const EdgeInsets.all(17.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        snapshot.data!.description,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 20),
                      ),
                    )
                  ],
                ),
              );
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

Widget buildImage(imagePath) {
  final image = NetworkImage(imagePath);

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: const InkWell(),
      ),
    ),
  );
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

Widget buildName(name, userID) => Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          userID,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildKarmaCoin(karma, coins, sizeWidth) => Row(
      children: [
        SizedBox(
          width: sizeWidth / 2,
          child: Column(children: [
            Text(
              karma,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 4),
            const Text(
              "Karma",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ]),
        ),
        SizedBox(
          width: sizeWidth / 2,
          child: Column(children: [
            Text(
              coins,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 4),
            const Text(
              "Coins",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            )
          ]),
        ),
      ],
    );
