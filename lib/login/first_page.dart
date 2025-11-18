import 'dart:convert';

import 'package:differentbyte/home_page.dart/profile_page.dart';
import 'package:differentbyte/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  LoginModel loginModel = LoginModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Enter GitHub Username",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "e.g. name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => searchUser(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: searchUser,
                      icon: Icon(Icons.search, color: Colors.white),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text('Search User'),
                      ),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        backgroundColor:
                            Colors.blue, // Set button color to blue
                        foregroundColor:
                            Colors.white, // Set text/icon color to white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchUser() async {
    try {
      String username = nameController.text;
      var url = Uri.https('api.github.com', '/users/$username');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = response.body;
        loginModel = LoginModel.fromJson(
          Map<String, dynamic>.from(await Future.value(jsonDecode(data))),
        );
        print(loginModel);
        // Navigate to ProfilePage when status code is 200
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(loginModel: loginModel),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
