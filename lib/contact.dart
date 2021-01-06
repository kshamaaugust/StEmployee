import 'package:flutter/material.dart';  
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<ContactPage> {
  FocusNode myFocusNode = new FocusNode();
  var id, token, mail, fn, ln, name, mob;
  var first, mobile;
  var fname, lname, mobe, cname;
  final storage = new FlutterSecureStorage();

  TextEditingController subController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    token  = "Token "+await storage.read(key: 'token'); 
    fname  = await storage.read(key: 'first_name');
    lname  = await storage.read(key: 'last_name'); 
    mobe   = await storage.read(key: 'mobile'); 
    cname  = fname+" "+lname;

    setState(() {
      token;
    });
  }

  Upload(String sub,String msg) async {
    token = "Token "+await storage.read(key: 'token');
    id    = await storage.read(key: 'id');
    mail  = await storage.read(key: 'email');
    fn    = await storage.read(key: 'first_name');
    ln    = await storage.read(key: 'last_name'); 
    mob   = await storage.read(key: 'mobile'); 
    name  = fn+" "+ln;

    Map data = { 
      'user': id,
      'name': name,
      'mobile': mob,
      'subject':subController.text,
      'message':msgController.text,
      'email': mail,
      'source': 'Android',
      'status':'Inactive'
    };

    var jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/contact/", body: data, headers: <String, String>{'authorization':token});
    print(response.statusCode);
    var stringData = (response.body);
    print(stringData);
    jsonData = json.decode(response.body);
  }

  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
            ),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                child: new Text('Name :- ', style: TextStyle(fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 35, 0, 0),
                child: new Text(cname.toString() ?? 'default', style: TextStyle(fontSize: 16),),
              ),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
            ),
            new Divider(color: Colors.black),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                child: new Text('Mobile :- ', style: TextStyle(fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                child: new Text(mobe.toString() ?? 'default', style: TextStyle(fontSize: 16),),
              ),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0),
            ),
            new Divider(color: Colors.black),
            Container(
              child: TextField(
                controller: subController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
                  labelText: 'Message',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 230.0, top: 10,),
              child: RaisedButton(
                color: Colors.blue, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: () => Upload(subController.text, msgController.text),
              ),  
            ),  
          ],
        ),
      ),
    );
  }
}