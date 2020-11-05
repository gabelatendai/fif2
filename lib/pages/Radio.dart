import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fwf/widgets/AppBarWidget.dart';

class RadioScreen extends StatefulWidget {
  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Ezekiel Radio'),),
        body:WebviewScaffold(
          url: 'https://www.mixlr.com/ezekiel-radio',   // Add website here
          mediaPlaybackRequiresUserGesture: false,
        )
    );


  }
}
