import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilResponse = "Belum ada datas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP PUT - PATCHS"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Name"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration:
                InputDecoration(border: OutlineInputBorder(), labelText: "Job"),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                var myResponse = await myhttp.put(
                    Uri.parse("https://reqres.in/api/users/2"),
                    body: {"name": nameC.text, "job": jobC.text});

                Map<String, dynamic> data =
                    jsonDecode(myResponse.body) as Map<String, dynamic>;

                setState(() {
                  hasilResponse = "${data["name"]} - ${data["job"]}";
                });
              },
              child: Text("Submit")),
          SizedBox(
            height: 50,
          ),
          Divider(
            color: Colors.blue,
          ),
          SizedBox(
            height: 10,
          ),
          Text(hasilResponse)
        ],
      ),
    );
  }
}
