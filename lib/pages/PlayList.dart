import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

typedef void OnError(Exception exception);

class PlayPage extends StatefulWidget {
  @override
  _PlayPage createState() =>  _PlayPage();
}

class _PlayPage extends State<PlayPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool playing = false;


  @override
  void initState() {
    super.initState();
    // initPlayer();
  }

 
  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.black,
        inactiveColor: Colors.pink,
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset('assets/index.png'),
          slider(),
          InkWell(
            onTap: (){
              getAudio();
            },
            child: Icon(playing ==
                false ?
                Icons.play_circle_outline
                : Icons.pause_circle_outline
                ,size: 100,

            ),
          )
        ],
      ),
    );
  }

  void getAudio() async{
    var url ='http://adfifmedia.org/uploads/audio/No_Longer_Slaves_to_Fear___&_Abba___By_Jonathan_David_&_Melissa_Helser(128k).mp3';
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
}