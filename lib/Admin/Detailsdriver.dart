import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.blue[500], fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}


class Detaildriver extends StatefulWidget {
  final String userid;

  Detaildriver({required this.userid});

  @override
  State<Detaildriver> createState() => _DetaildriverState();
}

class _DetaildriverState extends State<Detaildriver> {
  late String loginid;
  String first_name = "";
  String Phone_no = "";
  String last_name = "";
  String address = "";
  String email = "";
  String gender = "";
  String username = "";
  String idcard = "";
  String idcardimag = "";
  String profilepic = "";

  late SharedPreferences prefs;

  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    var res = await Api().getData('/register/viewselect-driver/'+widget.userid);
    var body = json.decode(res.body);
    print("body${body}");
    setState(() {
      first_name = body['data'][0]['first_name'];
      Phone_no = body['data'][0]['Phone_no'];
      last_name = body['data'][0]['last_name'];
      address = body['data'][0]['address'];
      email = body['data'][0]['email'];
      gender = body['data'][0]['gender'];
      username = body['data'][0]['username'];
      idcard = body['data'][0]['idcard'];
      idcard = body['data'][0]['idcard'];
      idcardimag = body['data'][0]['idcardimag'];
      profilepic = body['data'][0]['profilepic'];
      print("img${idcardimag}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp, color: Colors.redAccent),
          label: const Text(
            'Back',
            style: TextStyle(color: Colors.redAccent),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("server/public/images/"+profilepic),
                radius: 65,
              ),
            ),
            SizedBox(height: 1,),
            Container(
              padding: const EdgeInsets.only(top: 20.0, left: 2, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Set container background color
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.all(16.0),
              // Set container padding
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'ID:',
                          style: TextStyle(fontSize: 16, color: Colors.red[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          username,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'First Name:',
                          style: TextStyle(fontSize: 16, color: Colors.red[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          first_name,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'Last Name:',
                          style: TextStyle(fontSize: 16, color: Colors.red[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          last_name,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(fontSize: 16, color: Colors.red[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          email,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'Mobile number:',
                          style: TextStyle(fontSize: 16, color: Colors.red[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Phone_no,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'Gender:',
                          style: TextStyle(fontSize: 16, color: Colors.red[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          gender,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'Id card:',
                          style: TextStyle(fontSize: 16, color: Colors.green[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          idcard,
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 500,
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("server/public/images/" + idcardimag),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 18),
                    child: Row(
                      children: [
                        Text(
                          'Address:',
                          style: TextStyle(fontSize: 16, color: Colors.green[500],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            address,
                            style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
