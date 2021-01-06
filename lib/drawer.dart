import 'package:flutter/material.dart';  
import 'dart:async';
import 'home.dart';
import 'login.dart';
import 'contact.dart';
import 'support.dart';
import 'profile.dart';
import 'Attendance.dart';

class NavDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<NavDrawer>{
  @override  
  Widget build(BuildContext context) {  
    return Drawer(
      child: new ListView( 
        children: <Widget>[
          new ListTile(  
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Home', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => HomePage()),  
              );  
            },  
          ),
          new Divider(),  
          new ListTile(  
            leading: Icon(Icons.thumb_up , color: Colors.black),
            title: Text('Attendance', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => attendancePage()),  
              );  
            },  
          ),
          new Divider(),  
          new ListTile(  
            leading: Icon(Icons.local_phone , color: Colors.black),
            title: Text('Contact', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => ContactPage()),  
              );  
            },
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Support', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => SupportPage()),  
              );  
            },
          ),
          new Divider(),
          new ListTile( 
            leading: Icon(Icons.person, color: Colors.black), 
            title: Text('Profile', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () {  
              Navigator.push(  
                context,  
                MaterialPageRoute(builder: (context) => profilePage()),  
              );  
            },  
          ),
        ],  
      ),
    );
  }
} 