class HotPosts {
  final String title;
  final String subreddit;
  final String selfText;
  final String selfTextHtml;
  final String subredditNamePrefixed;
  final String urlSubredditToPost;
  final int numComments;
  final String permalink;
  final String author;
  late final String urlAvatarSubreddit;
  final List<dynamic> listUrlImage;
  final List<dynamic> listUrlVideo;

  HotPosts({
    required this.title,
    required this.subreddit,
    required this.selfText,
    required this.selfTextHtml,
    required this.subredditNamePrefixed,
    required this.urlSubredditToPost,
    required this.numComments,
    required this.permalink,
    required this.author,
    required this.listUrlImage,
    required this.listUrlVideo,
    required this.urlAvatarSubreddit,
  });

  factory HotPosts.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    var listUrlImageConstructor = [];
    var listUrlImageConstructorTmp = [];
    var listUrlVideoConstructor = [];
    var listUrlVideoConstructorTmp = [];
    var listGallery = [];
    var galleryData = [];
    var urlLogoSub = '';

    if (data['preview'] != null) {
      if (data['preview']['images'] != null) {
        data['preview']['images'].forEach(
            (item) => listUrlImageConstructor.add(item['source']['url']));
        for (var element in listUrlImageConstructor) {
          listUrlImageConstructorTmp.add(element.replaceAll("amp;", ""));
        }
      }
      if (data['preview']['videos'] != null) {
        data['preview']['videos'].forEach(
            (item) => listUrlVideoConstructor.add(item['source']['url']));
        for (var element in listUrlVideoConstructor) {
          listUrlVideoConstructorTmp.add(element.replaceAll("amp;", ""));
        }
      }
    }

    if (data['gallery_data'] != null) {
      if (data['gallery_data']['items'] != null) {
        data['gallery_data']['items'].map((item) => galleryData.add(item.media_id));
      }
    }

    if (galleryData.isNotEmpty) {
      for (var elem in galleryData) {
        var url = data['media_metadata'][elem]['s']['u'];
        listGallery.add(url.replaceAll("amp;", ""));
      }
    }

    if (data['sr_detail'] != null) {
      urlLogoSub = data['sr_detail']['icon_img'];
    }

    return HotPosts(
      title: data['title'],
      subreddit: data['subreddit'],
      selfText: data['selftext'],
      selfTextHtml: data['selftext_html'],
      subredditNamePrefixed: data['subreddit_name_prefixed'],
      urlSubredditToPost: data['url'],
      permalink: data['permalink'],
      numComments: data['num_comments'],
      author: data['author'],
      listUrlImage: listUrlImageConstructorTmp,
      listUrlVideo: listUrlVideoConstructor,
      urlAvatarSubreddit: urlLogoSub,
    );
  }
}
