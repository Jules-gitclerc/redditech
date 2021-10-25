import 'package:bsflutter/home_page/home/Widget/posts_subreddit.dart';
import 'package:bsflutter/home_page/home/request/subreddit.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart';

class SubredditPage extends StatefulWidget {
  const SubredditPage({Key? key, required this.idSub}) : super(key: key);

  final idSub;

  @override
  State<StatefulWidget> createState() {
    return _SubredditPage();
  }
}

class _SubredditPage extends State<SubredditPage> {
  bool selected = false;
  bool isLoading = false;
  bool isSubLoading = false;
  late Subreddit data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    data = await fetchSubreddit(widget.idSub);
    setState(() {
      isLoading = false;
    });
  }

  Future onSubPressed() async {
    final LocalStorage storage = LocalStorage('user');
    setState(() {
      isSubLoading = true;
    });
    final response = await post(
        Uri.parse(
            'https://oauth.reddit.com/api/subscribe?sr_name=${data.name}&action=${data.isSubscriber ? 'unsub' : 'sub'}'),
        headers: {'authorization': 'Bearer ${storage.getItem('token')}'});
    if (response.statusCode == 200) {
      data = await fetchSubreddit(widget.idSub);
    } else {
      print("error: /subscribe?sr_name=${data.name}&action=${data.isSubscriber ? 'unsub' : 'sub'}");
    }
    setState(() {
      isSubLoading = false;
    });
  }

  Widget getTabBody() {
    if (selected == false) {
      return const PostsSubreddit();
    }
    return const Text("a propos");
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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
          )
      );
    }

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
          backgroundColor: Colors.white),
      body: Center(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  color: Colors.grey,
                  child: ((data.urlBanner != null && data.urlBanner != '')
                      ? Image.network(
                          data.urlBanner,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 150,
                        )
                      : Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        )),
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
                            data.urlIconImg,
                          )),
                    ))
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 70,
            ),
            Text(
              data.title,
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
                data.description,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  text: data.subscribers.toString(),
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
                      text: '- ${data.activeAccount.toString()}',
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
              height: isSubLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            (data.isSubscriber
                ? OutlinedButton(
                    onPressed: () {
                      onSubPressed();
                    },
                    child: Text("Unsubscribe to ${data.name}"),
                  )
                : ElevatedButton(
                    onPressed: () {
                      onSubPressed();
                    },
                    child: Text("Subscribe to ${data.name}"),
                  )),
            Container(
              height: 52,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
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
                          icon: Icon(
                              !selected ? Icons.info_outline : Icons.info)),
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
            //getTabBody(),
          ],
        ),
      ),
    );
  }
}
