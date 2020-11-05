import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fwf/widgets/AppBarWidget.dart';
import 'package:fwf/widgets/CircularProgress.dart';

class Live extends StatefulWidget {
  String url;
  String title;
  Live({Key key,
    @required this.url ,@required this.title}): super(key: key);
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {

@override
  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      // url=widget.url;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: AutoSizeText(widget.title),),
      body: Center(
       child:
       WebviewScaffold(url: widget.url,
       )




      ),
    );


  }
}
