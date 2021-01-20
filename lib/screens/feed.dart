import 'package:flutter/material.dart';
import 'package:login_demo/widgets/navigation_bar.dart';

class Feed extends StatefulWidget {
  Feed({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Feed createState() => _Feed();
}

class _Feed extends State<Feed> {

  @override
  Widget _main() {
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

                  Text("Feed"),

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