import 'dart:async' show Timer;
import 'package:banking_app/UI/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: "Quicksand",
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(milliseconds: 2500),
            () =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => HomePage()
                )
            )
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

          color: Colors.white,
          child:Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 300,),
              Center(child: IconButton(icon: Icon(Icons.account_balance), onPressed: null, iconSize: 50,)),
              LoadingFlipping.circle(
                  borderColor: Colors.blueGrey,
                    borderSize: 3.0,
                    size: 90.0,
                    //(backgroundColor: Colors.blueGrey[100])!,
                      duration: Duration(milliseconds: 1000),
                )
            ],
          )
      ),
    );
  }
}