import 'package:eride/user/Carrent3.dart';
import 'package:flutter/material.dart';

class Carrent2 extends StatefulWidget {
  const Carrent2({Key? key}) : super(key: key);

  @override
  State<Carrent2> createState() => _Carrent2State();
}

class _Carrent2State extends State<Carrent2> {
  final List<Map<String, dynamic>> cars = [
    {
      'name': 'Car 1',
      'picture': 'images/download.jpeg',
      'details': 'take the ride .',
      'rentPrice': '50\$',
      'location': 'New York',
      'automated': 'true',
      'seats': '4',
      'engineType': 'Gasoline',
    },
    {
      'name': 'Car 2',
      'picture': 'images/istockphoto.jpg',
      'details':
      ' feel the car .',
      'rentPrice': '60\$',
      'location': 'Los Angeles',
      'automated': 'false',
      'seats': '5',
      'engineType': 'Diesel',
    },
    {
      'name': 'Car 3',
      'picture': 'images/images (2).jpeg',
      'details':
      'nice and wonder car.',
      'rentPrice': '70\$',
      'location': 'Miami',
      'automated': 'true',
      'seats': '2',
      'engineType': 'Electric',
    },
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
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {


          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {

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

                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 150,
                              child: Stack(
                                children: [

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

                                  SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

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
