import 'dart:math';
import 'package:eride/driver/Driverhome.dart';
import 'package:eride/user/Carrent.dart';
import 'package:eride/user/Carrent2.dart';
import 'package:eride/login.dart';
import 'package:eride/ref.dart';
import 'package:eride/splash.dart';
import 'package:eride/user/Resultsearch.dart';
import 'package:eride/user/singuser.dart';
import 'package:eride/welcompage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const eride());
}
class eride extends StatefulWidget {
  const eride({Key? key}) : super(key: key);

  @override
  State<eride> createState() => _erideState();
}

class _erideState extends State<eride> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
