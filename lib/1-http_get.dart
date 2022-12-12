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
    return const MaterialApp(
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
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID : $id",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Name : $name",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Email : $email",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var myResponse = await (myhttp
                      .get(Uri.parse("https://reqres.in/api/users/3")));

                  if (myResponse.statusCode == 200) {
                    print("Berhasil GET Data");
                    Map<String, dynamic> data =
                        jsonDecode(myResponse.body) as Map<String, dynamic>;

                    setState(() {
                      id = data['data']['id'].toString();
                      name =
                          "${data['data']['first_name'].toString()} ${data['data']['last_name'].toString()}";
                      email = data['data']['email'].toString();
                    });
                  } else {
                    print("ERROR ${myResponse.statusCode}");
                  }
                },
                child: Text("GET DATA"))
          ],
        ),
      ),
    );
  }
}
