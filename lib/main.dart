import 'package:flutter/material.dart';

import 'package:flutter_app/src/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robot',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.yellow,
        highlightColor: Colors.green,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
          headline2: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color(0xFF01579B),
          ),
          bodyText1: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent[700],
          ),
        ),
      ),
      routes: routes,
      initialRoute: 'home',
    );
  }
}
