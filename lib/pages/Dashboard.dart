import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fwf/models/Dashboard.dart';

import 'Bible.dart';
import 'Connect.dart';
import 'EventsPage.dart';
import 'LiveMenu.dart';
import 'PageR.dart';
import 'Teachings.dart';
import 'package:http/http.dart' as http;
import 'Updates.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Dashboard>_Prolist = [];
  bool loading = false;
  Future <Dashboard>getProducts() async {
    setState(() {
      loading = true;
    });
    _Prolist.clear();
    String urldata ="http://adfifmedia.org/fetch.php?dashboard=dashboard";
    // String urldata ="http://adfifmedia.org/fetch.php?images=images&title=Teachings";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _Prolist.add(Dashboard.fromJson(i));
          loading = false;
        }
      });
    }
    print(_Prolist.length);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(title: Text('Dashboard'),),
      body: ListView(
        shrinkWrap: true,
       children:<Widget> [
         Stack(
           children: <Widget>[
             Container(
               alignment: Alignment(0.0,-.4),
               height: 100,
               color: Colors.white,
               child: AutoSizeText(
                 "Forward in Faith International",
                 style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold
                 ),
                 maxFontSize: 30,
               ),
             ),
             Container(
               margin: EdgeInsets.fromLTRB(25, 90, 25, 0),
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20.0),
                   boxShadow: [
                     BoxShadow(
                       blurRadius: 2.0,
                       color: Colors.grey,
                     ),
                   ]
               ),
             ),
           ],
         ),
         SizedBox(height: 40),
         Container(
           padding: EdgeInsets.only(right: 25,left:25),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               AutoSizeText(
                 'Events',
                 style: TextStyle(
                     color: Colors.grey,
                     fontWeight: FontWeight.bold,
                     fontSize: 12.0
                 ),
               ),
               AutoSizeText(
                 'Watch Live',
                 style: TextStyle(
                     color: Colors.orange,
                     fontWeight: FontWeight.bold,
                     fontSize: 12.0
                 ),
               ),
             ],
           ),
         ),
         SizedBox(height: 10),
          GridView.builder(
              // crossAxisCount: 2,
              // gridDelegate: ,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,crossAxisSpacing: 4.0),
              // crossAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              // mainAxisSpacing: 8.0,

                  itemCount: _Prolist.length,
                  itemBuilder: (context, index) {
                    Dashboard choice = _Prolist[index];
                return  InkWell(
                          onTap: () {
                            // Fluttertoast.showToast(msg: "${choice.title}");
                            print(choice.title);

                            if (choice.title=="Watch Live"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  LiveMenu()),
                              );
                            }
                            else if (choice.title=="Bible"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Bible()),
                              );
                            }
                            else if (choice.title=="Connect"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ConnectPage(image: choice.profile,)),
                              );
                            }

                            // if (choice.title=="Apostles Update"){
                            //   print(choice.title);
                            //
                            // }
                            else if (choice.title=="Teachings"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Teachings(image: choice.profile,)),
                              );
                            }
                            else  if (choice.title=="Events"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  EventsPage(image: choice.profile,)),
                              );
                            }
                            else{
                              Fluttertoast.showToast(msg: "${choice.title}");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  UpadatesPage(image: choice.profile,)),
                                );
                            }
                          },
                          child:Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              // color: Colors.orange,
                              child: Center(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                    Expanded(child:CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: "http://adfifmedia.org/uploads/listings/${choice.profile}",
                                      placeholder: (context, url) => Image.asset(
                                        'assets/loading.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    // Image.network("http://adfifmedia.org/uploads/listings/${choice.profile}",
                                    //   height:  20.17,
                                    // ),
                                    ),
                                    AutoSizeText(choice.title, style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 17.0,
                                    ),),
                                    Center(
                                      child: Container(
                                        // width:_width*0.5,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color:
                                            Colors.purple,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )
                                        ),

                                        child: Center(
                                          child:
                                          AutoSizeText(choice.description,
                                            style: TextStyle(color: Colors.white),
                                            maxLines: 1,),

                                        ),
                                      ),
                                    )
                                    // AutoSizeText(choice.msg),
                                  ]
                              ),
                              )
                          )
                                    );
}
                )
              ]
              )

    );

  }


}
