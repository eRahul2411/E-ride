import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/api/api_services.dart';
import 'package:eride/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Driverprofile extends StatefulWidget {
  const Driverprofile({Key? key}) : super(key: key);

  @override
  State<Driverprofile> createState() => _DriverprofileState();
}

class _DriverprofileState extends State<Driverprofile>
    with SingleTickerProviderStateMixin {
  final _formKey3 = GlobalKey<FormState>();
  String confirmPassword = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
  String username = "";
  String login_id = "";
  String login_id1 = "";
  String log = "";
  String profilepic = "";

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();

      username = (prefs.getString('username') ?? '');
      login_id = prefs.getString('login_id') ?? '';


    print("usr${username}");
    print("usr${login_id}");

    print("usssssssssssr${log}");

    print("user selected id is $login_id");
    print("user selected id is $login_id");
    String mid = login_id.replaceAll('"', '');
    print("user selected id is $mid");

    var res = await Api().getData('/driver_booking/viewdriverg/$mid');
    var body = json.decode(res.body);
    print("response body: $body");

    if (body != null && body['success'] == true) {
      setState(() {
        first_name = body['data'][0]['first_name'];
        Phone_no = body['data'][0]['Phone_no'];
        last_name = body['data'][0]['last_name'];
        address = body['data'][0]['address'];
        email = body['data'][0]['email'];
        gender = body['data'][0]['gender'];
        username = body['data'][0]['username'];
        idcard = body['data'][0]['idcard'];
        _id = body['data'][0]['_id'];
        profilepic = body['data'][0]['profilepic'];
        idcardimag = body['data'][0]['idcardimag'];
        login_id1 = body['data'][0]['id'];
        emailController.text = email;
        phoneController.text = Phone_no;
        print('user id $_id');
        print('user id $login_id');
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch user data',
        backgroundColor: Colors.grey,
      );
    }
  }
  _update() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "email": emailController.text,
      "Phone_no": phoneController.text,

    };
    print(data);
    var res = await Api().authData(data, '/taxih/updatedriver/' + _id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Driverprofile(
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  _updatepass() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "password": passwordController.text,


    };
    print(data);
    var res = await Api().authData(data, '/taxih/updatetaxipass/' + login_id.replaceAll('"', ''));
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Driverprofile(
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  // Function to handle logout
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }



  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.red,
          tabs: const [
            Tab(text: 'Only Me'),
            Tab(text: 'Account'),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // Set your preferred background color or image
      body: TabBarView(
        controller: _tabController,
        children: [
          // Only Me content
          SingleChildScrollView(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            "server/public/images/" +
                                profilepic, // Replace with your profile picture
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: $username',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'UID: $_id',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(
                      color: Colors.red,
                      thickness: 2,
                    ),
                    const SizedBox(height: 16),
                    buildInfoRow("First Name", first_name),
                    buildInfoRow("Last Name", last_name),
                    buildInfoRow("Email", email),
                    buildInfoRow("Phone", Phone_no),
                    buildInfoRow("Address", address),
                    buildInfoRow("ID Card", idcard),
                    const SizedBox(height: 20),
                    Divider(
                      color: Colors.red,
                      thickness: 2,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Action for "Log Out" button
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GestureDetector(
                          onTap: _logout,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'LOG OUT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
            ),
          ),
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Name:',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                first_name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Action for "Edit profile picture" button
                            },
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage(
                                "server/public/images/" +
                                    profilepic, // Replace with your profile picture
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Form(
                          key: _formKey3, // Associate the form with the form key
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.red,
                                thickness: 2,
                              ),
                              Text(
                                'Contacts',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Email';
                                  }

                                  // Regular expression for basic email format validation
                                  String emailPattern = r'^[a-zA-Z0-9._%+-]+@gmail\.com$';
                                  RegExp regExp = RegExp(emailPattern);
                                  if (!regExp.hasMatch(value)) {
                                    return 'Please enter a valid Gmail address';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: "Enter Email",
                                  labelStyle: TextStyle(color: Colors.red),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                maxLength: 10,
                                controller: phoneController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Phone Number';
                                  }

                                  // Remove any non-digit characters and check the length
                                  String cleanedNumber = value.replaceAll(RegExp(r'\D'), '');
                                  if (cleanedNumber.length != 10) {
                                    return 'Phone Number should be exactly 10 digits';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: "Enter Phone Number",
                                  labelStyle: TextStyle(color: Colors.red),
                                  counterText: '',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: ElevatedButton(

                                  onPressed: () {
                                    // Validate the form
                                    if (_formKey3.currentState!.validate()) {
                                      // Perform the action when the form is valid (i.e., not null)
                                      // For example, you can save the email and phone number values
                                      // to the database or perform any other action here.
                                      _update();
                                    }
                                  },
                                  child: Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),

                      Divider(
                        color: Colors.red,
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Text(
                            'Change password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            onChanged: (value) {
                              // Handle the password change if needed
                            },
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm New Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (passwordController.text.isNotEmpty && confirmPassword.isNotEmpty) {
                                if (passwordController.text == confirmPassword) {
                                  _updatepass();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Profile changes saved successfully.'),
                                    ),
                                  );
                                } else {
                                  // Password and Confirm Password do not match, show an error message
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text('Passwords do not match. Please re-enter and try again.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                // Show an error message if passwords are empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please enter both new password and confirm password.'),
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            label: Text(
                              ' Change password',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create the info row with label and value
  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Wrap(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 16), // You can adjust the font size as needed
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}