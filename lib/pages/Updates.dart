import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:fwf/models/Updates.dart';
import 'package:fwf/pages/DetailedUpdate.dart';
import 'package:fwf/widgets/AppBarWidget.dart';
import 'package:fwf/widgets/CircularProgress.dart';
import 'package:http/http.dart' as http;
class UpadatesPage extends StatefulWidget {
  String image;
  UpadatesPage({Key key,
    @required this.image}): super(key: key);
  @override
  _UpadatesPageState createState() => _UpadatesPageState();
}

class _UpadatesPageState extends State<UpadatesPage> {

  List<Updates>mListings = [];

  Future <Updates>getProducts() async {
    setState(() {
      loading = true;
    });
    mListings.clear();
    String urldata ="http://adfifmedia.org/fetch.php?updates=updates";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          mListings.add(Updates.fromJson(i));
          loading = false;
        }
      });
    }
    print(urldata);
    print(mListings.length);

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
        appBar: appBarWidget(context),
        body:ListView(
          children: <Widget>[

            Container(

              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "http://adfifmedia.org/uploads/listings/${widget.image}",
                placeholder: (context, url) => Image.asset(
                  'assets/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),

            Expanded(
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
                        shrinkWrap: true,
                        primary: false,
                        itemCount:snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Updates pro= snapshot.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailedUpdate(
                                      title: pro.title,
                                      date: pro.date,
                                      id: pro.id,
                                      description: pro.description, views: pro.views,
                                    )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              width: double.infinity,
                              height: 110,
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          pro.title,
                                          style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.purple,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(pro.date,
                                                style: TextStyle(
                                                     fontSize: 13, letterSpacing: .3)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                         ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }
            ))
          ],

        )
    );


  }
}

Updates products;

Future<List<Updates>> fetchProducts() async{
  String url ="http://adfifmedia.org/fetch.php?updates=updates";
  final response = await http.get(url);
  return updatesFromJson(response.body);

}