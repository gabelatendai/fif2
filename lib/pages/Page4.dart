import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/Events.dart';
import 'package:fwf/pages/DetailedEvent.dart';
import 'package:fwf/widgets/CircularProgress.dart';
import 'package:http/http.dart' as http;
class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  var titleTextStyle = TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  List<Events>_Prolist = [];

  Future <Events>getProducts() async {
    setState(() {
      loading = true;
    });
    _Prolist.clear();
    String urldata ="http://adfifmedia.org/fetch.php?events=events";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _Prolist.add(Events.fromJson(i));
          loading = false;
        }
      });
    }
    print(urldata);
    print(_Prolist.length);

  }
  var loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchProducts();
      getProducts();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: appBarWidget(context),
        body:Container(
            child:   FutureBuilder(
                future: fetchProducts(),
                builder: (context,snapshot){
                  if(snapshot.data==null){
                    return Container(
                      child:  CircularProgress(),
                    );
                    //child: Products(),
                  }else{
                    return  ListView.builder(
                        itemCount:snapshot.data.length,
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (BuildContext context, int index) {
                          Events products= snapshot.data[index];
                          return InkWell(
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  DetailedEvent(
                                  title: products.title,
                                  id: products.id,
                                  enddate: products.enddate,
                                  startdate: products.startdate,
                                  profile: 'http://adfifmedia.org/uploads/listings/${products.profile}',
                                  description: products.description,
                                  views: products.views, date: products.date,
                                )),
                              );
                            },
                            child:  Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage("http://adfifmedia.org/uploads/listings/${products.profile}"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: AutoSizeText(
                                          products.title,
                                          //fifmidubai.online.church
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: <Widget>[
                                            AutoSizeText( products.startdate,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            Spacer(),
                                            AutoSizeText(
                                              'to',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            Spacer(),
                                            AutoSizeText(
                                              products.enddate,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                    ],
                                  ),
//                                  Positioned(
//                                    top: 190,
//                                    left: 20.0,
//                                    child: Container(
//                                      color: Colors.red,
//                                      padding: const EdgeInsets.all(4.0),
//                                      child: AutoSizeText(
//                                        "LIVE",
//                                        style: TextStyle(
//                                          color: Colors.white,
//                                          fontSize: 12.0,
//                                        ),
//                                      ),
//                                    ),
//                                  )
                                ],
                              ),
                            ),
                          );


                        });
                  }
                }
            )
        )
    );


  }
}

Events products;

Future<List<Events>> fetchProducts() async{
  String url ="http://adfifmedia.org/fetch.php?events=events";
  final response = await http.get(url);
  return eventsFromJson(response.body);

}