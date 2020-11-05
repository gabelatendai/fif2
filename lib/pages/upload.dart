import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:fwf/models/Updates.dart';
import 'package:fwf/models/connect.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
  await http.get('http://fifmi.org/category/news/apostles-updates');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Json extends StatefulWidget {
  Json({Key key}) : super(key: key);

  @override
  _JsonState createState() => _JsonState();
}

class _JsonState extends State<Json> {
  Future<Album> futureAlbum;
  List<Connect>mListings = [];

  Future <Connect>getProducts() async {
    setState(() {
      loading = true;
    });
    mListings.clear();
    String urldata ="http://adfifmedia.org/fetch.php?connect=connect";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          mListings.add(Connect.fromJson(i));
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
    super.initState();
    futureAlbum = fetchAlbum();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mListings.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        // decoration: boxDecoration(radius: 10, showShadow: true),
                        child: Card(
                          // semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ResponsiveRow(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                          height: 100,
                            // color: Colors.blue,
                            width: 100.0,
                                    child: CachedNetworkImage(
                                        imageUrl: "http://adfifmedia.org/uploads/listings/${mListings[index].profile}",
                                        // width: width / 3,
                                        // height: width / 2.8,
                                        fit: BoxFit.fill),
                                  ),
                                  Container(
                                    // width: width - (width / 3) - 35,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color:Colors.purple,
                                                borderRadius: new BorderRadius.only(
                                                    bottomRight:
                                                    const Radius.circular(16.0),
                                                    topRight:
                                                    const Radius.circular(16.0)),
                                              ),
                                              padding:
                                              EdgeInsets.fromLTRB(8, 2, 8, 2),
                                              child: Text( "New"),
                                            ),
                                            GestureDetector(
                                                onTap: () {},
                                                child: Icon(Icons.more_vert))
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(mListings[index].title,),
                                            SizedBox(height: 4),
                                            Text(mListings[index].date,),
                                            SizedBox(height: 4),
                                            Text(mListings[index].description,
                                                ),
                                            SizedBox(height: 4),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: EdgeInsets.all(0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ),
    );
  }
}
