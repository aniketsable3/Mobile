import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/update_record.dart'; // Ensure the import path is correct

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userdata = [];

  Future<void> delrecord(String sno) async {
    try {
      String uri = "http://10.0.2.2/mmcrud/delete_record.php";
      var res = await http.post(Uri.parse(uri), body: {"sno": sno});
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Record Deleted");
        setState(() {
          userdata.removeWhere((element) => element["sno"] == sno);
        });
        getrecord();
      } else {
        print("Issue: ${response['message']}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getrecord() async {
    String uri = "http://10.0.2.2/mmcrud/view_record.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getrecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Data"),
      ),
      body: userdata.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userdata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateRecord(
                            userdata[index]["name"],
                            userdata[index]["email"],
                    
                          ),
                        ),
                      );
                    },
                    leading: Icon(
                      CupertinoIcons.heart,
                      color: Colors.red,
                    ),
                    title: Text(userdata[index]["name"]),
                    subtitle: Text(userdata[index]["email"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        delrecord(userdata[index]["sno"]);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
