import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';

class CardPosts extends StatelessWidget {
  const CardPosts({Key? key, required this.data}) : super(key: key);

  final data;

  List<Widget> _getImage(elem) {
    // type 'List<Widget>' is not a subtype of type 'Widget'
    return elem.map<Widget>((i) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image(
        image: NetworkImage(i),
      ),
    )).toList();
  }
  /*(data.listUrlImage.map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: NetworkImage(item),
              ),
            );i.redd.it
          })),*/
  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${data.subredditNamePrefixed} : Published by ${data.author}'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(data.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: (data.selfTextHtml != null
                ? Html(data: unescape.convert(data.selfTextHtml))
                : Text(data.selfText)),
          ),
          ..._getImage(data.listUrlImage),
          Row(
            children: [
              Expanded(
                child:
                    TextButton(onPressed: () {}, child: const Text("comment")),
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
