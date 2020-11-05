
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fwf/controllers/authentications.dart';
import 'package:fwf/pages/LoginPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ProfilePage.dart';
GoogleSignIn googleSign = GoogleSignIn();
Widget appBarWidget(context) {
  return AppBar(
    backgroundColor: Colors.deepPurple,
    elevation: 0.0,
      centerTitle: true,
      title:Text('Forward In Faith'),
    actions: <Widget>[

      IconButton(
        onPressed: ()  async {
            await Future.delayed(Duration(seconds: 2));
            bool isSignedIn = await googleSign.isSignedIn();
            if (isSignedIn) {
              User user = await auth.currentUser;
              print('user signed in');
              // Navigator.pushReplacementNamed(context, '/profile');
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingsOnePage(
                  uid: user.uid, image:user.photoURL,email: user.email, name:user.displayName
              )));
            } else {

              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));

          }
         // Navigator.push(
         //   context,
         //   MaterialPageRoute(builder: (context) =>
         //       SettingsOnePage()
         //   ),
         // );
        },
        icon: Icon(FontAwesomeIcons.user),
        color: Color(0xFFFFFFFF),
      ),
    ],
  );
}
// void
