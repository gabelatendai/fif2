import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/GridTiles.dart';
import 'package:fwf/models/Model.dart';
import 'package:fwf/widgets/CircularProgress.dart';
import 'package:http/http.dart' as http;
class Teachings extends StatefulWidget {
  String image;
  Teachings({Key key,
    @required this.image}): super(key: key);
  @override
  _TeachingsState createState() => _TeachingsState();
}

class _TeachingsState extends State<Teachings> {

  List<Model>_Prolist = [];

  Future <Model>getProducts() async {
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
          _Prolist.add(Model.fromJson(i));
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
        appBar:AppBar(title: AutoSizeText('Indulge into the Word of God',maxLines: 1,),),
      body:ListView(
        shrinkWrap: true,
       children:<Widget> [
         CachedNetworkImage(
           fit: BoxFit.cover,
           imageUrl: "http://adfifmedia.org/uploads/listings/${widget.image}",
           placeholder: (context, url) => Image.asset(
             'assets/loading.gif',
             fit: BoxFit.cover,
           ),
           errorWidget: (context, url, error) => Icon(Icons.error),
         ),
// Image.asset('assets/a.jpg'),
        FutureBuilder(
              future: fetchProducts(),
              builder: (context,snapshot){
                if(snapshot.data==null){
                  return Container(
                    child:  CircularProgress(),
                  );
                  //child: Products(),
                }else{
                  return  GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount:snapshot.data.length,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        Model products= snapshot.data[index];
                        return
                          GridTiles(
                          name: products.name,
                          id: products.id,
                          title: products.title,
                          profile: "http://adfifmedia.org/uploads/listings/${products.profile}",
                          description:products.description,
                          vedio:'http://adfifmedia.org/files/${products.vidio}',
                            category: products.category,
                            date: products.date,
//                            date: products.date,
                        );
                      });
                }
              }
          )
     ] )
    );


  }
}

Future<List<Model>> fetchProducts() async{
  String url ="http://adfifmedia.org/fetch.php?teachings=teachings";
  final response = await http.get(url);
  return modelFromJson(response.body);

}