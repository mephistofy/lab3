import 'package:flutter/material.dart';
import 'package:login_demo/widgets/navigation_bar.dart';


class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {

  /*void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }*/

  @override
  Widget _main() {
    //final User args = ModalRoute.of(context).settings.arguments;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //_id = (prefs.getString('userId') ?? "");

    return


      Scaffold(
        //appBar: TopBar(),
        body: Column(
          children: [
            //TopBar(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Text("email" + args.email + "!"),
                  //Text("password" + args.avatar),
                  Text("Settings"),
                  //RaisedButton(
                  //onPressed: _handleLogout,
                  //child: Text("Logout"),
                  //)
                ],
              ),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return _wholePage();
  }

  Widget _wholePage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [NavigationBar(), Expanded(child: _main())],
      ),
    );
  }
}