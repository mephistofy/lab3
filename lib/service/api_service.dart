import 'package:shared_preferences/shared_preferences.dart';

Future <Map> getCredits() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = (prefs.getString('email') ?? "");
  String password = (prefs.getString('password') ?? "");
  Map credits = new Map();
  credits['email'] = email;
  credits['password'] = password;
  return credits;
}

Future <String> getCurrentUserId() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = (prefs.getString('userID') ?? "");

  return id;
}