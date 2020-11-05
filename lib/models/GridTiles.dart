
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fwf/pages/DetailedTeaching.dart';

class GridTiles extends StatelessWidget {
  String id;
  String title;
  String category;
  String name;
  String description;
  String date;
  String profile;
  String vedio;

  GridTiles(
      {Key key,
        @required this.id,
        @required this.vedio,
        @required this.profile,
        @required this.title,
        @required this.name,
        @required this.category,
        @required this.description,
        @required this.date,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedTeaching(video: vedio,
                title: title,name: name, date: date,
                profile: profile, id: id,
                description: description,
                category: category,)),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 5),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            elevation: 0,
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child:CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "${profile}",
                      placeholder: (context, url) => Image.asset(
                        'assets/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),

                    // Image.network(
                    //   profile,
                    // width: 250,
                    // height: 250,
                    // ),
                  ),
                  Container(
//                    alignment: Alignment.center,
                   // padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: AutoSizeText(title,
                        // (title.length <= 20 ? title : title.substring(0, 20)),
                       // textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF444444),
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                    maxFontSize: 17,minFontSize: 12,maxLines: 1,),
                  ),
                  Container(
//                    alignment: Alignment.bottomLeft,
//                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: AutoSizeText("by ${name}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
