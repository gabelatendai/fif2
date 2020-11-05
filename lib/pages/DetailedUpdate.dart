import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fwf/models/Events.dart';

import 'package:http/http.dart' as http;



class DetailedUpdate extends StatefulWidget {
  String id;
  String title;
  String description;
  String date;
  String views;

  DetailedUpdate({Key key, @required this.id,@required
  this.title,@required
  this.description,@required
  this.date,@required
  this.views, }): super(key: key);

  @override
  _DetailedUpdateState createState() => _DetailedUpdateState();
}

class _DetailedUpdateState extends State<DetailedUpdate> {
  var loading = false;
  bool isClicked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // getProducts();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body:Container(
          height: MediaQuery.of(context).size.height,
          child: WebviewScaffold(
            url: 'http://adfifmedia.org/detailedupdate.php?id=${widget.id}',   // Add website here
            mediaPlaybackRequiresUserGesture: false,
            withZoom: true,
          )
        ),

    );
  }
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shopping Cart"),
      content: Text("Your product has been added to cart."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _buildDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height / 3.8,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(widget.description),

          ],
        ),
      ),
    );
  }

}