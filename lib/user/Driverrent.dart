import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:eride/Admin/model/usermodel.dart';
import 'package:eride/api/api.dart';
import 'package:eride/api/api_services.dart';
import 'package:eride/user/DriverRequestPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Driver {
  final String name;
  final String photoUrl;
  final double rating;

  Driver({
    required this.name,
    required this.photoUrl,
    required this.rating,
  });
}
String dx="";

class Driverrent extends StatefulWidget {
  @override
  State<Driverrent> createState() => _DriverrentState();
}

class _DriverrentState extends State<Driverrent> {
  ApiService client = ApiService();

  final List<Driver> drivers = [
    Driver(
      name: 'max',
      photoUrl: 'images/images.jpg',
      rating: 4.5,
    ),
    Driver(
      name: 'jack',
      photoUrl: 'images/images (1).jpg',
      rating: 4.2,
    ),
    Driver(
      name: 'jack',
      photoUrl: 'images/images (1).jpg',
      rating: 4.3,
    ), Driver(
      name: 'jack',
      photoUrl: 'images/images (1).jpg',
      rating: 4.1,
    ), Driver(
      name: 'jack',
      photoUrl: 'images/images (1).jpg',
      rating: 4.8,
    ),

    // Add more drivers here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp, color: Colors.green),
          label: const Text('Back', style: TextStyle(color: Colors.green)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: client.fetchdriverstaus(),
    builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot)
    {
      if (snapshot.hasData) {
        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var dx=snapshot.data![index].id;
            final driver = drivers[index];

         print('hiiiiiii$dx');
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage("server/public/images/"+snapshot.data![index].profilepic),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].fname,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              driver.rating.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DriverRequestPage(did:snapshot.data![index].id),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Text('Available Now'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
      return Center(child: CircularProgressIndicator());
    }

      ),
    );
  }
}
