import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(393, 851), // Pixel 6
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Login(),
        );
      },
    ),
  );
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordobscure = true;

  void verify(String inputUsername, String inputPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedUsername = prefs.getString('username');
    final String? storedPassword = prefs.getString('password');

    if (inputUsername == storedUsername && inputPassword == storedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.thumb_up, color: Colors.white, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                "Login Successfully!",
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(Duration(seconds: 2));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50.w, 10.h, 50.w, 50.h),
                child: Container(
                    child: Column(
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Text("Enter your credentials to login",
                        style: TextStyle(fontSize: 16.sp)),
                  ],
                )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Username', style: TextStyle(fontSize: 16.sp)),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 239, 225, 241),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text("Password", style: TextStyle(fontSize: 16.sp)),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        obscureText: passwordobscure,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password_sharp),
                          suffixIcon: IconButton(
                              icon: Icon(passwordobscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordobscure = !passwordobscure;
                                });
                              }),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 239, 225, 241),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        verify(
                            usernameController.text, passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("Create New Account",
                      style: TextStyle(color: Colors.purple, fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
