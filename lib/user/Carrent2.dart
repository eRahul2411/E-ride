import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/user/Carrent3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carrent2 extends StatefulWidget {
  final String searchValue;
  final String login_id;

  Carrent2({required this.searchValue,required this.login_id});

  @override
  State<Carrent2> createState() => _Carrent2State();
}

class _Carrent2State extends State<Carrent2> {
  List<Map<String, dynamic>> cars = [];



  @override
  void initState() {


    super.initState();

    _viewPro();
  }

  Future<void> _viewPro() async {
print('habsfdh ${widget.login_id}');
print('habsfdh ${widget.searchValue}');
    var res = await Api().getData('/car/carfinb/${widget.searchValue}/${widget.login_id.replaceAll('"', '')}');
    var body = json.decode(res.body);
    setState(() {
      cars = (body['cars'] as List<dynamic>).cast<Map<String, dynamic>>();
      print(cars);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp, color: Colors.red),
          label: const Text('Back', style: TextStyle(color: Colors.redAccent)),
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
          String cname = car['name'] ?? '';
          String car_details = car['car_details'] ?? '';
          String cpicture = car['picture'] ?? '';
          String clocation = car['location'] ?? '';
          String cautomated = car['auto'] ?? '';
          String cseats = car['seat'] ?? '';
          String cengineType = car['petrol'] ?? '';
          String crentPrice = car['prize'] ?? '';
          String car_image = car['car_image'] ?? '';

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Carrent3(
                      cname: cname,
                      cprice: car_details,
                      cpicture: cpicture,
                      clocation: clocation,
                      cautomated: cautomated,
                      cseats: cseats,
                      car_image: car_image,
                      cengineType: cengineType,
                      crentPrice: crentPrice, clication: '',
                    ),
                  ),
                );
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
                    Text(
                      cname,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 150,
                      child: Stack(
                        children: [
                          Image.asset(
                            "server/public/images/" + car_image,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location: $car_details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(clocation),
                          SizedBox(height: 8),
                          Text('Automated: $cautomated'),
                          Text('Seats: $cseats'),
                          Text('Engine Type: $cengineType'),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rent Price:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(crentPrice),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
