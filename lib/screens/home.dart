import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:login_demo/models/user.dart';
import 'package:login_demo/service/posts_controller.dart';
import 'package:login_demo/service/users_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:login_demo/models/api_response.dart';
import 'package:login_demo/models/api_error.dart';
import 'package:login_demo/routes/routes.dart';
import 'package:login_demo/widgets/navigation_bar.dart';

final int limit = 10;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int offset = 0;
  int currentLenght = 0;
  bool isLoading = false;

  ScrollController _sc = new ScrollController();

  final scaffoldMessengerKey = GlobalKey<ScaffoldState>();

  User user;

  List listOfPosts;
  ApiResponse _apiResponsePosts;
  ApiResponse _apiResponseUser;

  @override
  void initState() {
    offset = 0;
    _getUserInfo();
    _loadMore();

    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent){
        _loadMore();
      }
    });


  }

  void _loadMore()async{
    if (!isLoading){
      setState(() {
        isLoading = true;
      });

      _apiResponsePosts = await getAllPosts(limit, offset);

      setState(() {
        isLoading = false;
        if (listOfPosts == null){
          listOfPosts = _apiResponsePosts.Data;
        }
        else {
          listOfPosts.addAll(_apiResponsePosts.Data);
        }

        print(listOfPosts);
        offset += limit;
      });


    }
  }

  Future<User> _getUserInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('userID') ?? "");
    print(id);
    _apiResponseUser =  await getUser(id);

      if ((_apiResponseUser.ApiError as ApiError) != null && _apiResponseUser.Data == null) {
        final snackBar = SnackBar(content: Text((_apiResponseUser.ApiError as ApiError).error));
        scaffoldMessengerKey.currentState.showSnackBar(snackBar);
      }
      var user =  _apiResponseUser.Data;
      return user;
  }

  void _goToPost(int index) async {
    //navKey.currentState.pushNamed(routePostDetailed);
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: LayoutBuilder(builder: (context, constraints) {
              double marginSideContainer;
              if (MediaQuery.of(context).size.width < 1200.0) {
                marginSideContainer = 30.0;
              }
              else{
                marginSideContainer = 200.0;
              }

              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: marginSideContainer),
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      int heightF = 2;
                      if (MediaQuery.of(context).size.width < 1200.0) {
                        return Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: MediaQuery.of(context).size.height -  200,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,

                            child: Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height -  400,
                                      width: 500,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          //borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(color: Colors.red)
                                      ),
                                      child:Image.network(listOfPosts[index].image),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height -  400,
                                        width: 500,
                                        color: Colors.red,
                                      )
                                  )
                                ],
                              ),
                            )
                        );
                      }
                      else {
                        return Container(
                            width: MediaQuery.of(context).size.width - 200,
                            height: MediaQuery.of(context).size.height -  200,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,

                            child:Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height -  200,
                                    width: 500,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        //borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(color: Colors.red)
                                    ),
                                    child:Image.network(listOfPosts[index].image),
                                  ),
                                ),

                                Container(
                                    height: MediaQuery.of(context).size.height -  200,
                                  width: 600,
                                  //color: Colors.red,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(user.avatar),
                                            //child: Image.network(snapshot.data.avatar)
                                          ),
                                          Text(user.username),
                                          /*FutureBuilder<Comment>(
                                              future: _getUserInfo(),
                                              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data.avatar);
                                                  user = snapshot.data;
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      //Expanded(
                                                      //child:Container(),
                                                      //),
                                                      Container(
                                                        margin: EdgeInsets.only(left: 100.0),
                                                        height: 200,
                                                        width: 1,

                                                      ),
                                                      Expanded(
                                                          child:
                                                          CircleAvatar(
                                                            radius: 120,
                                                            backgroundImage: NetworkImage(snapshot.data.avatar),
                                                            //child: Image.network(snapshot.data.avatar)
                                                          )
                                                      ),


                                                      Expanded(
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                          child: Text("Posts: ${snapshot.data.posts}")
                                                      ),
                                                      Expanded(
                                                          child: Text("Followers: ${snapshot.data.followers}")
                                                      ),
                                                      Expanded(
                                                          child: Text("Following: ${snapshot.data.following}")
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(right: 80.0),
                                                      )
                                                    ],
                                                  );
                                                } else {
                                                  return Center(
                                                    child: CircularProgressIndicator(),
                                                  );
                                                }
                                              }

                                          ),*/
                                        ],

                                      )
                                    ],
                                  )

                                )
                              ],
                            ));

                      }
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: marginSideContainer),
                  ),
                ],
              );
            }
            )


          );
        });
  }
  @override
  void dispose(){
    _sc.dispose();
  }

  Widget _subscribeButton() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _futureHeader() {
    return Scaffold(
      //appBar: TopBar(),
        body:
        Center(
          child: FutureBuilder<User>(
              future: _getUserInfo(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.avatar);
                  user = snapshot.data;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Expanded(
                        //child:Container(),
                      //),
                      Container(
                        margin: EdgeInsets.only(left: 100.0),
                        height: 200,
                        width: 1,

                      ),
                    Expanded(
                            child:
                            CircleAvatar(
                                radius: 120,
                                backgroundImage: snapshot.data.avatar != null ? NetworkImage(snapshot.data.avatar) : NetworkImage('https://cdn2.iconfinder.com/data/icons/social-flat-buttons-3/512/anonymous-512.png'),
                                //child: Image.network(snapshot.data.avatar)
                            )
                        ),


                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                          child: Text("Posts: ${snapshot.data.posts}")
                      ),
                      Expanded(
                          child: Text("Followers: ${snapshot.data.followers}")
                      ),
                      Expanded(
                          child: Text("Following: ${snapshot.data.following}")
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 80.0),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }

          ),
        )
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

  Widget _main(){
    return Scaffold(
      body: Center(
        //child: Container(
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height: 210,

                child: _futureHeader(),
              ),
              Container(
                  margin: EdgeInsets.all(40.0),
                  child:GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 40.0,
                        crossAxisCount: 3,
                        mainAxisSpacing: 40.0,
                      ),
                      itemCount: listOfPosts != null ? listOfPosts.length + 1 : 0,
                      itemBuilder: (BuildContext context, int index) {
                        if (listOfPosts == null){
                          return _buildProgressIndicator();
                        }
                        else{
                          if (index == listOfPosts.length ){
                            return _buildProgressIndicator();
                          } else {
                            return Expanded(
                                child:Container(
                                    height: 400,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(color: Colors.red)

                                    ),
                                    child:FlatButton(
                                        onPressed:(){_goToPost(index);},
                                        child:Image.network(listOfPosts[index].image))
                                )

                            );
                            //text here or smth

                          }
                        }
                      }
                  )
              ),


              //_buildList(),
            ],
          )
        //),

      ),
      resizeToAvoidBottomPadding: false,
    );
  }

}