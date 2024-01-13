import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:eride/Admin/model/usermodel.dart';
import 'package:eride/api/api.dart';
import 'package:eride/api/api_services.dart';
import 'package:eride/user/Driverrent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import the DriverRequestPage widget from the separate file.

class DriverRequestPage extends StatefulWidget {
  final String did;

  DriverRequestPage({required this.did});

  @override
  _DriverRequestPageState createState() => _DriverRequestPageState();
}

class _DriverRequestPageState extends State<DriverRequestPage> {
  TimeOfDay? selectedTime;
  bool _isLoading = false;
  DateTime? selectedDate;
  String first_name = "";
  String Phone_no = "";
  String last_name = "";
  String idcardimag = "";
  String _id = "";
  String login_id = "";
  String profilepic = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  @override
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
  void initState() {
    super.initState();
    _viewPro();
    fetchUser();
  }

  Future<void> _viewPro() async {
    String se = widget.did.replaceAll('"', '');
    print("user selected id is $se");

    var res = await Api().getData('/driver_booking/viewdriver/$se');
    var body = json.decode(res.body);
    print("response body: $body");

    if (body != null && body['success'] == true) {
      setState(() {
        first_name = body['data'][0]['first_name'];
        Phone_no = body['data'][0]['Phone_no'];
        last_name = body['data'][0]['last_name'];
        idcardimag = body['data'][0]['idcardimag'];
        idcardimag = body['data'][0]['idcardimag'];
        profilepic = body['data'][0]['profilepic'];
        _id = body['data'][0]['_id'];
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch user data',
        backgroundColor: Colors.grey,
      );
    }
  }

  fetchUser() async {
    prefs = await SharedPreferences.getInstance();
    login_id = prefs.getString('login_id') ?? '';
    print("usr$login_id");
  }

  final TextEditingController _numberofdaysController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController Date = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  void dispose() {
    _numberofdaysController.dispose();
    _destinationController.dispose();
    Date.dispose();
    _jobController.dispose();
    super.dispose();
  }

  void registerUser() async {

    setState(() {
      _isLoading = true;
    });
print('hoi  $login_id ');
print('hoi  $_id');
    var data = {
      "user_id": login_id.replaceAll('"', ''),
      "driver_id": _id,
      "driver_booking_date":Date.text,
      "driver_booking_time": selectedTime?.format(context),
      "ndays": _numberofdaysController.text,
      "adres": _destinationController.text,
      "job": _jobController.text,
    };
    print('Request data: $data');
    var res = await Api().authData(data, '/driver_booking/driver_booking');
    var body = json.decode(res.body);
    print('Response body: $body');
    if (body['success'] == true) {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => Driverrent(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }

    setState(() {
      _isLoading = false;
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("server/public/images/$profilepic"),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Driver Name: $first_name',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _jobController,
                  decoration: InputDecoration(
                    labelText: 'Job Details:',
                    filled: true,
                    fillColor: Colors.green[300]?.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Job Details:';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _numberofdaysController,
                  decoration: InputDecoration(
                    labelText: 'number of days',
                    filled: true,
                    fillColor: Colors.green[300]?.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the starting place';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),
                TextFormField(
                  controller: _destinationController,
                  decoration: InputDecoration(
                    labelText: 'adress',
                    filled: true,
                    fillColor: Colors.green[300]?.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the starting place';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Text(
                  'Availability:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DateTimeField(
                  controller: Date,
                  decoration: InputDecoration(

                    labelText: 'Date',
                    filled: true,
                    fillColor: Colors.green[300]?.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a date';
                    }
                    return null;
                  },
                  format: DateFormat('yyyy-MM-dd'),
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      return date;
                    } else {
                      return currentValue;
                    }
                  },
                  onChanged: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                SizedBox(height: 16),
                if (selectedDate != null)

                SizedBox(height: 16),

                // Add the time selection view part here using the Taxi logic

                Text(
                  'Selected Time: ${selectedTime?.format(context) ?? 'Not Selected'}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    'Select Time',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    primary: Colors.white,
                    backgroundColor: Colors.green[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),

                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Submit Request',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
