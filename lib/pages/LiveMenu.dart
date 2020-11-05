import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/LiveStreaming.dart';
import 'package:fwf/pages/Live.dart';
import 'package:fwf/pages/Radio.dart';
import 'package:fwf/widgets/AppBarWidget.dart';
import 'package:http/http.dart' as http;

import 'ContactUs.dart';


class LiveMenu extends StatefulWidget {
  @override
  _LiveMenuState createState() => _LiveMenuState();
}

class _LiveMenuState extends State<LiveMenu> {
  List<LiveStreaming>_Prolist = [];
  bool loading = false;
  Future <LiveStreaming>getProducts() async {
    setState(() {
      loading = true;
    });
    _Prolist.clear();
    // String urldata ="http://adfifmedia.org/fetch.php?dashboard=dashboard";
    String urldata ="http://adfifmedia.org/fetch.php?live=live";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _Prolist.add(LiveStreaming.fromJson(i));
          loading = false;

        }
        // image =_Prolist[0].profile;
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
    final Color bgColor = Color(0xffF3F3F3);
    final Color primaryColor = Color(0xffE70F0B);
    var now = DateTime.now();
    String g = ('${now.year}/ ${now.month}/ ${now.day}');
    var titleTextStyle = TextStyle(
      color: Colors.black87,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    var teamNameTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800,
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar:AppBar( centerTitle: true,title: AutoSizeText('Enjoy The Live Streaming Now',maxLines: 1,),),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          GridView.builder(
            // crossAxisCount: 2,
            // gridDelegate: ,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,crossAxisSpacing: 4.0),
              // crossAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              // mainAxisSpacing: 8.0,

              itemCount: _Prolist.length,
              itemBuilder: (context, index) {
                LiveStreaming choice = _Prolist[index];
                return  InkWell(
                    onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Live(url: choice.link, title: choice.title,)),
                        );

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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AutoSizeText(
                                  choice.title,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children:<Widget> [
                                        AutoSizeText(choice.description,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                          ),
                                        ),

                                      ],
                                    ),


                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              // AutoSizeText(choice.msg),
                            ]
                        ),
                        )
                    )
                );
              }
          ),
     ],
      ),
    );
  }
}

