
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fwf/models/Events.dart';
import 'package:fwf/pages/Dashboard.dart';
import 'package:fwf/pages/Page2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fwf/pages/Page3.dart';
import 'package:fwf/pages/Page4.dart';
import 'package:fwf/pages/Page5.dart';
import 'package:fwf/widgets/DrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import 'MyHomePage.dart';
import 'NotificationPage.dart';

class HomePage extends StatefulWidget {
  @override

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs= [
    DashboardScreen(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
  ];
  List<Events>_list = [];

  Future<Events> tyr()async {
    DateTime now = DateTime.now();

    var response= await http.post('http://adfifmedia.org/notifications.php'
        ,body:{'date':'${now.year.toString()}/${now.month.toString()}/${now.day.toString()}'});


    var convert = json.decode(response.body);
   setState(() {
     for (Map i in convert) {
       _list.add(Events.fromJson(i));
     }
   });

  }

  Widget _notification() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(_list.length.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: Icon(Icons.notifications), onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                NotificationPage()));
      }),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tyr();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0.0,
          centerTitle: true,
          title:Text('Forward In Faith'),
          actions: <Widget>[
            _notification(),
            // IconButton(
            //   onPressed: ()  async {
            //     await Future.delayed(Duration(seconds: 2));
            //     bool isSignedIn = await googleSign.isSignedIn();
            //     if (isSignedIn) {
            //       User user = await auth.currentUser;
            //       print('user signed in');
            //       // Navigator.pushReplacementNamed(context, '/profile');
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingsOnePage(
            //           uid: user.uid, image:user.photoURL,email: user.email, name:user.displayName
            //       )));
            //     } else {
            //
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
            //
            //     }
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) =>
            //     //       SettingsOnePage()
            //     //   ),
            //     // );
            //   },
            //   icon: Icon(FontAwesomeIcons.user),
            //   color: Color(0xFFFFFFFF),
            // ),
          ],
        ),
        drawer: DrawerWidget(),
        body: tabs[_currentIndex],

      bottomNavigationBar:  BottomNavigationBar(
          currentIndex :_currentIndex,
          type: BottomNavigationBarType.fixed,
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: AutoSizeText(
                'Home',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.tv),
              title: AutoSizeText(
                'Sermons',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bible,),
              title: AutoSizeText(
                'Bible',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarDay),
              title: AutoSizeText(
                'Events',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ), BottomNavigationBarItem(
              icon:Icon( Icons.info_outline),
              title: AutoSizeText(
                'About',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
          ],
          //currentIndex: _selectedIndex,
          selectedItemColor: Colors.purpleAccent,
          onTap: (index){
            setState(() {
              _currentIndex = index;
              // navigateToScreens(index);
            });

          }

      ),
    );
  }
}
