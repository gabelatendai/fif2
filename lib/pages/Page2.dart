import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/Dashboard.dart';
import 'package:fwf/models/GridTiles.dart';
import 'package:fwf/models/GridTilesModel.dart';
import 'package:fwf/models/Model.dart';
import 'package:fwf/models/Pages.dart';
import 'package:fwf/widgets/CircularProgress.dart';
import 'package:http/http.dart' as http;
class Page2 extends StatefulWidget {

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  String image ='';
  List<Pages>_Prolist = [];
  bool loading = false;
  Future <Pages>getProducts() async {
    setState(() {
      loading = true;
    });
    _Prolist.clear();
    // String urldata ="http://adfifmedia.org/fetch.php?dashboard=dashboard";
    String urldata ="http://adfifmedia.org/fetch.php?pages=pages&title=sermons";
    final response = await http.get(urldata);
    // final response = await http.get(url + "?id=${user_id}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _Prolist.add(Pages.fromJson(i));
          loading = false;

        }
        image =_Prolist[0].profile;
      });
    }
    print(_Prolist.length);

  }
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
        // appBar:AppBar(title: AutoSizeText('Indulge into the Word of God',maxLines: 1,),),
        body:ListView(
            shrinkWrap: true,
            children:<Widget> [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "http://adfifmedia.org/uploads/listings/${image}",
                placeholder: (context, url) => Image.asset(
                  'assets/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
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
                              GridTilesModel(
                                name: products.name,
                                id: products.id,
                                views: products.views,
                                title: products.title,
                                profile: "http://adfifmedia.org/uploads/listings/${products.profile}",
                                description:products.description,
                                video:'http://adfifmedia.org/files/${products.vidio}',
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

Model products;

Future<List<Model>> fetchProducts() async{
  String url ="http://adfifmedia.org/fetch.php?sermons=sermons";
  final response = await http.get(url);
  return modelFromJson(response.body);

}