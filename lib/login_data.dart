import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/view_data.dart';
import 'package:app/main.dart';
 // Ensure you have the correct import

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<void> login() async {
    if (name.text.isNotEmpty && email.text.isNotEmpty) {
      try {
        String uri = "http://10.0.2.2/mmcrud/login_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text
        });
        var response = jsonDecode(res.body);
        if (response['status'] == 'success') {
          print("Login Successful");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewData()),
          );
        } else {
          print("Login Failed: ${response['message']}");
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
        appBar: AppBar(title: Text('Login')),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Enter Your Name')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Enter Your Email')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text('Login'),
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
                          MaterialPageRoute(builder: (context) => const MyApp()),
                        );
                      },
                      child: Text("Sign Up"));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
