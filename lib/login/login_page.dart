import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

typedef MainRouter = void Function(int value);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.switchMainRouter}) : super(key: key);

  final MainRouter switchMainRouter;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  static const String clientId = 'SjUvT9xx-DqV9ig65JTCmA';
  static const String clientSecret = 'ra2dL8KdqufMIiPXfRnMnHeVk0NJCw';
  static const String scope = 'identity+read';
  final LocalStorage storage = LocalStorage('user');

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  Future<void> requestToken(String url) async {
    var uri = Uri.parse(url);
    var urlAccess = Uri.parse('https://www.reddit.com/api/v1/access_token');
    String code = '';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));

    uri.queryParameters.forEach((k, v) async {
      if (k == "code") {
        code = v;
        debugPrint('Code for token = $code');
        final response = await post(urlAccess, body: {
          'redirect_uri': 'https://www.google.com',
          'grant_type': 'authorization_code',
          'code': code,
        }, headers: <String, String>{'authorization': basicAuth});
        print(response.statusCode);
        final parsedJson = jsonDecode(response.body);
        print('Token : ${parsedJson['access_token']}');
        storage.setItem('token', parsedJson['access_token']);
        widget.switchMainRouter(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.reddit.com/api/v1/authorize.compact?client_id=$clientId&response_type=code&redirect_uri=https://www.google.com&duration=temporary&scope=$scope&state=code_authorize',
      onProgress: (int progress) {
        debugPrint("WebView is loading (progress : $progress%)");
      },
      onPageFinished: (String url) async {
        await requestToken(url);
      },
    );
  }
}
