import 'package:bsflutter/home_page/home/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';

class CardPosts extends StatelessWidget {
  const CardPosts({Key? key, required this.data}) : super(key: key);

  final data;

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
          padding: const EdgeInsets.all(10.0),
          child: Text(data.selfText)
      );
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
          CircleAvatar(
            backgroundImage: NetworkImage(data.urlAvatarSubreddit),
          ),
          Text('${data.subredditNamePrefixed} : Posted by ${data.author}'),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(data.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          _getSelfText(),
          ..._getImage(data.listUrlImage),
          Row(
            children: [
              Expanded(
                child:
                    TextButton(onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Posts(data: data)));
                    }, child: const Text("comment")),
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
