import 'package:bsflutter/home_page/home/request/subreddit.dart';
import 'package:flutter/material.dart';

class SubredditPage extends StatefulWidget {
  const SubredditPage({Key? key, required this.idSub}) : super(key: key);

  final idSub;

  @override
  State<StatefulWidget> createState() {
    return _SubredditPage();
  }
}

class _SubredditPage extends State<SubredditPage> {
  late Future<Subreddit> futureSubreddit;
  bool selected = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureSubreddit = fetchSubreddit(widget.idSub);
  }

  Future onSubPressed() async {
    setState(() {
      isLoading = true;
    });


    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            widget.idSub,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white
      ),
      body: Center(
        child: FutureBuilder<Subreddit>(
          future: futureSubreddit,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.grey,
                        child: Image.network(
                          snapshot.data!.urlBanner,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                      Positioned(
                          top: 150 - 60,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey.shade800,
                                backgroundImage: NetworkImage(
                                  snapshot.data!.urlIconImg,
                                )),
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 70,
                  ),
                  Text(
                    snapshot.data!.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.idSub,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      snapshot.data!.description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                      text: TextSpan(
                        text: snapshot.data!.subscribers.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' membres ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                '- ${snapshot.data!.activeAccount.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: ' members ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: isLoading ? 50.0 : 0,
                    color: Colors.transparent,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  (snapshot.data!.isSubscriber
                      ? OutlinedButton(
                          onPressed: () {
                            onSubPressed();
                          },
                          child: Text("Unsubscribe to ${snapshot.data!.name}"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            onSubPressed();
                          },
                          child: Text("Subscribe to ${snapshot.data!.name}"),
                        )
                  ),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    selected = !selected;
                                  });
                                },
                                icon: Icon(!selected
                                    ? Icons.add_comment
                                    : Icons.add_comment_outlined)),
                            Container(
                              color: !selected ? Colors.black : Colors.transparent,
                              height: 2,
                              width: 55,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    selected = !selected;
                                  });
                                },
                                icon: Icon(!selected ? Icons.info_outline : Icons.info)),
                            Container(
                              color: !selected ? Colors.transparent : Colors.black,
                              height: 2,
                              width: 55,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
