import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fwf/models/Events.dart';

import 'package:http/http.dart' as http;


class DetailedEvent extends StatefulWidget {
  String id;
  String title;
  String enddate;
  String startdate;
  String description;
  String date;
  String profile;
  String views;

  DetailedEvent({Key key, @required this.id,@required
this.title,@required
this.enddate,@required
this.startdate,@required
this.description,@required
this.date,@required
this.profile,@required
this.views, }): super(key: key);

  @override
  _DetailedEventState createState() => _DetailedEventState();
}

class _DetailedEventState extends State<DetailedEvent> {
  var loading = false;
  bool isClicked = false;
  bool _validate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
    //  getProducts();
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
                        image: DecorationImage(image: NetworkImage("${widget.profile}"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Center(child: AutoSizeText(widget.title)),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(width: 130, child: AutoSizeText("Event Start Date")),
                      SizedBox(
                        width: 48,
                      ),
                      AutoSizeText(widget.startdate.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(width: 130, child: AutoSizeText("Event End Date")),
                      AutoSizeText(widget.enddate.toString()),
                    ],
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
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: AutoSizeText("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: AutoSizeText("Shopping Cart"),
      content: AutoSizeText("Your product has been added to cart."),
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



//  dottedSlider() {
//    return DottedSlider(
//      maxHeight: 200,
//      children: <Widget>[
//        _productSlideImage(widget.product.image),
//      ],
//    );
//  }

//  _buildInfo(context) {
//    return Container(
//      width: MediaQuery.of(context).size.width,
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Container(width: 130, child: AutoSizeText("Product Type")),
//                SizedBox(
//                  width: 48,
//                ),
//                AutoSizeText(widget.title),
//              ],
//            ),
//            SizedBox(
//              height: 8,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Container(width: 130, child: AutoSizeText("Available sizes")),
//                SizedBox(
//                  width: 48,
//                ),
//                AutoSizeText(widget.startdate.toString()),
//              ],
//            ),
//            SizedBox(
//              height: 8,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Container(width: 130, child: AutoSizeText("Available Colors")),
//                AutoSizeText(widget.enddate.toString()),
//              ],
//            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 12.0),
//              child: AutoSizeText(widget.title,
//                style: TextStyle(color: Colors.black45),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }



  _buildDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
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

