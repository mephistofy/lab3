import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:login_demo/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_demo/widgets/explore_drawer.dart';
import 'package:login_demo/widgets/navigation_bar.dart';

class LogOut extends StatefulWidget {
  LogOut({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LogOut createState() => _LogOut();
}

class _LogOut extends State<LogOut> {

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('avatar');
    prefs.remove('username');
    prefs.remove('password');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget _main() {
    return Scaffold(
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
                  //Text("id" + args.userId),
                  RaisedButton(
                    onPressed: _handleLogout,
                    child: Text("Logout"),
                  )
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