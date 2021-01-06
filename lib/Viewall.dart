import 'package:flutter/material.dart'; 
import 'package:dropdown_formfield/dropdown_formfield.dart'; 
import 'dart:async';
import 'home.dart';

class ViewallPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ValetState();
}
class _ValetState extends State<ViewallPage>{
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('All Users', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
        ),
      ),
      // floatingActionButton: FloatingActionButton(
        // onPressed: () {  
        //   Navigator.push(  
        //     context,  
        //     MaterialPageRoute(builder: (context) => AddViewallPage()),  
        //   );  
        // },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.blue,
      // ),
    );
  }
}