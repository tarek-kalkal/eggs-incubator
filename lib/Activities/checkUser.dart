import 'dart:ffi';

import 'package:eggsincubator/models/user.dart';
import 'package:eggsincubator/utils/databaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'About.dart';
import 'CommingSoon.dart';
import 'DashboardActivity.dart';
import 'MainActivity.dart';
import 'Settings.dart';
import 'login.page.dart';
import 'newuser.page.dart';

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  dynamic dsv;

  User user;
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/signUp': (BuildContext context) => new NewUser(),
        '/mainActivity': (BuildContext context) => new MainActivity(),
        '/about': (BuildContext context) => new About(),
        '/commingSoon': (BuildContext context) => new CommingSoon(),
        '/dashboard': (BuildContext context) => new DashboardActivity(),
        '/settings': (BuildContext context) => new Settings()
      },
      home:

          /*  Scaffold(
      
        body: Container(
      color: Colors.lightBlue,
      height: MediaQuery.of(context).copyWith().size.height,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Text("welcom to TMM113"),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, right: 40, left: 40, bottom: 5),
            constraints: BoxConstraints.expand(height: 100),
            child: FlatButton(
              padding: EdgeInsets.all(0),
             /*  onPressed: () {
                check();
              }, */
              child: Text(
                'START',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  ),
                ],
                gradient: new LinearGradient(
                    colors: [Colors.white, Colors.grey],
                    begin: const FractionalOffset(1.0, 1.0),
                    end: const FractionalOffset(0.2, 0.2),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(0))),
          )
        ],
      ),
    )

        */
          FutureBuilder(
              future: _getPrefs(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  Future<int> state = _getPrefs();

                  if (state == 0) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                   
                  } else {
                     Navigator.of(context).pushNamedAndRemoveUntil(
                        '/mainActivity', (Route<dynamic> route) => false);
                  }
                  //return MainActivity();
                } else if (snapshot.hasError) {
                  // Manage error
                  print(snapshot.error);
                }

                /// other way there is no user logged.

                //return LoginPage();
                return CircularProgressIndicator();
              }),
    );
  }

  Future<int> _getPrefs() async {
    /*  dsv = await SharedPreferences.getInstance();
    return dsv.getBool('isLoged'); */

    int result = await helper.getCount();
  }

  /* void check() {
    FutureBuilder(
      
      
        future: _getPrefs(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            bool state = dsv.getBool('isLoged');

            if (state == true) {
               
    
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/mainActivity', (Route<dynamic> route) => false);
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }
            //return MainActivity();
          }

          /// other way there is no user logged.
          return CircularProgressIndicator();
        });
  } */
}
