import 'package:flutter/material.dart';

class User {
  /*
  This class encapsulates the json response from the api
  {
      'userId': '1908789',
      'email': 'x7uytx@mundanecode.com'
      'password': '123456'
      'username': username,
      'name': 'Peter Clarke',
      'avatar': "photo",
  }
  */
  String _id;
  String _email;
  String _password;
  String _username;
  String _name;
  String _avatar;
  String _posts;
  String _followers;
  String _following;

  // constructorUser(
  User({
    String id,
    String email,
    String password,
    String username,
    String name,
    String avatar,
    String posts,
    String followers,
    String following,

  }) {
        this._id = id;
        this._email = email;
        this._password = password;
        this._username = username;
        this._name = name;
        this._avatar = avatar;
        this._posts = posts;
        this._followers = followers;
        this._following = following;

}

// Properties
String get id => _id;
set id(String id) => _id = id;
String get username => _username;
set username(String username) => _username = username;
String get name => _name;
set name(String name) => _name = name;
String get avatar => _avatar;
set avatar(String avatar) => _avatar = avatar;
String get email => _email;
set email(String email) => _email = email;
String get password => _password;
set password(String password) => _password = password;
String get posts => _posts;
set posts(String posts) => _posts = posts;
String get followers => _followers;
set followers(String followers) => _followers = followers;
String get following => _following;
set following(String following) => _following = following;
// create the user object from json input
User.fromJson(Map<String, dynamic> json) {
  _id = json['id'].toString();
  _username = json['username'];
  _name = json['name'];
  _avatar = json['avatar'];
  _email = json['email'];
  _password = json['password'];
  _posts = json['posts'].toString();
  _followers = json['followers'].toString();
  _following = json['followings'].toString();
}

// exports to json
Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this._id;
  data['username'] = this._username;
  data['name'] = this._name;
  data['avatar'] = this._avatar;
  data['email'] = this._email;
  data['password'] = this._password;
  data['posts'] = this._posts;
  data['followers'] = this._followers;
  data['followings'] = this._following;
  return data;
}
}