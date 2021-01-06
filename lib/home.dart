import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'Agency.dart';
import 'Bodyguard.dart';
import 'Bouncer.dart';
import 'Watchman.dart';
import 'Gunman.dart';
import 'valet.dart';
import 'Viewall.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<HomePage> {
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _homeField()
          ],
        ),
      ),
    );
  }
  Widget _homeField(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 140,
          width: 160,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => addAgency()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(50,0,0,0),
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30,20,0,20),
                      child: Text('ADD NEW', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ), 
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 140,
          width: 160,
          child: Card(
            color: Colors.black,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => ViewallPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(50,0,0,0),
                      icon: Icon(Icons.event, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20,20,0,20),
                      child: Text('VIEW DETAILS', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ]),
    ]);
  }
}
class addAgency extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _agencyState();
}
class _agencyState extends State<addAgency> {
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('Add New', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _AddhomeField()
          ],
        ),
      ),
    );
  }
  Widget _AddhomeField(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 120,
          width: 340,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => Addagency()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(145,0,0,0),
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(120,10,0,0),
                      child: Text('ADD AGENCY', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 130,
          width: 170,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => BodyguardPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(60,0,0,0),
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30,10,0,0),
                      child: Text('BODYGUARD', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 130,
          width: 170,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => BouncerPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(60,0,0,0),
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(40,10,0,0),
                      child: Text('BOUNCER', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 130,
          width: 170,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => WatchmanPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(60,0,0,0),
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30,10,0,0),
                      child: Text('WATCHMAN', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 130,
          width: 170,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => GunmanPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(60,0,0,0),
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(40,10,0,0),
                      child: Text('GUNMAN', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 130,
          width: 170,
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => ValetPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(60,0,0,0),
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(45,10,0,0),
                      child: Text('VALET', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 130,
          width: 170,
          child: Card(
            color: Colors.blue,
            child: Column(children: <Widget>[
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.fromLTRB(60,0,0,0),
                    icon: Icon(Icons.add_circle, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(45,10,0,0),
                    child: Text('CLIENT', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 120,
          width: 340,
          child: Card(
            color: Colors.black,
            child: InkWell(
              onTap: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => ViewallPage()),  
                );  
              },
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(145,0,0,0),
                      icon: Icon(Icons.event, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(130,10,0,0),
                      child: Text('VIEW ALL', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
      ),
    ]);
  }
}