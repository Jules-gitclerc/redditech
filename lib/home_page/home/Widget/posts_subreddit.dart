import 'package:bsflutter/home_page/home/request/hot_posts.dart';
import 'package:flutter/material.dart';

import 'card_post.dart';

class PostsSubreddit extends StatefulWidget {
  const PostsSubreddit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostsSubreddit();
  }
}

class _PostsSubreddit extends State<PostsSubreddit> {
  List<HotPosts> hotPosts = [];
  String after = '';
  String dropdownValue = '/hot';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData(10);
  }

  Future loadData(limit) async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              contentPadding: const EdgeInsets.all(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.search),
                isDense: true,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: '/hot',
                    child: Text("Hot"),
                  ),
                  DropdownMenuItem(
                    value: '/best',
                    child: Text("Best"),
                  ),
                  DropdownMenuItem(
                    value: '/new',
                    child: Text("New"),
                  ),
                  DropdownMenuItem(
                    value: '/random',
                    child: Text("Random"),
                  ),
                  DropdownMenuItem(
                    value: '/rising',
                    child: Text("Rising"),
                  ),
                  DropdownMenuItem(
                    value: '/top',
                    child: Text("Top"),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    after = '';
                    dropdownValue = newValue!;
                    isLoading = true;
                  });
                  hotPosts.removeAt(0);
                  loadData(5);
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: hotPosts.length,
                itemBuilder: (context, index) {
                  return CardPosts(
                      data: hotPosts[index],
                      isDisableComment: false,
                      isDisableSubAction: true);
                },
              ),
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  loadData(10);
                  setState(() {
                    isLoading = true;
                  });
                }
                return true;
              }),
        ),
        Container(
          height: isLoading ? 50.0 : 0,
          color: Colors.transparent,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
