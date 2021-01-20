import 'package:flutter/material.dart';
import 'package:login_demo/models/api_response.dart';
import 'package:login_demo/models/api_error.dart';
import 'package:login_demo/service/session_registration_controller.dart';
import 'package:login_demo/service/posts_controller.dart';
import 'dart:typed_data';
import 'package:login_demo/routes/routes.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:login_demo/widgets/navigation_bar.dart';

class AddPost extends StatefulWidget {
  AddPost({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddPost createState() => _AddPost();
}

class _AddPost extends State<AddPost> {

  ApiResponse _apiResponse;
  String _title;
  String _description;
  Uint8List _image;

  final scaffoldMessengerKey = GlobalKey<ScaffoldState>();

  void _saveAndRedirectToHome() async {
    navKey.currentState.pushNamed(routeHome);
  }

  void _handleSubmitted() async {

    if (_image == null){
      final snackBar = SnackBar(content: Text('You must pick an image to create Post!'));
      scaffoldMessengerKey.currentState.showSnackBar(snackBar);

    }
    else{
      final snackBar = SnackBar(content: Text('waiting for answer...'));
      scaffoldMessengerKey.currentState.showSnackBar(snackBar);

        _apiResponse = await createPost(_title, _description, _image);
        print(_apiResponse.ApiError as ApiError == null);
        if ((_apiResponse.ApiError as ApiError) == null) {
          Timer(Duration(seconds: 2), () {
            final snackBar = SnackBar(content: Text('Succesfully created!'));
            scaffoldMessengerKey.currentState.showSnackBar(snackBar);

            _saveAndRedirectToHome();
          });

        } else {
          final snackBar = SnackBar(content: Text((_apiResponse.ApiError as ApiError).error));
          scaffoldMessengerKey.currentState.showSnackBar(snackBar);

        }
      }

  }

  void _handlePostImage() async {
    FilePickerResult resultLocal = await FilePicker.platform.pickFiles();
    if(resultLocal != null) {
      _image = resultLocal.files.single.bytes;
      final snackBar = SnackBar(content: Text('Image is picked'));
      scaffoldMessengerKey.currentState.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Image pick canceled'));
      scaffoldMessengerKey.currentState.showSnackBar(snackBar);

    }


  }

  Widget _main() {
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

                child: Container(
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
                                key: Key("_title"),
                                decoration: InputDecoration(labelText: "Title of the new post"),
                                keyboardType: TextInputType.text,
                                onSaved: (String value) {
                                  _title = value;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Description of the post"),
                                keyboardType: TextInputType.text,
                                onSaved: (String value) {
                                  _description = value;
                                },
                              ),

                              const SizedBox(height: 10.0),
                              ButtonBar(
                                children: <Widget>[
                                  RaisedButton.icon(
                                      onPressed: _handlePostImage,
                                      icon: Icon(Icons.arrow_forward),
                                      label: Text('upload image')),
                                ],
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  RaisedButton.icon(

                                      onPressed: _handleSubmitted,


                                      icon: Icon(Icons.arrow_forward),
                                      label: Text('Create Post')),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              )
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