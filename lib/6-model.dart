import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;
import 'package:kuldii_section5/model/user.dart';

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

class HomePage extends StatelessWidget {
  // Buat array kosong untuk menampung data
  List<UserModel> allUser = []; // UserModel adalah nama model nya

  Future getAllUser() async {
    try {
      var response = await myhttp.get(Uri.parse("https://reqres.in/api/users"));

      List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

      data.forEach((element) {
        allUser.add(
          UserModel(
            avatar: element["avatar"],
            name: "${element['first_name']} ${element['last_name']}",
            email: element["email"],
          ),
        );
      });
    } catch (e) {
      print("Terjadi Kesalahans");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Future Builder"),
        ),
        body: FutureBuilder(
            future: getAllUser(),
            // snapshot untuk cek apakah dia lagi loading untuk ambil data atau tidak
            builder: (context, snapshot) {
              // Jika sedang proses ambil data
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Maka akan menampilkan tulisan loading di tengah2
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                // Jika sudah selesai ambil data
                // Maka tampilkan datanya
                return ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(allUser[index].avatar),
                    ),
                    title: Text("${allUser[index].name}"),
                    subtitle: Text("${allUser[index].email}"),
                  ),
                );
              }
            }));
  }
}
