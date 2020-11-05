import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/connect.dart';
import 'package:fwf/widgets/CircularProgress.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';

import 'DetailedConnect.dart';

class ConnectPage extends StatefulWidget {
  String image;
  ConnectPage({Key key,
    @required this.image}): super(key: key);
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  List<Connect> _Prolist = [];

  var loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchProducts();

    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xffFD6592);
    final Color bgColor = Colors.purple;
    final Color secondaryColor = Color(0xff324558);
    return Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            "Join One of our Assemblies",
            maxLines: 1,
          ),
        ),
        body: ListView(children: <Widget>[
          // Image.asset('assets/c.jpg'),
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "http://adfifmedia.org/uploads/listings/${widget.image}",
            placeholder: (context, url) => Image.asset(
              'assets/loading.gif',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          FutureBuilder(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: CircularProgress(),
                  );
                  //child: Products(),
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Connect pro = snapshot.data[index];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailedConnect(
                                          title: pro.title,
                                          views: pro.views,
                                          date: pro.date,
                                          id: pro.id,
                                          profile: pro.profile,
                                          location: pro.location,
                                          description: pro.description,
                                          contact: pro.contact,
                                        )),
                              );
                            },
                            child: Container(
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 90,
                                    height: 90,
                                    color: bgColor,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    margin: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          // color: Colors.blue,
                                          width: 120.0,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: "http://adfifmedia.org/uploads/listings/${pro.profile}",
                                            placeholder: (context, url) => Image.asset(
                                              'assets/loading.gif',
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              AutoSizeText(
                                                pro.title,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              AutoSizeText(
                                                pro.location,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:
                                                            Colors.purple,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                      child: const SizedBox(
                                                          width: 5.0),
                                                    ),
                                                    TextSpan(
                                                        text: pro.contact,
                                                        style: TextStyle(
                                                            fontSize: 16.0)),
                                                    WidgetSpan(
                                                      child: const SizedBox(
                                                          width: 20.0),
                                                    ),
                                                    WidgetSpan(
                                                      child: const SizedBox(
                                                          width: 5.0),
                                                    ),
                                                    TextSpan(
                                                      text: pro.date,
                                                    ),
                                                  ],
                                                ),
                                                style: TextStyle(height: 2.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      });
                }
              })
        ]));
  }
}

Connect products;

Future<List<Connect>> fetchProducts() async {
  String url = "http://adfifmedia.org/fetch.php?connect=connect";
  final response = await http.get(url);
  return connectFromJson(response.body);
}
