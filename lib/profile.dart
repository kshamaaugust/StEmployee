import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class profilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<profilePage>{
  FocusNode myFocusNode = new FocusNode();
  final storage = new FlutterSecureStorage();
  var fn, ln, un, mail, mob, phn, dob, gender, address, local, city, state, zip, tag, about, id, token, jsondata,total;

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async{   
    id    = await storage.read(key: 'id');
    token = "Token "+await storage.read(key: 'token');
    jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/user/"+id+"/", headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringdata = (response.body);
    jsondata = json.decode(response.body);
    print(jsondata);

    fn      = jsondata['first_name'];
    ln      = jsondata['last_name'];
    un      = jsondata['username'];
    mail    = jsondata['email'];
    mob     = jsondata['mobile'];
    phn     = jsondata['phone'];
    dob     = jsondata['dob'];
    gender  = jsondata['gender'];
    address = jsondata['address'];
    local   = jsondata['locality'];
    city    = jsondata['city'];
    state   = jsondata['state'];
    zip     = jsondata['zipcode'];
    tag     = jsondata['tagline'];
    about   = jsondata['about'];

    setState(() { token; });
  }

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
  	  appBar: AppBar(
        title: Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        actions: <Widget>[
  		    IconButton(
  		      icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {  
              AlertDialog alert = AlertDialog(  
                title: new Text("Conform!", style: TextStyle(fontWeight: FontWeight.bold)),  
                content: Text("Are you sure,  You want Logout!!!"),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {  
                      Navigator.of(this.context).pop();  
                    },
                    child: const Text('CANCEL', style: TextStyle(color: Colors.blue)),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(builder: (context) => LoginPage()),  
                      );
                    },
                    child: const Text('OKAY', style: TextStyle(color: Colors.blue)),
                  ),
                ],    
              ); 
              showDialog(  
                context: context,  
                builder: (BuildContext context) {  
                  return alert;  
                },  
              );  
            }, 
  		    ),
	      ],
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _editTitleTextField()
          ],
        ),
      ),
    );
  }
  Widget _editTitleTextField(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
          child: new Text('First Name :- ', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
          child: new Text(fn.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Last Name :- ', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(ln.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Username :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(un.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Email :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(mail.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Mobile :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(mob.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Phone :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(phn.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('DOB :- ', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(dob.toString() ?? 'default' , style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Gender :- ', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(gender.toString() ?? 'default' , style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Address :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(address.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Locality :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(local.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('City :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(city.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('State :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(state.toString() ?? 'default' , style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Zip code :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(zip.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('Tagline :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(tag.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
      ),
      new Divider(color: Colors.grey),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text('About :-', style: TextStyle(fontSize: 16),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: new Text(about.toString() ?? 'default', style: TextStyle(fontSize: 16),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
      ),
    ]);
  }
}