
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
class DetailedTeaching extends StatefulWidget {
  String id;
  String title;
  String category;
  String name;
  String description;
  String date;
  String profile;
  String video;
DetailedTeaching({Key key, @required this.id,
  @required this.video,
  @required this.profile,
  @required this.title,
  @required this.name,
  @required this.category,
  @required this.description,
  @required this.date,}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailedTeachingState();
  }
}

class _DetailedTeachingState extends State<DetailedTeaching> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool playing = false;
  @override
  void initState() {
    super.initState();
    // playing =true;
  }

  @override
  void dispose() {

    super.dispose();
  }
  bool downloading = false;
  var progressString = "";
  int progress = 0;
  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      print("path ${dir.path}");
      await dio.download(widget.video, "${dir.path}/${widget.title}.mp4",
          onReceiveProgress: (rec, total) {
            print("Rec: $rec , Total: $total");

            setState(() {
              downloading = true;
              progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
            });
          });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }


  Widget slider() {
    return Slider.adaptive(
        activeColor:  Colors.purple,
        inactiveColor:  Colors.purple,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: AutoSizeText(widget.title,maxLines: 1,),),
      body: ListView(
        children: <Widget>[
          ResponsiveCol(
            children:<Widget> [
              widget.profile == null
                  ? Image.asset('assets/new.jpg')
                  : Image.network(
                widget.profile,),
            ],
          ),
          Column(
            children: [
              InkWell(
              onTap: (){
                // getAudio();
                setState(() async {

                  await _launchURL('${widget.video}'); // your URL

//                    downloadFile();
                });
              },
              child: Icon(playing ==
                  false ?
              Icons.play_arrow
                  : Icons.pause
                ,size: 100,
                color: Colors.purple,

              ),
            ),
              slider(),

            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText("${widget.title}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),))
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText("by  ${widget.name}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),)
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

//              AutoSizeText("$progress", style: TextStyle(fontSize: 10),),
              IconButton(
                color: Colors.purple,
                icon: Icon(Icons.file_download,),
                onPressed: () async {
                  setState(() async {

                    await _launchURL('${widget.video}'); // your URL

//                    downloadFile();
                  });
//                final status = await Permission.storage.request();
//
//                if (status.isGranted) {
//                  final externalDir = await getExternalStorageDirectory();
//
//                  final id = await FlutterDownloader.enqueue(
//                    url:
//                    "${widget.video}",
//                    savedDir: externalDir.path,
//                    fileName: "download",
//                    showNotification: true,
//                    openFileFromNotification: true,
//                  );
//
//                } else {
//                  print("Permission deined");
//                }
                },
              ),
              IconButton(
                color: Colors.purple,
                icon: Icon(Icons.share),
                onPressed:  () async{
                  try {
                    await  WcFlutterShare.share(
                        sharePopupTitle: 'Share',
                        subject: "${widget.title}",
                        text: "${widget.description}",
                        mimeType: 'text/plain');
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),

          _buildDescription(context)
        ],
      ),

    );
  }
  void getAudio() async{
    var url =widget.video;
    // var url ='http://adfifmedia.org/uploads/audio/No_Longer_Slaves_to_Fear___&_Abba___By_Jonathan_David_&_Melissa_Helser(128k).mp3';
    if(playing){
      var res = await audioPlayer.pause();
      if(res==1){
        setState(() {
          playing=false;
        });
      }
    }else{

      var res = await audioPlayer.play(url,isLocal: true);
      if(res==1){
        setState(() {
          playing=true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd){
      setState(() {
        _duration = dd;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd){
      setState(() {
        _position = dd;
      });
    });
  }
  _buildDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AutoSizeText(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            AutoSizeText(widget.description,
              style: TextStyle(
                color: Colors.grey,
              ),),

          ],
        ),
      ),
    );
  }
}
