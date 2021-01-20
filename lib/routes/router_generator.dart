import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/routes/routes.dart';
import 'package:login_demo/screens/add_post.dart';
import 'package:login_demo/screens/home.dart';
import 'package:login_demo/screens/log_out.dart';
import 'package:login_demo/screens/feed.dart';
import 'package:login_demo/screens/settings.dart';
import 'package:login_demo/screens/login.dart';
import 'package:login_demo/screens/register.dart';
import 'package:login_demo/screens/post_detailed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => MyHomePage());
        break;
      case routeAddPost:
        return MaterialPageRoute(builder: (_) => AddPost());
        break;
      case routeFeed:
        return MaterialPageRoute(builder: (_) => Feed());
        break;
      case routeLogOut:
        return MaterialPageRoute(builder: (_) => LogOut());
        break;
      case routeSettings:
        return MaterialPageRoute(builder: (_) => Settings());
        break;
      case routePostDetailed:
        return MaterialPageRoute(builder: (_) => PostDetailed());
        break;
      case routeRegister:
        return MaterialPageRoute(builder: (_) => Register());
        break;
      case routeLogin:
        return MaterialPageRoute(builder: (_) => Login());
        break;
    }
  }
}


Future <bool> checkAuth(Widget widget) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _id = (prefs.getString('userId') ?? "");
  print(widget);
  if (_id == "") {
    return false;
  }
  else{
    return true;
  }
}