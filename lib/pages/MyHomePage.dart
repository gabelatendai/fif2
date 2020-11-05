import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/Dashboard.dart';

import 'Bible.dart';
import 'Connect.dart';
import 'EventsPage.dart';
import 'LiveMenu.dart';
import 'PageR.dart';
import 'Teachings.dart';
import 'package:http/http.dart' as http;
import 'Updates.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Dashboard>_Prolist = [];
  bool loading = false;
  Future <Dashboard>getProducts() async {
    setState(() {
      loading = true;
    });
    _Prolist.clear();
    String urldata ="http://adfifmedia.org/fetch.php";
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
          GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              mainAxisSpacing: 8.0,
              children: List.generate(choices.length, (index) {
                return Center(
                  child: SelectCard(choice: choices[index]),
                );
              }
              )
          )
      ],
      ),
    );

  }


}
class Choice {
  const Choice({this.title, this.image, this.msg});
  final String title;
  final String msg;
  final String image;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Apostles Update', image:'assets/b.jpg',msg: "Get the latest news"),
  const Choice(title: 'Teachings', image:'assets/a.jpg',msg: "Indulge into the word of God"),
  const Choice(title: 'Watch Live', image:'assets/img2.png',msg: "Enjoy the Live streaming"),
  const Choice(title: 'Events', image:'assets/5.png',msg: "Our  Upcoming Events"),
  const Choice(title: 'Connect', image:'assets/c.jpg',msg: "Join one of our Assemblies"),
  const Choice(title: 'Bible', image:'assets/e.png',msg: "Dive into the word of God"),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return InkWell(
        onTap: () {
          print(choice.title);
          if (choice.title=="Watch Live"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  LiveMenu()),
            );
          }
          if (choice.title=="Bible"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Bible()),
            );
          }
          if (choice.title=="Connect"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ConnectPage()),
            );
          }
          if (choice.title=="Apostles Update"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  UpadatesPage()),
            );
          }
          if (choice.title=="Teachings"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Teachings()),
            );
          }
          if (choice.title=="Events"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  EventsPage()),
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

                  Expanded(child:  Image.asset(choice.image,
                    height:  20.17,
                  ),),
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
                        AutoSizeText(choice.msg,
                          style: TextStyle(color: Colors.white),
                        maxLines: 1,),

                      ),
                    ),
                  )
                  // AutoSizeText(choice.msg),
                ]
            ),
            )
        ));
  }
}