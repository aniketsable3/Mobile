import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Ensure this import is present

class UpdateRecord extends StatefulWidget {
  final String name;
  final String email;
  UpdateRecord(this.name, this.email);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  

  Future<void> updateRecord() async {
    try {
      String uri = "http://10.0.2.2/mmcrud/update_record.php";
      var res = await http.post(Uri.parse(uri),
          body: {
            "name": nameController.text,
            "email": emailController.text,
          
          });

      var response = jsonDecode(res.body);

      if (response["success"] == "true") {
        print("Updated");
      } else {
        print("Some issue: ${response['message']}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter The Name'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter The Email'),
            ),
          ),
          
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                updateRecord();
              },
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
