import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/user/Carrent3.dart';
import 'package:eride/user/Takeride3.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Takeride2 extends StatefulWidget {
  final String start ; // Variable to store the search value
  final String end ;
  final String person ;
  final String date2 ;
  final String login_id ;
  Takeride2({required this.start,required this.end,required this.person,required this.date2,required this.login_id,});


  @override
  State<Takeride2> createState() => _Takeride2State();
}

class _Takeride2State extends State<Takeride2> {
  String id="";
  String district1="";
  String district2="";
  String date="";
  List<Map<String, dynamic>> cars = [];
  @override
  void initState() {
    print('start${widget.start}');
    print('end${widget.end}');
    print('person${widget.person}');
    print('date2${widget.date2}');
    print('id${widget.login_id}');

    super.initState();
    _viewPro();
  }


  Future<void> _viewPro() async {
id=widget.login_id.replaceAll('"', '');
district1=widget.start;
district2=widget.end;
date=widget.date2;

print("object $id");
print("object $district1");
print("object $district2");
print("object $date");
    var res = await Api().getData('/shareride/shareridesearch/${district1}/${district2}/${date}/${id}');
    var body = json.decode(res.body);
    setState(() {
      cars  = (body['cars'] as List<dynamic>).cast<Map<String, dynamic>>();
      print(cars);
    });
  }
  final String userPhotoUrl = 'https://example.com/user_photo.jpg'; // Replace with the user's photo URL



  List<String> rate1=
  [
    '600','700',
  ];


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp, color: Colors.red),
          label: const Text('Back', style: TextStyle(color: Colors.red)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: cars.length,

        itemBuilder: (BuildContext context, int index) {

          final car = cars[index];
          String starting_place = car['starting_place'] ?? '';
          String ending_place = car['ending_place'] ?? '';
          String starting_time = car['starting_time'] ?? '';
          String person = car['person'] ?? '';
          String starting_placedis = car['starting_placedis'] ?? '';
          String ending_placedis = car['ending_placedis'] ?? '';
          String date = car['date'] ?? '';
          String price = car['price'] ?? '';
          String sid = car['_id'] ?? '';



          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>Takeride3(sid:sid)));

                      },
                      child: Container(

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TimelineTile(

                                alignment: TimelineAlign.manual,
                                lineXY: 0,
                                isFirst: true,
                                endChild: Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,top: 8,right: 8),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '₹ ${rate1[index]}  ' ,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text( starting_placedis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          starting_place,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                beforeLineStyle: LineStyle(
                                  color: Colors.black,
                                  thickness: 6,
                                ),
                                indicatorStyle: IndicatorStyle(
                                  width: 40,
                                  height: 40,
                                  indicator: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0,
                                isLast: true,
                                endChild: Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          ending_placedis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          ending_place,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                beforeLineStyle: LineStyle(
                                  color: Colors.black,
                                  thickness: 6,
                                ),
                                indicatorStyle: IndicatorStyle(
                                  width: 40,
                                  height: 40,
                                  indicator: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 16.0,bottom: 15),
                              child: Row(

                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      // onTap: () {
                                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>_buildProfilePage()));
                                      // },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(userPhotoUrl),
                                        radius: 20.0,
                                      ),

                                    ),

                                  ),

                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'User',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          'Rating:5.0/5',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),




                                ],
                              ),
                            ),



                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

