import 'package:eggsincubator/models/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class DashboardActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*  Stack(
        children: <Widget>[
          Image.asset(
            "resources/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
           Scaffold(
    appBar: AppBar(
      title: Text("Dashboard page"),
    ),
    backgroundColor: Colors.transparent,
    body: Container()
 ],
      );
    }

  
     /* Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("Dashboard page"),
      ),
      body: Container(

      ),
     ); */
  }
 */
    return Stack(
      children: <Widget>[
        /* Image.asset(
          'assets/images/dash.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ), */
        Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            /*  bottomNavigationBar: Container(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                height: 44.0 + MediaQuery.of(context).padding.bottom,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.star)),
                    IconButton(icon: Icon(Icons.star)),
                  ],
                ),
              ), */
            body: 
            Container(
              

              child: Column(children: <Widget>[
                        Text(
                          'TEMPERATURE ',
                          style: TextStyle(color: Colors.white, fontSize: 38),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          '37 ',
                           style: TextStyle(color: Colors.white, fontSize: 38),
                          textAlign: TextAlign.end,
                        ),
                        VerticalSpinBoxPage()
              ],) 
               
            )
           
            )
      ],
    );
  }

  
}

class VerticalSpinBoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Container(
                width: 128,
                color: Colors.transparent,
                child: SpinBox(
                  min: -10,
                  max: 50,
                  value: 40,
                  spacing: 24,
                  direction: Axis.vertical,
                  textStyle: TextStyle(fontSize: 37,color: Colors.white),
                  incrementIcon: Icon(Icons.keyboard_arrow_up, size: 37),
                  decrementIcon: Icon(Icons.keyboard_arrow_down, size: 37),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}