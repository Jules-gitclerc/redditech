import 'package:flutter/material.dart';

import 'package:bsflutter/home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _idClientError = false;
  final _controllerClientId = TextEditingController();
  final _controllerClientSecret = TextEditingController();

  String _onTokenGo() {
    if (_controllerClientId.text == "" && _controllerClientSecret.text != "") {
      return 'Error no client id';
    }
    if (_controllerClientId.text != "" && _controllerClientSecret.text == "") {
      return 'Error no client secret';
    }
    if (_controllerClientId.text != "" && _controllerClientSecret.text != "") {
      debugPrint(_controllerClientId.text);
      debugPrint(_controllerClientSecret.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const MyHomePage()));
      return '';
    }
    return 'Error no client id and no client secret';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerClientId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('images/Redditech.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _controllerClientId,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Client id',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _controllerClientSecret,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: Icon(
                      Icons.password_sharp,
                      color: Colors.blue,
                    ),
                    labelText: 'Client secret'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      String returnValue = _onTokenGo();
                      if (returnValue != "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(returnValue)));
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                )),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
