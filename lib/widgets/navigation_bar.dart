import 'package:flutter/material.dart';
import 'package:login_demo/routes/routes.dart';
import 'package:login_demo/widgets/navigation_item.dart';

double collapsableHeight = 0.0;
Color selected = Color(0xffffffff);
Color notSelected = Color(0xafffffff);

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int index = 0;

  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return
      Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(top: 79.0),
            duration: Duration(milliseconds: 375),
            curve: Curves.ease,
            height: (width < 800.0) ? collapsableHeight : 0.0,
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NavigationItem(
                    selected: index == 0,
                    title: 'Home',
                    routeName: routeHome,
                    onHighlight: onHighlight,
                  ),

                  SizedBox(height: 20),

                  NavigationItem(
                    selected: index == 1,
                    title: 'Add Post',
                    routeName: routeAddPost,
                    onHighlight: onHighlight,
                  ),

                  SizedBox(height: 20),

                  NavigationItem(
                    selected: index == 2,
                    title: 'Feed',
                    routeName: routeFeed,
                    onHighlight: onHighlight,
                  ),

                  SizedBox(height: 20),

                  NavigationItem(
                    selected: index == 3,
                    title: 'Settings',
                    routeName: routeSettings,
                    onHighlight: onHighlight,
                  ),

                  SizedBox(height: 20),

                  NavigationItem(
                    selected: index == 4,
                    title: 'Log Out',
                    routeName: routeLogOut,
                    onHighlight: onHighlight,
                  ),
                ]
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 80.0,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rubygram',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.red,
                  ),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  if (width < 800.0) {
                    return NavBarButton(
                      onPressed: () {
                        if (collapsableHeight == 0.0) {
                          setState(() {
                            collapsableHeight = 240.0;
                          });
                        } else if (collapsableHeight == 240.0) {
                          setState(() {
                            collapsableHeight = 0.0;
                          });
                        }
                      },
                    );
                  } else {
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            Icon(Icons.insert_emoticon),

                            NavigationItem(
                              selected: index == 0,
                              title: 'Home',
                              routeName: routeHome,
                              onHighlight: onHighlight,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.insert_emoticon),

                            NavigationItem(
                              selected: index == 1,
                              title: 'Add Post',
                              routeName: routeAddPost,
                              onHighlight: onHighlight,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.insert_emoticon),

                            NavigationItem(
                              selected: index == 2,
                              title: 'Feed',
                              routeName: routeFeed,
                              onHighlight: onHighlight,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.insert_emoticon),

                            NavigationItem(
                              selected: index == 3,
                              title: 'Settings',
                              routeName: routeSettings,
                              onHighlight: onHighlight,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.insert_emoticon),

                            NavigationItem(
                              selected: index == 4,
                              title: 'Log Out',
                              routeName: routeLogOut,
                              onHighlight: onHighlight,
                            ),
                          ],
                        ),

                        /*
                        Icon(Icons.insert_emoticon),
                        NavigationItem(
                          selected: index == 0,
                          title: 'Home',
                          routeName: routeHome,
                          onHighlight: onHighlight,
                        ),
                        Icon(Icons.insert_emoticon),
                        NavigationItem(
                          selected: index == 1,
                          title: 'Add Post',
                          routeName: routeAddPost,
                          onHighlight: onHighlight,
                        ),
                        Icon(Icons.insert_emoticon),
                        NavigationItem(
                          selected: index == 2,
                          title: 'Feed',
                          routeName: routeFeed,
                          onHighlight: onHighlight,
                        ),
                        Icon(Icons.insert_emoticon),
                        NavigationItem(
                          selected: index == 3,
                          title: 'Settings',
                          routeName: routeSettings,
                          onHighlight: onHighlight,
                        ),
                        Icon(Icons.insert_emoticon),
                        NavigationItem(
                          selected: index == 4,
                          title: 'Log Out',
                          routeName: routeLogOut,
                          onHighlight: onHighlight,
                        ),*/
                  ],
                    );
                  }
                })
              ],
            ),
          ),
        ],

      );

  }




  void onHighlight(String route) {
    switch (route) {
      case routeHome:
        changeHighlight(0);
        break;
      case routeAddPost:
        changeHighlight(1);
        break;
      case routeFeed:
        changeHighlight(2);
        break;
      case routeSettings:
        changeHighlight(3);
        break;
      case routeLogOut:
        changeHighlight(4);
        break;
    }
  }

  void changeHighlight(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}

class NavBarButton extends StatefulWidget {
  final Function onPressed;

  NavBarButton({
    this.onPressed,
  });

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xcfffffff),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            setState(() {
              widget.onPressed();
            });
          },
          child: Icon(
            Icons.menu,
            size: 30.0,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}