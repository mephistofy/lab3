import 'package:flutter/material.dart';
import 'package:login_demo/models/api_response.dart';
import 'package:login_demo/models/api_error.dart';
import 'package:login_demo/service/session_registration_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/rendering.dart';
import 'package:login_demo/models/user.dart';
import 'package:login_demo/screens/home.dart';
import 'package:login_demo/landing.dart';
import 'dart:async';
import 'package:login_demo/routes/routes.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
//import 'dart:html';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {

  ApiResponse _apiResponse;
  String _username;
  String _password;
  String _password_confirmation;
  Uint8List _avatar;

  //final _formKey = GlobalKey<FormState>();
  //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState>  globalFormKey = GlobalKey<FormState>();
  final scaffoldMessengerKey = GlobalKey<ScaffoldState>();

  void _saveAndRedirectToLogin() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString("userID", (_apiResponse.Data as User).id);
    navKey.currentState.pushNamed(routeLogin);
  }

  void _handleSubmitted() async {
    final FormState form = globalFormKey.currentState;

    //if (_password != _password_confirmation){
      //final snackBar = SnackBar(content: Text('Password Confiramtion dismatch!'));
      //scaffoldMessengerKey.currentState.showSnackBar(snackBar);

    //}
    //else{
      if (!form.validate()) {
        final snackBar = SnackBar(content: Text('Please, fulfill all of the fields'));
        scaffoldMessengerKey.currentState.showSnackBar(snackBar);

      } else {
        form.save();

        final snackBar = SnackBar(content: Text('waiting for answer...'));
        scaffoldMessengerKey.currentState.showSnackBar(snackBar);

        _apiResponse = await registerUser(_username, _password, _avatar);
        print(_apiResponse.ApiError as ApiError == null);
        if ((_apiResponse.ApiError as ApiError) == null) {
          Timer(Duration(seconds: 2), () {
            final snackBar = SnackBar(content: Text('Succesfully signed up!'));
            scaffoldMessengerKey.currentState.showSnackBar(snackBar);

            _saveAndRedirectToLogin();
          });

        } else {
          final snackBar = SnackBar(content: Text((_apiResponse.ApiError as ApiError).error));
          scaffoldMessengerKey.currentState.showSnackBar(snackBar);

        }
      }
    //}
  }

  void _handleAvatar() async {
    FilePickerResult resultLocal = await FilePicker.platform.pickFiles();
    if(resultLocal != null) {
      _avatar = resultLocal.files.single.bytes;
      final snackBar = SnackBar(content: Text('Avatar picked'));
      scaffoldMessengerKey.currentState.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Avatar pick canceled'));
      scaffoldMessengerKey.currentState.showSnackBar(snackBar);

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,

      body: Center(
          child: Container(
              width: 448.0,
              height: 348.0,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.red)

              ),
              child: SafeArea(
                top: false,
                bottom: false,
                child: Form(
                  autovalidate: true,
                  key: globalFormKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                key: Key("_username"),
                                decoration: InputDecoration(labelText: "Username/email"),
                                keyboardType: TextInputType.text,
                                onSaved: (String value) {
                                  _username = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Username/email is required';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Password"),
                                obscureText: true,
                                onSaved: (String value) {
                                  _password = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Password confiramtion"),
                                obscureText: true,
                                onSaved: (String value) {
                                  _password_confirmation = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password confirmation is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10.0),
                              ButtonBar(
                                children: <Widget>[
                                  RaisedButton.icon(
                                      onPressed: _handleAvatar,
                                      icon: Icon(Icons.arrow_forward),
                                      label: Text('upload avatar')),
                                ],
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  RaisedButton.icon(

                                      onPressed:  _handleSubmitted,


                                      icon: Icon(Icons.arrow_forward),
                                      label: Text('Sign in')),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ))
      ),
    );

  }
}