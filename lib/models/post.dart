import 'package:flutter/material.dart';

class Post {
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
  String _title;
  String _description;
  String _image;

  // constructorUser(
  User({
    String id,
    String title,
    String description,
    String image,
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._image = image;
  }

// Properties
  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get description=> _description;
  set description(String description) => _description = description;
  String get image => _image;
  set image(String image) => _image = image;


// create the user object from json input
  Post.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
  }

// exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['description'] = this._description;
    data['image'] = this._image;
    return data;
  }
}