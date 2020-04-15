import 'package:flutter/material.dart';
import 'package:polladaapp/src/pages/home.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Center(
        child: HomePage(),
      ),
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}