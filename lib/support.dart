import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SupportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<SupportPage> {
  var id, token;
  var jsonData, total;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async{ 
    id    = await storage.read(key: 'id'); 
    token = "Token "+await storage.read(key: 'token');

    jsonData = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/support/?user="+id, headers: <String, String>{'authorization':token});    
    print(response.statusCode);
    var stringData = (response.body);
    jsonData = json.decode(response.body);
    print(jsonData);

    total = jsonData['count'];

    setState(() {
      token;
    });
  }

  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[   
            _ViewSupport(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => _editsupport()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget _ViewSupport(){
    return Container(
      padding: EdgeInsets.fromLTRB(20,15,20,0),
      height: 560.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: total,
        itemBuilder: (BuildContext context, int i) =>
        Card(
          child: Container(
            width: 190.0,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                Text(jsonData['results'][i]['subject'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 22),),
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
                Text(jsonData['results'][i]['message'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
                Padding(padding: EdgeInsets.fromLTRB(0,30,0,0),),
                FlatButton(
                  color: Colors.blue, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Text("View", style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.push(  
                      context,  
                      MaterialPageRoute(builder: (context) => _editsupport()),  
                    );  
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _editsupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_editsupport>{ 
  var id, token;
  FocusNode myFocusNode = new FocusNode();
  final storage = new FlutterSecureStorage();

  TextEditingController subController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  Upload(String sub,String msg) async {
    id    = await storage.read(key: 'id');
    token = "Token "+await storage.read(key: 'token');

    Map data = { 
      'user':       id,
      'subject':    subController.text,
      'message':    msgController.text,
      'attachment': '',
      'source':     'Android',
      'status':     'Inactive'
    };

    var jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/support/", body: data, headers: <String, String>{'authorization':token});
    print(response.statusCode);
    var stringData = (response.body);
    print(stringData);
    jsonData = json.decode(response.body);
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: subController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => SupportPage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  } 
}