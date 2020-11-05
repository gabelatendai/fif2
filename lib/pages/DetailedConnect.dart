import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fwf/models/Events.dart';
import 'package:http/http.dart' as http;



class DetailedConnect extends StatefulWidget {
  String id;
  String title;
  String description;
  String date;
  String views;
  String profile;
  String location;
  String contact;

  DetailedConnect({Key key, @required this.id,@required
this.title,@required
this.description,@required
this.profile,@required
this.location,@required
this.date,@required
this.contact,@required
this.views, }): super(key: key);

  @override
  _DetailedConnectState createState() => _DetailedConnectState();
}

class _DetailedConnectState extends State<DetailedConnect> {
  var loading = false;
  bool isClicked = false;
  bool _validate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     // getProducts();
    });
  }

  static const _headline= TextStyle(
    color:Colors.black,
    fontFamily: "Gotham",
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );static const _headline2= TextStyle(
    color:Colors.red,
    fontFamily: "Gotham",
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );
  @override
  Widget build(BuildContext context) {
    Color selection = Colors.green[400];
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
//                 actions: <Widget>[
//                   GestureDetector(
//                     onTap: () {
// //                      Navigator.push(
// //                        context,
// //                        MaterialPageRoute(
// //                            builder: (context) =>ProfileScreen()),
// //                      );
//                     },
//                     child: Icon(Icons.person_pin,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Stack(
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(
//                           Icons.shopping_basket,
//                         ),
//                         color: Colors.black,
//                         onPressed: () {
// //                          Navigator.push(
// //                            context,
// //                            MaterialPageRoute(
// //                                builder: (context) =>ShoppingCartScreen()),
// //                          );
//                         },
//                       ),
//                       isClicked
//                           ? Positioned(
//                         left: 9,
//                         bottom: 13,
//                         child: Icon(
//                           Icons.looks_one,
//                           size: 14,
//                           color: Colors.red,
//                         ),
//                       )
//                           : AutoSizeText(''),
//                     ],
//                   ),
//                 ],
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height / 2.4,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: AutoSizeText(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("http://adfifmedia.org/uploads/listings/${widget.profile}"),
                            fit: BoxFit.contain),
                      ),
//                  Column(
//                    children: <Widget>[
//                      Image.asset("assets/m1.jpeg")
//                    ],
//                  ),
                    ),
                  ),
                )     ),
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(widget.title),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(width: 130, child: AutoSizeText("Location")),
                      SizedBox(
                        width: 48,
                      ),
                      AutoSizeText(widget.location),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(width: 130, child: AutoSizeText("Contact Details")),
                      SizedBox(
                        width: 48,
                      ),
                      AutoSizeText(widget.contact),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ), //Product Info
                _buildDescription(context),
//                _buildProducts(context),
//                _buildReviewsStat(widget.product.rating)
              ],
            ),
          ),
        ),
      ),
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
            AutoSizeText(
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
            AutoSizeText(widget.description),

          ],
        ),
      ),
    );
  }

}

