import 'package:flutter/material.dart'; 
import 'package:dropdown_formfield/dropdown_formfield.dart'; 
import 'dart:async';
import 'login.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

class attendancePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new attendState();
}
class attendState extends State<attendancePage>{
  var user_id, token ; 
  var jsonData;
  var year, month;
  String time, day;
  var agency;
  var detail, detailnth;
  var start, end;
  var json_data;
  var pjsonData;
  var detailDay;
  var day_diff;
  Position currentPosition;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    currentTime();
    getData();
  }
  currentTime(){
    var datee     = new DateTime.now().toString();
    var dateParse = DateTime.parse(datee);

    month = "${dateParse.month}";
    year  = "${dateParse.year}";

    DateTime now = DateTime.now();
    day          = DateFormat('d').format(now);
  }
  Future<void> getData() async{   
    user_id = await storage.read(key: 'id'); 
    token   = "Token "+await storage.read(key: 'token');

    var response = await http.get("http://139.59.66.2:9000/stapi/v1/office/attendance/?user="+user_id+"&year="+year+"&month="+month+"", headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringData = (response.body);
    jsonData = json.decode(response.body);
    print(jsonData);

    if(jsonData['count'] == 0){
      day_diff = 0;
      detailnth = 1;
      json_data = {"id": "0"};
      detail = [{"day": day, "start": '', "end": ''}];
    }
    else{
      json_data = jsonData['results'][jsonData['count']-1];
      detail    = json_data['details'].reversed.toList();
      DateTime x1 = DateTime(int.parse(year),int.parse(month),0).toUtc();
      
      if(month == 12)
      {
        month = 0;
        year  = year+1;
      }
      var y1      = DateTime(int.parse(year),int.parse(month)+1,0).toUtc().difference(x1).inDays;
      day_diff  = y1 - int.parse(day);
      detailnth = detail.length - day_diff;
    }

    setState(() {
      token;
      json_data;
      detail;
    });
  }
  firstPopUp(String id, String start, String end) async{
    AlertDialog alert = AlertDialog(  
      title: new Text("Alert!"),  
      content: new Text("Turn on location", style: TextStyle(color: Colors.black),),    
        
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _getCurrentLocation();
            Navigator.of(this.context).pop();
            secPopUp(id, start, end);
          },
          color: Colors.blue,
          child: const Text('Okay, got it!'),
        ),
      ],
    ); 
    showDialog(  
      context: this.context,  
      builder: (BuildContext context) {  
        return alert;  
      },  
    );
  }
  secPopUp(String id, String start, String end) async{
    AlertDialog alert1 = AlertDialog(  
      title: new Text("Conform!"),  
      content: new Text("It's your time", style: TextStyle(color: Colors.black),),    
      
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
           startTime(id, start, end, currentPosition.latitude.toString(), currentPosition.longitude.toString() );
           Navigator.of(this.context).pop();
          },
          color: Colors.blue,
          child: const Text('Okay, got it!'),
        ),
      ],
    ); 
    showDialog(  
      context: this.context,  
      builder: (BuildContext context) {  
        return alert1;  
      },  
    );
  }
  startTime(String id, String start, String end, String lat, String lng) async {
    token = "Token "+await storage.read(key: 'token');
    agency    = await storage.read(key: 'agency');
    user_id    = await storage.read(key: 'id');

    var datee     = new DateTime.now().toString();
    var dateParse = DateTime.parse(datee);
    DateTime now  = DateTime.now();
    time = DateFormat('kk:mm:ss').format(now);
    var start_time = '';
    var end_time = '';

    if(start != null && start != ''){
      start_time = start;
    }
    else{
      start_time = time;
    }
    if(start != '' && (end == null || end == '')){
      end_time = time;
    }

    Map<String,dynamic> data = { 
      'id':    id.toString(), 
      'user':  user_id, 
      'agency': agency, 
      'day':   day, 
      'start': start_time,
      'end':   end_time, 
      'latitude':  currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString()
    };
    print(data);
    var responseP = await http.post("http://139.59.66.2:9000/stapi/v1/office/attendance/", body: data, headers: <String, String>{'authorization':token});
    print(responseP.statusCode);
    if(responseP.statusCode == 201){
      getData();
      var stringDataP = (responseP.body);
      pjsonData = json.decode(responseP.body);
      print(pjsonData);
    }
    setState(() {
      token;
    });
  }

  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Attendance', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,   
          children: <Widget>[   
            addAttendance(),
            cardsAttend()
          ], 
        ),
      ),
    );
  }
  Widget addAttendance(){
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(10,10,0,0),
        height: 60,
        width: 360,
        child: Card(
          elevation: 5,
          child: InkWell(
            onTap: () {},
            child: Column(children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10,10,0,0),
                    child: Text('Date', style: TextStyle(color: Colors.black, fontSize: 15),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(60,10,0,0),
                    child: Text('Start Time', style: TextStyle(color: Colors.black, fontSize: 15),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(60,10,0,0),
                    child: Text('Finish Time', style: TextStyle(color: Colors.black, fontSize: 15),),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ), 
    ]);
  }
  Widget cardsAttend(){
    return Container(
      padding: EdgeInsets.fromLTRB(10,20,10,0),
      height: 500.0,
      child: ListView.builder(
        // reverse: true,
        scrollDirection: Axis.vertical,
        itemCount: detailnth,
        itemBuilder: (BuildContext context, int i) =>
        Card(
          elevation: 5,
          child: InkWell(
            onTap: () => firstPopUp(json_data['id'].toString(), detail[i+day_diff]['start'].toString(), detail[i+day_diff]['end'].toString()), 
            child: Container(
              width: 220.0,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(children: <Widget>[
                      Row(children: [
                        Padding(padding: EdgeInsets.fromLTRB(0,20,30,0),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(detail[i+day_diff]['day'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0,40,80,0),),
                        Align(
                          alignment: Alignment.center,
                          child: Text(detail[i+day_diff]['start'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0,20,60,0),),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(detail[i+day_diff]['end'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                      ]),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        print(currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }
}