import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/api/api_services.dart';
import 'package:eride/user/Carrent.dart';
import 'package:eride/user/Driverrent.dart';
import 'package:eride/user/Riderequest.dart';
import 'package:eride/user/Share1.dart';
import 'package:eride/user/ShareRideDetasils.dart';
import 'package:eride/user/Taxiac.dart';
import 'package:eride/user/YourShare.dart';
import 'package:eride/user/taxi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late String axi;
  String username = "";
  String login_id = "";
  String log = "";
  String first_name = "";
  String Phone_no = "";
  String last_name = "";
  String address = "";
  String email = "";
  String gender = "";
  String usernames = "";
  String idcard = "";
  String idcardimag = "";
  String _id = "";
  String mac = '';
  ApiService client = ApiService();


  String profilepic = "";
  String pickup = "";
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchuser();

  }

  fetchuser()async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? '');
      login_id = prefs.getString('login_id') ?? '';
      print("usr${username}");
      print("usr${login_id}");


      print("usssssssssssr${log}");

    });

  }


  final String userPhotoUrl = 'https://example.com/user_photo.jpg';
  // Replace with the user's photo URL
  List _loadprooducts = [];

  late int login;


  @override
  Widget build(BuildContext context) {
    log=login_id;
    print('log $log');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,'+username.replaceAll('"', ''),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Where do you want to go?',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      // onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>_buildProfilePage()));
                      // },
                      child: CircleAvatar(
                        backgroundImage: AssetImage("server/public/images/" + profilepic),
                        radius: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0 ,right: 10),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('images/banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.6),
                          Colors.black.withOpacity(.6),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "E-ride",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 15,top: 20,bottom: 8 ),
                child: Row(
                  children: [
                    // Curved Square
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Share1()));
                      },
                      child: Container(
                        width:  MediaQuery.of(context).size.width/3,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                'Share Ride',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Curved Rectangle
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Driverrent()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.9,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black87,
                        ),

                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                'Driver Rent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Carrent()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.9,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.car_rental_outlined,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                'car Rent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Curved Square

                    SizedBox(width: 10),
                    GestureDetector(

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Taxi(axi:log)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/3,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_taxi,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                'taxi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Curved Rectangle

                  ],
                ),
              ),

              SizedBox(height: 25.0),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Notification",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShareRideDetails()));
                            },
                            child: ListTile(
                              leading: Icon(Icons.notifications_active),
                              title: Text("Joined Ride Details"),
                              subtitle: Text("John shared a ride from XYZ to ABC"),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        }  if (index == 2) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Taxiac(axi:log)));
                            },
                            child: ListTile(
                              leading: Icon(Icons.notifications_active),
                              title: Text("taxi"),
                              subtitle: Text("Your ride will come in Time XY"),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        }if (index == 3) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Riderequest(axi:log)));
                            },
                            child: ListTile(
                              leading: Icon(Icons.notifications_active),
                              title: Text("ride request"),
                              subtitle: Text(""),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        }
                        else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => YourShare()));
                            },
                            child: ListTile(
                              leading: Icon(Icons.notifications_active),
                              title: Text("Your Shared Ride"),
                              subtitle: Text("You are sharing a ride from DEF to GHI"),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),





            ], // Added closing bracket for the Column widget
          ),
        ),
      ),
    );
  }
}