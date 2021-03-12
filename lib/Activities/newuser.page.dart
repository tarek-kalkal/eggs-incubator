import 'package:eggsincubator/models/user.dart';
import 'package:eggsincubator/utils/databaseHelper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:eggsincubator/Activities/MainActivity.dart';
import 'package:eggsincubator/widgets/login/singup.dart';
import 'package:eggsincubator/widgets/login/buttonNewUser.dart';
import 'package:eggsincubator/widgets/login/newEmail.dart';
import 'package:eggsincubator/widgets/login/newName.dart';
import 'package:eggsincubator/widgets/login/password.dart';
import 'package:eggsincubator/widgets/login/textNew.dart';
import 'package:eggsincubator/widgets/login/userOld.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

import 'login.page.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  User user;
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

  


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 10),
                      child: RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            'Sing up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                    ),
                    TextNew(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: emailController,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: 'Phone number',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue[300],
                            blurRadius:
                                10.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          signIn();
                          print("SignUp");
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.lightBlueAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30),
                  child: Container(
                    alignment: Alignment.topRight,
                    //color: Colors.red,
                    height: 20,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Have we met before?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'Sing in',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd:kk:mm').format(now);

    //---------------------------

    final databaseReference = FirebaseDatabase.instance.reference();

    databaseReference
        .child("USERS")
        .child(emailController.text)
        .set({
          "name": nameController.text,
          //"email": emailController.text,
          "password": passwordController.text,
        })
        .then((result) => {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/mainActivity', (Route<dynamic> route) => false),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MainActivity()))
              //taskTitleInputController.clear(),
              //taskDescripInputController.clear(),
            })
        .catchError((err) {
          print(err);
          return;
        });

    /*  Firestore.instance
        .collection('Users')
        .add({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        })
        .then((result) => {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/mainActivity', (Route<dynamic> route) => false),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MainActivity()))
              //taskTitleInputController.clear(),
              //taskDescripInputController.clear(),
            })
        .catchError((err) {
          print(err);
          return;
        }); */

    storeDataLocally(emailController.text);
  }

  void storeDataLocally(String phonenbbr) async {
   /*  SharedPreferences str = await SharedPreferences.getInstance();
    str.setBool('isLoged', true);
    str.setString('key', formattedDate);
    str.setString('name', nameController.text);
    
   // str.setString('email', nameController.text);
    str.setString('password', passwordController.text);
    print('done'); */

    int result;
    if (user.phonenbr != null) {
      // Case 1: Update operation
      result = await helper.updateUser(user);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertUser(user);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Welcome');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Sign In');
    }



  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
