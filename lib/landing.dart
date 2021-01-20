import 'package:flutter/material.dart';
import 'package:login_demo/models/api_response.dart';
import 'package:login_demo/screens/login.dart';
import 'package:login_demo/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/api_error.dart';
import 'models/user.dart';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _id = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = (prefs.getString('userId') ?? "");
    if (_id == "") {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()));
          //'/login', ModalRoute.withName('/login'));
    } else {
      //ApiResponse _apiResponse = await checkUserAuth(_id);
      //if ((_apiResponse.ApiError as ApiError) == null) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()));
            //'/home', ModalRoute.withName('/home'));
            //arguments: (_apiResponse.Data as User));
      //} else {
        //Navigator.pushNamedAndRemoveUntil(
            //context, '/login', ModalRoute.withName('/login'));
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}