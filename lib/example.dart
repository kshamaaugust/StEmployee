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
  var id; 
  var token;
  var jsonData, total;
  var date, year, month;
  String time, day;
  var agency;
  var dateee;
  var detail, detailnth;
  var dayis, start, end;
  var cardDate, cardst, cardet;
  Position currentPosition;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    getData();
  }
  getCurrentDate(){
    var datee      = new DateTime.now().toString();
    var dateParse = DateTime.parse(datee);
 
    date  = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    month = "${dateParse.month}";
    year  = "${dateParse.year}";

    DateTime now = DateTime.now();
    // time = DateFormat('kk:mm:ss').format(now); 
    day  = DateFormat('d').format(now);
    dateee = day.substring(0,2);
    print(dateee);
    // print(time);
    print(day);
    print("date is.."  +date);
    print("month is.." +month);
    print("year is.." +year);
  }
  Future<void> getData() async{   
    id    = await storage.read(key: 'id'); 
    token = "Token "+await storage.read(key: 'token');
    
    jsonData = null;
    print("get data is called");
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/office/attendance/?user="+id+"&year="+year+"&month="+month+"", headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringData = (response.body);
    jsonData = json.decode(response.body);
    print(jsonData);

    detail = jsonData['results'][0]['details'];
    print(detail);

    detailnth = detail.length;
    print(detailnth);

    print("its getData time");
    for(int x=0; x< detail.length; x++){
      dayis = detail[x]['day'];
      start = detail[x]['start'];
      end = detail[x]['end'];
      print(dayis);
      print(start);
      print(end);
    }
    // for(int x=0; x< detail.length; x++){
    //   start = detail[x]['start'];
    //   print(start);
    // }
    // for(int x=0; x< detail.length; x++){
    //   end = detail[x]['end'];
    //   print(end);
    // }

    await storage.write(key: 'forDate' , value: dayis.toString() );
    await storage.write(key: 'forST' , value: start);
    await storage.write(key: 'forET' , value: end);


    setState(() {
      token;
    });
  }
  firstPopUp() async{
    print("its in first Popup");
    cardDate = await storage.read(key: 'forDate');  
    cardst = await storage.read(key: 'forST');  
    cardet = await storage.read(key: 'forET');  

    print(cardDate);
    print(cardst);
    print(cardet);

    AlertDialog alert = AlertDialog(  
        title: new Text("Alert!"),  
        content: new Text("Turn on location", style: TextStyle(color: Colors.black),),    
        
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
             _getCurrentLocation();
             Navigator.of(this.context).pop();
             secPopUp();

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
  secPopUp() async{
    print("its in second Popup");
    // cardDate = await storage.read(key: 'forDate');  
    // cardst = await storage.read(key: 'forST');  
    // cardet = await storage.read(key: 'forET');  

    // print(cardDate);
    // print(cardst);
    // print(cardet);

    AlertDialog alert1 = AlertDialog(  
        title: new Text("Conform!"),  
        content: new Text("It's your start time", style: TextStyle(color: Colors.black),),    
        
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
             startTime( currentPosition.latitude.toString(), currentPosition.longitude.toString() );
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
  startTime(String lat, String lng) async {
    // print(start);
    print("upload time");
    token = "Token "+await storage.read(key: 'token');
    agency    = await storage.read(key: 'agency');
    print(agency.toString());
    id    = await storage.read(key: 'id');
    print(id.toString());

    var datee      = new DateTime.now().toString();
    var dateParse = DateTime.parse(datee);
    DateTime now = DateTime.now();
    time = DateFormat('kk:mm:ss').format(now);
    print(time);
    Map data = { 
      'id':    '0', 
      'user':  id, 
      'agency': agency, 
      'day':   day, 
      'start': time,
      'end':   null, 
      'latitude':  currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString()
    };

    // var jsonData = null;
    print(data);
    print(id.runtimeType);
    print(agency.runtimeType);
    print(day.runtimeType);
    print(time.runtimeType);
    print(currentPosition.latitude.runtimeType);

    print("before get");
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/office/attendance/", body: data, headers: <String, String>{'authorization':token});
    print("print status");
    print(response.statusCode);
    print(response.body);
  }

  // endTime(String start, String lat, String lng) async {
  //   // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  //   // geolocator
  //   //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //   //     .then((Position position) {
  //   //   setState(() {
  //   //     currentPosition = position;
  //   //     print(currentPosition);
  //   //   });
  //   // }).catchError((e) {
  //   //   print(e);
  //   // });

  //   print("upload time");
  //   token = "Token "+await storage.read(key: 'token');
  //   agency    = await storage.read(key: 'agency');
  //   print(agency.toString());
  //   id    = await storage.read(key: 'id');
  //   print(id.toString());

  //   var datee      = new DateTime.now().toString();
  //   var dateParse = DateTime.parse(datee);
  //   DateTime now = DateTime.now();
  //   time = DateFormat('kk:mm:ss').format(now);
  //   print(time);
  //   Map data = { 
  //     'id':    '0', 
  //     'user':  id, 
  //     'agency': agency, 
  //     'day':   day, 
  //     'start': time,
  //     'end':   null, 
  //     'latitude':  currentPosition.latitude.toString(),
  //     "longitude": currentPosition.longitude.toString()
  //   };

  //   // var jsonData = null;
  //   print(data);
  //   print(id.runtimeType);
  //   print(agency.runtimeType);
  //   print(day.runtimeType);
  //   print(time.runtimeType);
  //   print(currentPosition.latitude.runtimeType);

  //   print("before get");
  //   var response = await http.post("http://139.59.66.2:9000/stapi/v1/office/attendance/", body: data, headers: <String, String>{'authorization':token});
  //   print("print status");
  //   print(response.statusCode);
  //   print(response.body);
  //   // if( _getCurrentLocation(); },){
  //   //   AlertDialog alert = AlertDialog(  
  //   //     title: new Text("Alert!"),  
  //   //     content: new Text("Turn on Location", style: TextStyle(color: Colors.black),),    
  //   //   ); 
  //   //   showDialog(  
  //   //     context: this.context,  
  //   //     builder: (BuildContext context) {  
  //   //       return alert;  
  //   //     },  
  //   //   );
  //   // }
  // }

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
          elevation: 20,
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
      // Container(
      //   padding: EdgeInsets.fromLTRB(10,5,0,0),
      //   height: 71,
      //   width: 360,
      //   child: Card(
      //     elevation: 20,
      //     child: InkWell(
      //       onTap: () => Upload(),
      //       child: Column(children: <Widget>[
      //         Row(
      //           children: [
      //             Container(
      //               padding: EdgeInsets.fromLTRB(15,10,0,0),
      //               child: Text(dayis.toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
      //             ),
      //             Container(
      //               padding: EdgeInsets.fromLTRB(60,10,0,0),
      //               child: RaisedButton(
      //                 color: Colors.transparent,
      //                 elevation: 0.0,
      //                 child: Text(' ',style: TextStyle(color: Colors.white,fontSize: 16),),
      //                 onPressed: () {
      //                   _getCurrentLocation();
      //                 },
      //               ), 

      //               // child: Text('  ', style: TextStyle(color: Colors.black, fontSize: 15),),
      //             ),
      //             Container(
      //               padding: EdgeInsets.fromLTRB(60,10,0,0),
      //               child: Text('  ', style: TextStyle(color: Colors.black, fontSize: 15),),
      //             ),
      //           ],
      //         ),
      //       ]),
      //     ),
      //   ),
      // ),
      // Container(
      //   padding: EdgeInsets.fromLTRB(10,10,0,0),
      //   height: 60,
      //   width: 360,
      //   child: Card(
      //     elevation: 20,
      //     child: InkWell(
      //       onTap: () {},
      //       child: Column(children: <Widget>[
      //         Row(
      //           children: [
      //           Container(
      //           margin: const EdgeInsets.only(left: 5.0, right: 0.0, top: 10,),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[
      //               if (currentPosition != null)
      //                 Text("${currentPosition.latitude}, ${currentPosition.longitude}"),
      //             ],
      //           ),
      //         ),
      //           ],
      //         ),
      //       ]),
      //     ),
      //   ),
      // ), 
    ]);
  }
  Widget cardsAttend(){
    return Container(
      padding: EdgeInsets.fromLTRB(10,10,10,0),
      height: 500.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: detailnth,
        itemBuilder: (BuildContext context, int i) =>
        Card(
          elevation: 10,
          child: InkWell(
            onTap: () => firstPopUp(), 
            // onPressed: () => _getCurrentLocation();
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
                          child: Text(detail[i]['day'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0,40,80,0),),
                        Align(
                          alignment: Alignment.center,
                          child: Text(detail[i]['start'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0,20,60,0),),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(detail[i]['end'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                      ]),
                      // Row(children: [
                      //   Container(
                      //     width: 330.0,
                      //     height: 20.0,
                      //     padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      //     child: FlatButton(
                      //       color: Colors.transparent, 
                      //       child: Text('Location',style: TextStyle(color: Colors.black,fontSize: 15),),
                      //       // onPressed: () {
                      //       //   _getCurrentLocation();
                      //       // },                          
                      //     ),  
                      //   ),
                      // ]),
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