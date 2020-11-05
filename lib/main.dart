import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fwf/pages/EventsPage.dart';
import 'dart:async' show Future, Timer;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fwf/pages/home.dart';
import 'package:fwf/pages/schedule_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

NotificationAppLaunchDetails notificationAppLaunchDetails;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIF AD',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScrren(),
    );
  }
}

class SplashScrren extends StatefulWidget {
  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;
  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: Text(
        "You are not Connected to Internet",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    notifications = ScheduleNotifications(
      'your channel id',
      'your other channel name',
      'your other channel description',
    );
    notifications.init(onSelectNotification: (String payload) async {
      if (payload == null || payload.trim().isEmpty) return null;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventsPage()),
      );
      return;
    });
    notifications.getNotificationAppLaunchDetails().then((details){
      notificationAppLaunchDetails = details;
    });
    tyr();
    Timer(Duration(seconds: 5,
    ), () {
      isInternetOn
          ? iswificonnected ?
          // print('conected')
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))
      :
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))
          : buildAlertDialog()
      // Navigator.pop(context);
      ;
    }
    );
  }
  ScheduleNotifications notifications;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child:new Container(
                height:200.0,
                width: 200.0,

                child: new Image(
                    image: new AssetImage('assets/index.png',),height:30.0),

              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
  Future<List> tyr()async {
    DateTime now = DateTime.now();

    // var response= await http.post('http://snagasportswear.com/notification.php'
    var response= await http.post('http://adfifmedia.org/notifications.php'
        ,body:{'date':'${now.year.toString()}/${now.month.toString()}/${now.day.toString()}'});
    // print("here================");
    // print(response.body);

    var convert = json.decode(response.body);
    if (convert.length > 0) {
      // if(jsonDecode(response.body) == "true"){
      //   if (convert['verified']  == true) {
      print(" messgae");
      print(" ${now.year.toString()}/${now.month.toString()}/${now.day.toString()}");
      print(convert[0]['title']);
      // notifications.showDailyAtTime(
      notifications.show(
        // Time(20, 0, 0),0
        id: 0,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        title: convert[0]['title'],
        body:convert[0]['description'],
        payload: 'item x',
      );
      // showNotification(convert[[0]]['name'], flp);
    } else {
      print("no messgae");
    }
  }
  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {

      iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {

      iswificonnected = true;
      setState(() async {
        wifiBSSID = await (Connectivity().getWifiBSSID());
        wifiIP = await (Connectivity().getWifiIP());
        wifiName = await (Connectivity().getWifiName());
      });


    }
  }

}
