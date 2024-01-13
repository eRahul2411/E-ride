

import 'package:eride/login.dart';
import 'package:eride/singup1.dart';
import 'package:flutter/material.dart';

class welcompage extends StatefulWidget {
  const welcompage({Key? key}) : super(key: key);

  @override
  State<welcompage> createState() => _welcompageState();
}

class _welcompageState extends State<welcompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0,bottom: 10),
                child: Text(
                  "Welcome To E-RIDE !",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 100),
                child: Text(
                  "“Ride, Hire, Rent: Hassle-free!”",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 200.0),
              child: Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/banner.png"),fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0,left: 18,right: 18),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey, // background
                          onPrimary: Colors.white, // foreground
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: Text("LOG IN")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent , // background
                          onPrimary: Colors.white, // foreground
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Singup1()));
                        },
                        child: Text("SIGN UP")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
