import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/Events.dart';
import 'package:fwf/models/Pages.dart';
import 'package:fwf/pages/DetailedEvent.dart';
import 'package:http/http.dart' as http;
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var titleTextStyle = TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  String image ='';
  List<Pages>_list = [];
  List<Events>_Prolist = [];
  DateTime now = DateTime.now();
  bool loading = false;
  Future <Pages>getBunners() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    String urldata ="http://adfifmedia.org/fetch.php?pages=pages&title=notification";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Pages.fromJson(i));
          loading = false;

        }
        image =_list[0].profile;
      });
    }
    print(_Prolist.length);

  }

  Future <Events>getProducts() async {
    setState(() {
      loading = true;
    });
    _Prolist.clear();
    var response= await http.post('http://adfifmedia.org/notifications.php'
        ,body:{'date':'${now.year.toString()}/${now.month.toString()}/${now.day.toString()}'});


    var convert = json.decode(response.body);
    setState(() {
      for (Map i in convert) {
        _Prolist.add(Events.fromJson(i));
      }
    });
    print(_Prolist.length);

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getBunners();
getProducts();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title: AutoSizeText("Our Upcoming Events",maxLines: 1,),),
      body:ListView(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "http://adfifmedia.org/uploads/listings/${image}",
            placeholder: (context, url) => Image.asset(
              'assets/loading.gif',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
         ListView.builder(
                    primary: false,
                      shrinkWrap: true,
                      itemCount:_Prolist.length,
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (BuildContext context, int index) {
                        Events products= _Prolist[index];
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
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: "http://adfifmedia.org/uploads/listings/${products.profile}",
                                      placeholder: (context, url) => Image.asset(
                                        'assets/loading.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    // Container(
                                    //   height: 200.0,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.only(
                                    //         topLeft: Radius.circular(10.0),
                                    //         topRight: Radius.circular(10.0),
                                    //       ),
                                    //       image: DecorationImage(
                                    //         image:
                                    //         NetworkImage("http://adfifmedia.org/uploads/listings/${products.profile}"),
                                    //         fit: BoxFit.cover,
                                    //       )
                                    //   ),
                                    // ),
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
                                          Column(
                                            children:<Widget> [
                                              AutoSizeText( 'Start Date',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              AutoSizeText( products.startdate,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0,
                                                ),
                                              ),

                                            ],
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
                                          Column(
                                            children:<Widget> [
                                              AutoSizeText( 'End Date',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              AutoSizeText( products.enddate,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0,
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                                Positioned(
                                  top: 190,
                                  left: 20.0,
                                  child: Container(
                                    color: Colors.red,
                                    padding: const EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      "LIVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );


                      })
    ]));


  }
}

Events products;

Future<List<Events>> fetchProducts() async{
  String url ="http://adfifmedia.org/fetch.php?events=events";
  final response = await http.get(url);
  return eventsFromJson(response.body);

}