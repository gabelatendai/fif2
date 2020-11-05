
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fwf/models/Sermons.dart';
import 'package:fwf/widgets/CircularProgress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fwf/widgets/AppBarWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:http/http.dart' as http;

class DetailedSermons extends StatefulWidget {
  String id;
  String title;
  String category;
  String name;
  String description;
  String date;
  String profile;
  String video;
  String views;
DetailedSermons({Key key, @required this.id,
  @required this.video,
  @required this.profile,
  @required this.title,
  @required this.views,
  @required this.name,
  @required this.category,
  @required this.description,
  @required this.date,}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailedSermonsState();
  }
}

class _DetailedSermonsState extends State<DetailedSermons> {

  bool downloading = false;
  var progressString = "";
  int progress = 0;
  bool processing = false;
  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

    Future<List<Sermons>> views() async{
      String url ="http://adfifmedia.org/views.php?sermons=sermons&views=${widget.views}&id=${widget.id}";
      print(url);
    final response = await http.get(url);
    return sermonsFromJson(response.body);
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
  @override
  void initState() {
    setState(() {
      processing= true;
    });
    super.initState();

    _controller = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          processing= false;
        });
      });
    setState(() {

    });
  }
  VideoPlayerController _controller;


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:appBarWidget(context),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 30,),
      if(processing)

    Container(
      child:  CircularProgress(),
    )

      else

          _controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
            InkWell(
              onTap: ()  async{
    //             setState(() async{
    // _controller.value.isPlaying
    // ? await _controller.pause()
    //     : _controller.play();
    // });
                setState(() async {

            await _launchURL('${widget.video}'); // your URL

//                    downloadFile();
            });
              },
              child: Icon(_controller.value.isPlaying ?
    Icons.pause
                  : Icons.play_arrow,
                size: 100,
                color: Colors.purple,

              ),
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
                icon: Icon(Icons.file_download),
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