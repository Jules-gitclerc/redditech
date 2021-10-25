import 'package:bsflutter/home_page/home/posts.dart';
import 'package:bsflutter/home_page/home/subreddit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';

class CardPosts extends StatelessWidget {
  const CardPosts(
      {Key? key,
      required this.data,
      required this.isDisableComment,
      required this.isDisableSubAction})
      : super(key: key);

  final data;
  final bool isDisableComment;
  final bool isDisableSubAction;

  List<Widget> _getImage(elem) {
    // type 'List<Widget>' is not a subtype of type 'Widget'
    return elem
        .map<Widget>((i) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: NetworkImage(i),
              ),
            ))
        .toList();
  }

  Widget _getSelfText() {
    var unescape = HtmlUnescape();

    if (data.selfTextHtml != null && data.selfTextHtml != "") {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Html(data: unescape.convert(data.selfTextHtml)));
    }
    if (data.selfTextHtml != null && data.selfTextHtml != "") {
      return Padding(
          padding: const EdgeInsets.all(10.0), child: Text(data.selfText));
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  child: (data.urlAvatarSubreddit != null &&
                          data.urlAvatarSubreddit != '')
                      ? Image.network(data.urlAvatarSubreddit)
                      : const Text(
                          "?",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: !isDisableSubAction
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SubredditPage(
                                          idSub: data.subredditNamePrefixed,
                                        )));
                          }
                        : null,
                    child: Text(data.subredditNamePrefixed),
                  ),
                  Text(
                    'Posted by u/${data.author}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(data.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          _getSelfText(),
          ..._getImage(data.listUrlImage),
          Row(
            children: [
              GestureDetector(
                child: Chip(
                  avatar: const Icon(
                    Icons.add_comment_outlined,
                    size: 18,
                  ),
                  label: Text(data.numComments.toString()),
                ),
                onTap: !isDisableComment
                    ? () {
                        //Prints the label of each tapped chip
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Posts(data: data)));
                      }
                    : null,
              ),
              Expanded(
                child: TextButton(onPressed: () {}, child: const Text("like")),
              ),
              Expanded(
                child:
                    TextButton(onPressed: () {}, child: const Text("dislike")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
