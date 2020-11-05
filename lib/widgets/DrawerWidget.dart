import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fwf/pages/Dashboard.dart';
import 'package:fwf/pages/ContactUs.dart';
import 'package:fwf/pages/LoginPage.dart';
import 'package:fwf/pages/PageR.dart';
import 'package:fwf/pages/home.dart';
import 'package:fwf/pages/upload.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fwf/controllers/authentications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../ProfilePage.dart';
import 'package:share/share.dart';

GoogleSignIn googleSign = GoogleSignIn();

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = "";
  String msg = 'Please Login';
  String txt = 'Sign In';
  String log = 'Register';
  bool _isLogin = false;
  var loading = false;
  String image = ' assets/pk.png';
  String address = '';
  String id = '';
  String urlshare = 'https://play.google.com/store/apps/details?id=com.forward.fif_ad';
  String mobile = '';
  String _username = '';
  // String newzip ='';
  var data;
  bool isSignedIn = false;
  _checkLogin2() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogin = (pref.get('isLogin') ?? false);
    setState(() {
      _isLogin = isLogin;
    });
    print('prefs $isLogin');
  }

  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogIn") != true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsOnePage()));
    }
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text('${title} ${subtitle ?? 'Not set'}'),
    );
  }

  _reg() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    print('2');
  }

  _out() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);
    print('1');
    _LogOut();
  }

  _setLogOut() async {
    !isSignedIn
        ? _reg()
        : signOutUser().then((value) {
            Navigator.of(context).pop();
            // (Route<dynamic> route) => false);
          });
  }

  Future _LogOut() async {
    signOutUser().then((value) {
      Navigator.of(context).pop();
      // (Route<dynamic> route) => false);
    });
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setBool("isLogIn",false);
    // // _setLogOut();
    // pref.setString("name",null);
    // pref.setString("id",null);
    // pref.setString("email",null);
    // pref.setString("mobile",null);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future _checkUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("email") != null) {
      setState(() {
        name = pref.getString('email');
        msg = " Welcome :";
        txt = " Profile";
        log = "Sign Out";
      });
    }
  }

  _fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("email") != null) {
      String get = pref.getString("email");
      final url = "http://adfifmedia.org/getprofile.php?ID=${get}";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final map = json.decode(response.body);
        final videosMap = map["result"];

        setState(() {
          //_isLoading = true;
          this.data = videosMap;
          _username = data[0]['name'];
          // _email = data[0]['email'];
          address = data[0]['address'];
          id = data[0]['id'];
          // newzip = data[0]['zipcode'];
          mobile = data[0]['mobile'];
          print(data);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin2();
    _checkUser();
    _fetchData();
    checkSignInStatus();
    _initPackageInfo();
  }

  void checkSignInStatus() async {
    await Future.delayed(Duration(seconds: 2));
    isSignedIn = await googleSign.isSignedIn();
    if (isSignedIn) {
      User user = await auth.currentUser;
      print('user signed in');
      print(isSignedIn);

      setState(() {
        image = user.photoURL;
        _username = user.displayName;
        msg = " Welcome :";
        txt = " Profile";
        log = "Sign Out";
      });
      // Navigator.pushReplacementNamed(context, '/profile');
      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingsOnePage(
      //     uid: user.uid, image:user.photoUrl,email: user.email, name:user.displayName
      // )));
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createDrawerHeader(),
                  // settingItem(
                  //   context,
                  //   "Documentation",
                  //       () async {
                  //     launch(DocumentationUrl, forceWebView: true, enableJavaScript: true);
                  //   },
                  //   leading: Image.asset('images/app/ic_documentation.png', height: 24, width: 24, color: primaryColor),
                  // ),
                  _createDrawerItem(
                    icon: Icons.share,
                    text: 'FiF_AD',
                    onTap: () async {
                      await Share.share('Download FIF AD from Play Store\n\n\n$urlshare');
                      // launch(urlshare, forceWebView: true, enableJavaScript: true);
                      // try {
                      //   await WcFlutterShare.share(
                      //       sharePopupTitle: 'Share',
                      //       subject:
                      //           "https://play.google.com/store/apps/details?id=com.forward.fif_ad",
                      //       text:
                      //           "https://play.google.com/store/apps/details?id=com.forward.fif_ad",
                      //       mimeType: 'text/plain');
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                  ),

                  _createDrawerItem(
                      icon: Icons.home,
                      text: 'Home',
                      onTap: () => {
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => HomePage()),
                            )
                          }),
                  _createDrawerItem(
                      icon: Icons.call,
                      text: 'Contact Us',
                      onTap: () => {
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ContactUs()),
                            )
                          }),

                  _createDrawerItem(
                      icon: Icons.info_outline,
                      text: 'About Us',
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PageR()),
                            )
                          }),
                  _createDrawerItem(
                      icon: FontAwesomeIcons.user,
                      text: txt,
                      onTap: () => _checkLogin()),
                  _createDrawerItem(
                    icon: Icons.lock_open,
                    text: log,
                    onTap: () {
                      _setLogOut();
                    },
                  ),
                  // Text('gabriel musodza')
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: _infoTile('Version :', _packageInfo.version),
            ),
            // Text('gabrielmusodza@gmail.com'),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: isSignedIn == false
                  ? Image.asset('assets/img2.png')
                  : Image.network(
                      image,
                      width: 130,
                      height: 130,
                    ),
            ),
          ),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("$msg  $_username",
                  style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Color(0xFF808080),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF484848)),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
