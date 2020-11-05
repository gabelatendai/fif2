import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  var idUser;
  UpdateProfile({Key key, this.idUser}) : super(key: key);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String address ='';
  String id ='';
  String mobile ='';
  // String newzip ='';
  var data;
  var _username = "";
  var _email = "";
@override
  void initState() {
    // TODO: implement initState
    super.initState();
// getData();
    _fetchData();
    print(widget.idUser);
  }
  @override
    TextEditingController  _controllername=new TextEditingController();
    TextEditingController  _controlleremail=new TextEditingController();
    TextEditingController  _controllermoblie=new TextEditingController();
  TextEditingController  _controlleraddress=new TextEditingController();
    // TextEditingController  _controllerzipcode=new TextEditingController();
  Future<String> _ShowDialog(String msg) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new AutoSizeText('Profile Updated'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new AutoSizeText(msg),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new AutoSizeText('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    void _upadate() async{
      var mail = _controlleremail.text;
      var namew = _controllername.text;
      var addreess = _controlleraddress.text;
      var phone = _controllermoblie.text;
      // var zpp = _controllerzipcode.text;
      // var city  = _citiesVal;
      if (mail==""){
        mail=_email;
      }
      if (namew==""){
        namew=_username;
      }
      if (addreess==""){
        addreess=address;
      }
      if (phone==""){
        phone=mobile;
      }
//      print('city');
      var url="http://adfifmedia.org/updateProfile.php";
      var response = await http.post(url, body: {
        "idu":id,
        "name":namew,
        "email":mail,
        // "location":city,
        "phone":phone,
        "address":addreess,
        // "zip":zpp,
      });
      if (response.statusCode == 200) {
        _ShowDialog("Updated Successfully");
        _LogOut();
      } else {
        _ShowDialog("Updated Failure");
      }
    }

  Future _LogOut() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', false);
    pref.setBool("isLogIn",false);
    pref.setString("name",null);
    pref.setString("id",null);
    pref.setString("email",null);
    pref.setString("mobile",null);
    // pref.setString("city",null);
    pref.setString("address",null);
  }


  var loading = false;

  _fetchData() async {
    final url =
        "http://adfifmedia.org/getprofile.php?ID=${widget.idUser}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videosMap = map["result"];

      setState(() {
        //_isLoading = true;
        this.data = videosMap;
        _username = data[0]['name'];
        _email = data[0]['email'];
        address = data[0]['address'];
        id = data[0]['id'];
        // newzip = data[0]['zipcode'];
        mobile = data[0]['mobile'];
        print(data);
      });
    }
  }
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText('Update Profile'),
    elevation: 2.0,
    centerTitle: true,

        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );
            },
        icon: Icon(Icons.close),
            color: Color(0xFF323232),
          ),
        ],
      ),
     resizeToAvoidBottomInset: false,
      body:  ListView(
          children: <Widget>[
            Image.asset('assets/index.png',height: 200.0,width: 200,),

            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: _controllername,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                            ),
                            hintText: _username,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: _controlleremail,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                            ),
                            hintText:_email,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _controllermoblie,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize),
                      hintText: mobile,

                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _controlleraddress,
//                   onChanged: (value){
//                     this.phoneNo=value;
//                   },
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.add_location,
                        color: Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize),
                      hintText: address,

                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.all(17.0),
                      onPressed: (){
//                        showDialog(context: context
//                          ,builder:(context) =>CustomDialog(
//                            title: 'Success',
//                            descrption: 'Please verify your email send to your '
//                                'Please verify your email send to your Please '
//                                'verify your email send to your',
//                          ),
//                        );
                      print(id);
                        _upadate();
                        },
                      child: AutoSizeText(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins-Medium.ttf',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.purple)),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),

              ]
        ),


        );
  }
}
Future<bool> smsCodeDialog(BuildContext context){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return  Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Container(
        height: 200,
          child: Padding(
            padding:  EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Please verify your email send to your used to register"
                  ),
                ),
                SizedBox(
                  width: 320.0,
                  child: RaisedButton(
                    onPressed: (){

                    },
                    child: AutoSizeText('Confirm',
                    style:TextStyle(
                      color: Colors.white,
                    ) ,),
                  ),
                )
              ],
            ),
          ),)


        );
      }

  );
}
