import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'view_data.dart'; // Corrected import statement
import 'package:app/login_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  

  Future<void> Insertrecord() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty) {
      try {
        String uri = "http://10.0.2.2/mmcrud/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text
          
        });
        var response = jsonDecode(res.body);
        if (response['status'] == 'success') {
          print("Record Inserted");
        } else {
          print("Some issue: ${response['message']}");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All The Fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Insert Record for You')),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Enter The Name')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Enter The Email')),
              ),
            ),
            
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Insertrecord();
                },
                child: Text('Insert'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewData()),
                        );
                      },
                      child: Text("View Data"),
                      
                      );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginApp()),
                        );
                      },
                      child: Text("Login"));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
