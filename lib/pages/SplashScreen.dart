import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fwf/pages/home.dart';


class SplashScrren extends StatefulWidget {
  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5,
    ), () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage())) ;
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
            child:new Container(
              height:200.0,
              width: 200.0,

                child: new Image(
                    image: new AssetImage('assets/index.png',),height:30.0),

            ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
