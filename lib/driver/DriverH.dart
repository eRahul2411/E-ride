import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/api/api_services.dart';
import 'package:eride/driver/Driverhome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverH extends StatefulWidget {
  const DriverH({super.key});

  @override
  State<DriverH> createState() => _DriverHState();
}

class _DriverHState extends State<DriverH> {
  String first_name = "";
  String Phone_no = "";
  String last_name = "";
  String address = "";
  String job = "";
  String ndays = "";
  String adres = "";
  String driver_booking_date = "";
  String driver_booking_time = "";
  String status = "";
  String mac = '';
  ApiService client = ApiService();
  String username = "";
  String login_id = "";
  String log = "";
  String profilepic = "";
  String usid = "";
  String login_idf = "";

  late SharedPreferences prefs;
  void initState() {
    super.initState();
    // _viewPro();
    _viewPro2();

  }
  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? '');
      login_id = prefs.getString('login_id') ?? '';
    });

    print("usr${username}");
    print("usr${login_id}");
    String mid = login_id.replaceAll('"', '');
    print("user selected id is $mid");

    var res = await Api().getData('/driver_booking/viewdriverall/$mid');
    var body = json.decode(res.body);
    print("response body: $body");

    if (body != null && body['success'] == true) {
      var data = body['data'];
      if (data != null && data.isNotEmpty) {
        setState(() {
          first_name = data[0]['first_name'] ?? '';
          Phone_no = data[0]['Phone_no'] ?? '';
          last_name = data[0]['last_name'] ?? '';
          job = data[0]['job'] ?? '';
          ndays = data[0]['ndays'] ?? '';
          adres = data[0]['adres'] ?? '';
          driver_booking_date = data[0]['driver_booking_date'] ?? '';
          driver_booking_time = data[0]['driver_booking_time'] ?? '';
          status = data[0]['status'] ?? '';

          usid = data[0]['_id'] ?? '';
          print('objectdfs $profilepic');
        });
      } else {
        Fluttertoast.showToast(
          msg: 'No data found for the user',
          backgroundColor: Colors.grey,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch user data',
        backgroundColor: Colors.grey,
      );
    }
  }
  Future<void> _viewPro2() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? '');
      login_idf = prefs.getString('login_id') ?? '';
    });
String gp=login_idf.replaceAll('"', '');
print("object$gp");

    var res = await Api().getData('/driver_booking/viewdriverg/$gp');
    var body = json.decode(res.body);
    print("response body: $body");

    if (body != null && body['success'] == true) {
      setState(() {
        profilepic = body['data'][0]['profilepic'];
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch user data',
        backgroundColor: Colors.grey,
      );
    }
  }

  Future approveUser(String id) async {



    print('object $id');
    var response = await Api().getData('/driver_booking/driveraccept/$id');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print("body${items}");
      print("approve status${items}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Driverhome()));

      Fluttertoast.showToast(
        msg: "accepted",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error",
      );
    }
  }
  Future declineUser(String id) async {



    print('object $id');
    var response = await Api().getData('/driver_booking/driverdecline/$id');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print("body${items}");
      print("approve status${items}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Driverhome()));

      Fluttertoast.showToast(
        msg: "accepted",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error",
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
                      'Hello, ${username.replaceAll('"', '')}',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Take a ride?',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ()));
                // },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
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
            padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                        color: Colors.red,
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
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Expanded(
              child: Container(
                height: 5.0,
                color: Colors.black87.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "User Request",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              color: Colors.grey.withOpacity(0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.withOpacity(0.8), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "name",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4.0),
                    Text(
                      first_name,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),Text(
                      "Job Details:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4.0),
                    Text(
                      job,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Adress:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      adres,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Preferred Date:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      driver_booking_date,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Number of days for rent:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      ndays,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButton(
                            onPressed: () {
                             declineUser(usid);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // Background color
                            ),
                            child: Text('Decline'),
                          ),
                        ),
                        SizedBox(
                          width:150 ,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              approveUser(usid);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // Background color
                            ),
                            child: Text('Accept'),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
