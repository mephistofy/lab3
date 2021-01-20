import 'package:flutter/material.dart';
import 'package:login_demo/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDetailed extends StatefulWidget {
  PostDetailed({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PostDetailed createState() => _PostDetailed();
}

class _PostDetailed extends State<PostDetailed> {
  String post_id;

  void _getPostId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('post_id') ?? "");
    setState(() {
      post_id = id;
    });
  }

  void _clearPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('post_id');
  }

  @override
  void initState() {
    _getPostId();
    super.initState();
  }

  @override
  void dispose() {
    _clearPrefs();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();

  }
}