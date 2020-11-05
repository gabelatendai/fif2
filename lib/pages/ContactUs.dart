//import 'dart:html';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  TextEditingController  name=new TextEditingController();
  TextEditingController  email=new TextEditingController();
  TextEditingController  description=new TextEditingController();
  TextEditingController  subject=new TextEditingController();
  TextEditingController  phone=new TextEditingController();

  void addData() async{
    var  url="http://adfifmedia.org/contact_us.php";
    http.post(url,body: {
      "name":name.text,
      "email":email.text,
      "message":description.text,
      "subject":subject.text,
      "phone":phone.text,
    });
    print("name: ${name.text} "+ url);

  }
  sendMail() async {
    String username = 'gabrielmusodza@gmail.com';
    String password = '!@#456&*(gabriel';
    // String domainSmtp = 'mail.domain.com';
// gcarelse@ferrariworld-ad.com
    //also use for gmail smtp
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, email.text)
      ..recipients.add('gabela.musodza33@gmail.com')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = '${subject.text}'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>${subject.text}</h1>\n<p>${description.text}</p>\n<p>${phone.text}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }
  sendToMutambu() async {
    String username = 'gabrielmusodza@gmail.com';
    String password = '!@#456&*(gabriel';
    // String domainSmtp = 'mail.domain.com';
// gcarelse@ferrariworld-ad.com
    //also use for gmail smtp
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, email.text)
      ..recipients.add('amutambu@adfifmedia.org')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = '${subject.text}'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>${subject.text}</h1>\n<p>${description.text}</p>\n<p>${phone.text}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }
  Widget build(BuildContext context) {

    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.close),

                  ),

                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      children:<Widget>[
                        Text(" Leave a Message for us ",
                          style: TextStyle(
                            fontSize: 30.0,
                          ),),
                      ]
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: name,
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
                            hintText: "Full Name",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: email,
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
                            hintText: "Email",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: phone,
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
                      hintText: "Phone Number",

                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(

                    controller: subject,
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
                        Icons.code,
                        color: Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                        color: Color(0xFF666666),
                        fontFamily: defaultFontFamily,
                        fontSize: defaultFontSize,
                      ),
                      hintText: "Subject",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),  TextField(

                    controller: description,
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
                        Icons.code,
                        color: Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                        color: Color(0xFF666666),
                        fontFamily: defaultFontFamily,
                        fontSize: defaultFontSize,
                      ),
                      hintText: "Message",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.all(17.0),
                      onPressed: (){

                        addData();
                        sendMail();
                        sendToMutambu();
                      },
                      child: Text(
                        "Contact Us",
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
                          side: BorderSide(color: Color(0xFFBC1F26))),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
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
                        child: Text('Confirm',
                          style:TextStyle(
                            color: Colors.white,
                          ) ,),
                      ),
                    )
                  ],
                ),
              ),
            )
        );
      }

  );
}

