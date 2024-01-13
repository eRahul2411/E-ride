import 'dart:convert';

import 'package:eride/Admin/Admin.dart';
import 'package:eride/api/api.dart';
import 'package:eride/driver/Driverhome.dart';
import 'package:eride/singup1.dart';
import 'package:eride/user/homepage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  bool _isLoading = false;
  String admin = "0";
  String users = "";
  String user = "1";
  String taxi = "2";
  String driver = "3";
  String storedvalue = '1';

  TextEditingController passcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();

  late String role;
  late String status;
  late SharedPreferences localStorage;
  _pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'username': usercontroller.text.trim(),
      'password': passcontroller.text.trim(),
    };

    var res = await Api().authData(data,'/login/login');
    var body = json.decode(res.body);
    print("body${body}");
    if (body['success'] == true) {
      print(body);

      role = json.encode(body['details']['role']);
      users = json.encode(body['details']['username']);
      status = json.encode(body['details']['status']);

      print('u: ${users}');
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setString('login_id', json.encode(body['login_id']));
      localStorage.setString('username', users.toString());

      print('login_idss ${json.encode(body['login_id'])}');

      print('role: ${role}');
      print('role: ${role.runtimeType}');
      print('status: ${status}');


      if (admin == role.replaceAll('"', '')) {
        print('data: $data');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Adminhome()));

      } else if (driver == role.replaceAll('"', '') && storedvalue == status.replaceAll('"', '')) {
        print('data: $data');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Driverhome()));
      } else if (user == role.replaceAll('"', '') && storedvalue == status.replaceAll('"', '')) {
        print('data: $data');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Homeuser()));
      } else {
        Fluttertoast.showToast(
          msg: "Please wait for admin approval",
          backgroundColor: Colors.grey,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Overide the default Back button
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_left_sharp,
            color: Colors.redAccent,
          ),
          label: const Text('Back', style: TextStyle(color: Colors.redAccent)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // other stuff
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
              child: Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/banner.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Login",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Welcome Back, Login and Experience More!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50, top: 10, bottom: 20),
              child: TextField(
                controller: usercontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Enter Username",
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 50.0,
              ),
              child: TextField(
                maxLength: 10,
                controller: passcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Enter password",
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  counterText: '',
                ),
                obscureText: true, // Hide the password characters

              ),
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              width: 310,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, // background
                    onPrimary: Colors.white, // foreground
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _pressLoginButton();
                  },
                  child: Text("login")),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Sign up',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Singup1()));
                                })
                        ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
