import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();  
  final storage = new FlutterSecureStorage();

  @override
  login(String Username, String Password) async{
    Map data = {
      'username': Username,
      'password': Password,
      'service': 'Employee'
    };
    var jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/login/", body: data);
    if(response.statusCode == 200){
      print(response.statusCode);
      var stringData = (response.body);
      print(stringData);
      jsonData = json.decode(response.body);

      var token    = (jsonData['data']['token']);
      var id       = (jsonData['data']['id']);
      var user     = (jsonData['data']['username']);
      var mail     = (jsonData['data']['email']);
      var mobile   = (jsonData['data']['mobile']);
      var fn       = (jsonData['data']['first_name']);
      var ln       = (jsonData['data']['last_name']);
      var gender   = (jsonData['data']['gender']);
      var agency   = (jsonData['data']['agency']);

      print('token is ' +token);
      print("id is " +id.toString());
      print("username is " +user);
      print("mail is " +mail);
      print("mobile is " +mobile.toString());
      print("first_name is " +fn);
      print("last_name is " +ln);
      print("geder is " +gender);
      print("agency is " +agency.toString());

      await storage.write(key: 'first_name' , value: fn);
      await storage.write(key: 'email'      , value: mail);
      await storage.write(key: 'id'         , value: id.toString());
      await storage.write(key: 'username'   , value: user);
      await storage.write(key: 'mobile'     , value: mobile.toString());
      await storage.write(key: 'token'      , value: token);
      await storage.write(key: 'last_name'  , value: ln);
      await storage.write(key: 'gender'     , value: gender);
      await storage.write(key: 'agency'     , value: agency.toString());
          
      Navigator.push(  
        context,  
        MaterialPageRoute(builder: (context) => HomePage()),  
      );  
    }
    else{
      AlertDialog alert = AlertDialog(  
        title: new Text("Simple Alert"),  
        content: new Text("Invalid Username and Password", style: TextStyle(color: Colors.red),),    
      ); 
      showDialog(  
        context: context,  
        builder: (BuildContext context) {  
          return alert;  
        },  
      );
    }
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 35.0),),            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 0.0),
              child: new Text('Login To Your Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 20.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),

                  border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
                    labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 10.0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
                    labelText: 'Password',
                ),
              ),
            ),
            Container(
              width: 180.0,
              height: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
              child: RaisedButton(
                color: Colors.blue, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 22),),                
                onPressed: () => login(nameController.text, passwordController.text),
              ),  
            ), 	
          ],
        )
      )
    );
  }
}  