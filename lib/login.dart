import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fox/homePage.dart';
import 'package:test_fox/sign_up.dart';

Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();

  String? prefName = prefs.getString('username');
  String? prefPassword = prefs.getString('password');
  print('Username: $prefName');
  print('Password: $prefPassword');
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  String usernameMessage = '';
  TextEditingController passwordController = TextEditingController();
  String passwordMessage = '';

  void verify(String inputUsername, String inputPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedUsername = prefs.getString('username');
    final String? storedPassword = prefs.getString('password');

    if (inputUsername == storedUsername && inputPassword == storedPassword) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Center(
                  child: Column(
                    children: [
                      Text(
                        "Login successfully",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                content: Text(
                  "Correct username and password.",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        },
                        child: Text("OK")),
                  )
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Center(
                  child: Column(
                    children: [
                      Text(
                        "Fail Login",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                content: Text(
                  "Username or Password is incorrect",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK")),
                  )
                ],
              ));
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Future<void> loadData() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   String? prefName = prefs.getString('username');
  //   String? prefPassword = prefs.getString('password');
  //   print('Username: $prefName');
  //   print('Password: $prefPassword');

  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
              child: Container(
                  child: const Column(
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text("Enter your credentials to login"),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: usernameController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 239, 225, 241),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: passwordController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password_sharp),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 239, 225, 241),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verify(usernameController.text, passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text("Create New Account",
                    style: TextStyle(color: Colors.purple)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
