import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fwf/controllers/authentications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ProfilePage.dart';
import 'dialogs.dart';
import 'home.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool signin = true;

  TextEditingController namectrl,emailctrl,passctrl,mobilectrl,addressctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    mobilectrl = new TextEditingController();
    addressctrl = new TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        centerTitle: true,
        title:AutoSizeText('Forward In Faith'),
//      Image.asset(
//      "assets/index.png",
//      width: 80,
//      height: 40,
//    ),
//     iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    HomePage()
                ),
              );
            },
            icon: Icon(FontAwesomeIcons.windowClose),
            color: Color(0xFFFFFFFF),
          ),
        ],
      ),
        body: ListView(
          children: <Widget>[
            Icon(Icons.account_circle,size: 200,color: Colors.purpleAccent,),

            boxUi(),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => googleSignIn().whenComplete(() async {
                FirebaseUser user = await FirebaseAuth.instance.currentUser;

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SettingsOnePage(uid: user.uid, image:user.photoUrl,email: user.email, name:user.displayName)));
              }),
              child: Image(
                image: AssetImage('assets/signin.png',
                ),
                width: 200.0,
              ),
            ),

          ],
        )
         );
  }

  void changeState(){
    if(signin){
      setState(() {
        signin = false;

      });
    }else
      setState(() {
        signin = true;

      });
  }
  void registerUser() async{

    setState(() {
      processing = true;
    });
    var url = "http://adfifmedia.org/registration.php";
    var data = {
      "email":emailctrl.text,
      "name":namectrl.text,
      "pass":passctrl.text,
      "address":addressctrl.text,
      "mobile":mobilectrl.text,
    };

    final res = await http.post(url,body:data);
    // final res = await http.get(url);
    if(jsonDecode(res.body) == "account already exists"){
      Fluttertoast.showToast(msg: "account exists, Please login",toastLength: Toast.LENGTH_SHORT);
      showDialog(context: context, builder: (_) => feedBackCode2());
    }else{

      if(jsonDecode(res.body) == "true"){
        Fluttertoast.showToast(msg: "account created",toastLength: Toast.LENGTH_SHORT);
        showDialog(context: context, builder: (_) => feedBackCode());
      }else{
        Fluttertoast.showToast(msg: "error",toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
  }

  void userSignIn() async{
    setState(() {
      processing = true;
    });
    var url = "http://adfifmedia.org/login.php";
    var data = {
      "email":emailctrl.text,
      "pass":passctrl.text,
    };

    var res = await http.post(url,body:data);

    // if(jsonDecode(res.body) == "dont have an account"){
    //   Fluttertoast.showToast(msg: "dont have an account,Create an account",toastLength: Toast.LENGTH_SHORT);
    //   _customAlertDialog(context, AlertDialogType.WARNING );
    // }
    // else{
      if(jsonDecode(res.body) == "false"){
        Fluttertoast.showToast(msg: "incorrect password",toastLength: Toast.LENGTH_SHORT);
        incorrect(context, AlertDialogType.WARNING );
      }
      else{
       // print(jsonDecode(res.body)=="true");
       Navigator.of(context).pop();
        // var datauser = json.decode(res.body);
        SharedPreferences pref = await SharedPreferences.getInstance();
        // pref.setBool("isLogIn", true);
        _setIsLogin();
        await pref.setString('email', emailctrl.value.text);
        // await pref.setString('id', datauser[0]["id"]);
        // await pref.setString('name', datauser[0]["name"]);
        print(emailctrl.value.text);
      }
    // }

    setState(() {
      processing = false;
    });
  }
  _setIsLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLogin', true);
  }
  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed:() => changeState(),
                  child: AutoSizeText('SIGN IN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.purple : Colors.grey,
                      fontSize: 25.0,fontWeight: FontWeight.bold,
                    ),),
                ),

                FlatButton(
                  onPressed:() => changeState(),
                  child: AutoSizeText('SIGN UP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.purple : Colors.grey,
                      fontSize: 25.0,fontWeight: FontWeight.bold,
                    ),),
                ),
              ],
            ),

            signin == true ? signInUi() : signUpUi(),
          ],
        ),
      ),
    );
  }

  Widget signInUi(){
    return Column(
      children: <Widget>[

        TextField(
          controller: emailctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
              hintText: 'email'),
        ),


        TextField(
          controller: passctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
              hintText: 'password'),
        ),

        SizedBox(height: 10.0,),

        MaterialButton(
            onPressed:() => userSignIn(),
            child: processing == false ? AutoSizeText('Sign In',
              style: GoogleFonts.varelaRound(fontSize: 18.0,
                  color: Colors.purple),) : CircularProgressIndicator(backgroundColor: Colors.red,)
        ),

      ],
    );
  }

  Widget signUpUi(){
    return Column(
      children: <Widget>[

        TextField(
          controller: namectrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
              hintText: 'name'),
        ),

        TextField(
          controller: emailctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
              hintText: 'email'),
        ),

        TextField(
          controller: passctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
              hintText: 'password'),
        ),
        TextField(
          controller: mobilectrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.call,),
              hintText: 'Phone Number'),
        ),
        TextField(
          controller: addressctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.map,),
              hintText: 'Address'),
        ),


        SizedBox(height: 10.0,),

        MaterialButton(
            onPressed:() => registerUser(),
            child: processing == false ? AutoSizeText('Sign Up',
              style: GoogleFonts.varelaRound(fontSize: 18.0,
                  color: Colors.purple),) : CircularProgressIndicator(backgroundColor: Colors.red)
        ),

      ],
    );
  }

// now we will setup php and database
//thank you
}
class feedBackCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Container(
          color: Colors.purple,
          padding: EdgeInsets.all(50),
          width: width * 0.90,
          height: height * 0.7,
          child: Column(
            children: <Widget>[
              Container(
                  height: height * 0.15,
                  child: Image.asset('assets/cc.png')),
              SizedBox(
                height: height * 0.02,
              ),
              AutoSizeText(
                'Registration was successful !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, fontFamily: 'Cabin', color: Colors.white),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              AutoSizeText(
                "We're glad you're here! Before you start exploring we just send you email confirmation."
                    "Click on the Link to confirm your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontFamily: 'OpenSans', color: Colors.white),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.08,
                width: width * 0.8,
                decoration: BoxDecoration(
                  // color: Color.fromARGB(110, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff17202A),
                      ),
                      child: AutoSizeText(
                        "Got it",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      print('object');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class feedBackCode2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Container(
          color: Colors.purple,
          padding: EdgeInsets.all(50),
          width: width * 0.90,
          height: height * 0.7,
          child: Column(
            children: <Widget>[
              Container(
                  height: height * 0.15,
                  child: Image.asset('assets/cc.png')),
              SizedBox(
                height: height * 0.02,
              ),
              AutoSizeText(
                'Error !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, fontFamily: 'Cabin', color: Colors.white),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              AutoSizeText(
                "Account is registered with another user",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontFamily: 'OpenSans', color: Colors.white),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.08,
                width: width * 0.8,
                decoration: BoxDecoration(
                  // color: Color.fromARGB(110, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff17202A),
                      ),
                      child: AutoSizeText(
                        "Got it",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      print('object');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_customAlertDialog(BuildContext context, AlertDialogType type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        type: type,
        title: "Account Does not Exists",
        content: "Account Does not Exists: ",
      );
    },
  );
}
incorrect(BuildContext context, AlertDialogType type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        type: type,
        title: "incorrect Password",
        content: "incorrect Password: ",
      );
    },
  );
}