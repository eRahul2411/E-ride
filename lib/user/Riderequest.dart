import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/user/homepage.dart';
import 'package:eride/user/model/ridemodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Riderequest extends StatefulWidget {
  final String axi;
  const Riderequest({required this.axi});

  @override
  State<Riderequest> createState() => _RiderequestState();
}

class _RiderequestState extends State<Riderequest> {
  bool _isLoading = false;
  void initState() {
    super.initState();
    fetchcart();

  }


  Future<List<ridemodel>> fetchcart() async {
    String mid = widget.axi.replaceAll('"', '');
    var response =
    await Api().getData('/shareride/shareride5/${widget.axi.replaceAll('"', '')}');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      List<ridemodel> products = List<ridemodel>.from(
          items['data'].map((e) => ridemodel.fromJson(e)).toList());
      setState(() {
        // Update the state with the retrieved data
        // You can store it in a List or other variables as needed
        // Example: myList = products;
      });
      return products;
    } else {
      List<ridemodel> products = [];
      return products;
    }
  }
  @override




  Future approveUser(String shareid) async {
    print("u ${shareid}");
    var response = await Api().getData('/shareride/rideacc/'+ shareid);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print("approve status${items}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Homeuser()));
      Fluttertoast.showToast(
        msg: "Approved",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error",
      );
    }
  }

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
      body: FutureBuilder<List<ridemodel>>(
        future: fetchcart(),
        builder: (BuildContext context, AsyncSnapshot<List<ridemodel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                String m=snapshot.data![index].shareid;
print("object $m");
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                              padding: const EdgeInsets.only(left: 16.0, bottom: 15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      // onTap: () {
                                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>_buildProfilePage()));
                                      // },
                                      child: CircleAvatar(
                                        backgroundImage:
                                        AssetImage("server/public/images/" + snapshot.data![index].profilepic),
                                        radius: 30.0,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data![index].first_name,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text('Email:${snapshot.data![index].email}'),
                            Text('Phone number:${snapshot.data![index].Phone_no}'),
                            Text('Gender:${snapshot.data![index].gender}'),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  approveUser(snapshot.data![index].shareid..replaceAll('"', ''));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                child: Text(
                                  'accept',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
