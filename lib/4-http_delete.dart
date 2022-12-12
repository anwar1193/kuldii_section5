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
      debugShowCheckedModeBanner: false,
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
  String data = "Belum Ada Data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP DELETE"),
        actions: [
          IconButton(
              onPressed: () async {
                var response = await myhttp
                    .get(Uri.parse("https://reqres.in/api/users/2"));
                Map<String, dynamic> myBody = json.decode(response.body);
                setState(() {
                  data =
                      "Akun : ${myBody['data']['first_name']} ${myBody['data']['last_name']}";
                });
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Text(data),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                var response = await myhttp
                    .delete(Uri.parse("https://reqres.in/api/users/2"));
                setState(() {
                  if (response.statusCode == 204) {
                    data = "Data Berhasil Dihapus!";
                  }
                });
                // print(response.statusCode);
              },
              child: Text("Delete Data"))
        ],
      ),
    );
  }
}
