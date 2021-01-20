import 'package:flutter/material.dart';

import 'package:login_demo/routes/router_generator.dart';
import 'package:login_demo/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rubygram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: routeLogin,
      navigatorKey: navKey,
      onGenerateRoute:  RouteGenerator.generateRoute,
    );
  }
}



