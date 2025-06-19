import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fox/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void clearData() async {
    {
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
      print("Data cleared");
      await loadData();
      print(loadData());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Back <3',
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            child: Text("Log out"),
            onPressed: () {
              clearData();
            },
          ),
        ],
      ),
    ));
  }
}
