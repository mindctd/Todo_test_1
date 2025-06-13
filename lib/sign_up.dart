import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fox/login.dart';
import 'package:test_fox/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime? _selectedDate;
  final List<String> _items = ['Men', 'Women'];
  int _selectedIndex = -1;
  // ignore: unused_field
  bool _genderSelected = false;
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  final TextEditingController _emailController = TextEditingController();
  String _emailMessage = '';
  final TextEditingController _passwordController = TextEditingController();
  String _passwordMessage = '';
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _confirmPasswordMessage = '';
  final TextEditingController _nameSurnameController = TextEditingController();
  String _nameSurnameMessage = '';
  final TextEditingController _telephoneController = TextEditingController();
  String _telephoneMessage = '';
  final TextEditingController _addressController = TextEditingController();
  String _addressMessage = '';
  String verifyMessage = '';

  void _signVerify(
      String inputUsername,
      String inputemail,
      String inputpassword,
      String inputcomfirmpassword,
      String inputname,
      String inputAddress,
      String inputtelephone,
      DateTime? inputdate,
      int inputgender) {
    if (inputUsername.isEmpty ||
        inputemail.isEmpty ||
        inputpassword.isEmpty ||
        inputcomfirmpassword.isEmpty ||
        inputname.isEmpty ||
        inputtelephone.isEmpty ||
        inputAddress.isEmpty ||
        inputdate == null ||
        inputgender == -1 ||
        _message.isNotEmpty ||
        _emailMessage.isNotEmpty ||
        _passwordMessage.isNotEmpty ||
        _confirmPasswordMessage.isNotEmpty ||
        _nameSurnameMessage.isNotEmpty ||
        _telephoneMessage.isNotEmpty ||
        _addressMessage.isNotEmpty) {
      setState(() {
        verifyMessage = '❌ Please fill all fields correctly';
      });
    } else
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('username', inputUsername);
        prefs.setString('password', inputpassword);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: Column(
                    children: [
                      Text(
                        "Success",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                content: Text(
                  "You have successfully signed up!",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text("OK"),
                    ),
                  ),
                ],
              );
            });
      });
  }

  void _validateUsername(String value) {
    final isValid = Utils().isValidUsername(value.trim());
    setState(() {
      _message = isValid ? '' : '❌ Needs to be at least 5 characters long';
    });
  }

  void _validateEmail(String value) {
    final isValid = Utils().isValidEmail(value.trim());
    setState(() {
      _emailMessage = isValid ? '' : '❌ Invalid email format';
    });
  }

  void _validatePassword(String value) {
    final isValid = Utils().isValidPassword(value.trim());
    setState(() {
      _passwordMessage = isValid
          ? ''
          : '❌ Needs to be at least 8 characters long and contain letters and numbers';
    });
  }

  void _confirmPassword(String value) {
    setState(() {
      value == _passwordController.text
          ? _confirmPasswordMessage = ''
          : _confirmPasswordMessage = '❌ Passwords do not match';
    });
  }

  void _nameSurname(String value) {
    final isValid = Utils().isValidName(value.trim());
    setState(() {
      _nameSurnameMessage =
          isValid ? '' : '❌ Needs to be at least 1 characters long';
    });
  }

  void _validateTelephone(String value) {
    final isValid = Utils().istelephoneNumber(value.trim());
    setState(() {
      _telephoneMessage =
          isValid ? '' : '❌ Needs to be only 10 numbers long and start with 0';
    });
  }

  void _validateAddress(String value) {
    final isValid = Utils().isValidAddress(value.trim());
    setState(() {
      _addressMessage =
          isValid ? '' : '❌ Needs to be at least 1 characters long';
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCupertinoPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    backgroundColor: Colors.white,
                    scrollController: FixedExtentScrollController(
                        initialItem: _selectedIndex),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: _items
                        .map((item) => Center(child: Text(item)))
                        .toList(),
                  ),
                ),
              ),
              CupertinoButton(
                  child: Text('Select'),
                  onPressed: () {
                    setState(() {
                      _genderSelected = true;
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                child: Container(
                    child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text("Create a new account"),
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Color.fromARGB(255, 239, 225, 241),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: _validateUsername,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _message,
                  style: TextStyle(
                    fontSize: 16,
                    color: _message.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _emailController,
                    onChanged: _validateEmail,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _emailMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: _emailMessage.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _passwordController,
                    onChanged: _validatePassword,
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
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _passwordMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: _passwordMessage.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _confirmPasswordController,
                    onChanged: _confirmPassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.password_sharp),
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _confirmPasswordMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: _confirmPasswordMessage.contains('❌')
                        ? Colors.red
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _nameSurnameController,
                    onChanged: _nameSurname,
                    decoration: InputDecoration(
                      labelText: "Name - Surname",
                      prefixIcon: Icon(Icons.abc),
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _nameSurnameMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        _nameSurnameMessage.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 225, 241),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 10),
                        Text(_selectedDate != null
                            ? "${_selectedDate!.toLocal().toString().split(' ')[0]}"
                            : 'Birth Date')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showCupertinoPicker(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 225, 241),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.man_4_sharp),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text('   Gender')),
                        SizedBox(width: 10),
                        Text(_selectedIndex >= 0
                            ? _items[_selectedIndex]
                            : 'Gender')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _telephoneController,
                    onChanged: _validateTelephone,
                    decoration: InputDecoration(
                      labelText: "Telephone",
                      prefixIcon: Icon(Icons.phone),
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _telephoneMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: _telephoneMessage.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _addressController,
                    onChanged: _validateAddress,
                    decoration: InputDecoration(
                      labelText: "Address",
                      prefixIcon: Icon(Icons.home),
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _addressMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: _addressMessage.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _signVerify(
                          _textEditingController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                          _nameSurnameController.text,
                          _telephoneController.text,
                          _addressController.text,
                          _selectedDate,
                          _selectedIndex,
                        );
                      },
                      // async {
                      //   SharedPreferences prefs =
                      //       await SharedPreferences.getInstance();

                      //   prefs.setString(
                      //       'username', _textEditingController.text);

                      //   prefs.setString('password', _passwordController.text);
                      //   showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //           title: Text("Success"),
                      //           content:
                      //               Text("You have successfully signed up!"),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () {
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) => Login()),
                      //                 );
                      //               },
                      //               child: Text("OK"),
                      //             ),
                      //           ],
                      //         );
                      //       });
                      // },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  verifyMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: verifyMessage.contains('❌') ? Colors.red : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
