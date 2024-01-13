import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:eride/api/api.dart';
import 'package:eride/user/Share1.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StartRidePage extends StatefulWidget {
  const StartRidePage({Key? key}) : super(key: key);

  @override
  State<StartRidePage> createState() => _StartRidePageState();
}

class _StartRidePageState extends State<StartRidePage> {
  List<String> keralaDistricts = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad',
    'Bangaloor',

    // Add other districts here...
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _startingPlaceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _starting_placedisController = TextEditingController();
  final TextEditingController _ending_placedisController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late DateTime date;
  String? _startingPlace; // Store selected starting place
  String? username = "";
  String? login_id = "";
  bool _isLoading = false;
  late SharedPreferences prefs;
  DateTime currentDate = DateTime.now();
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void dispose() {
    _startingPlaceController.dispose();
    _destinationController.dispose();
    _timeController.dispose();
    _personController.dispose();
    _starting_placedisController.dispose();
    _ending_placedisController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> fetchUser() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      login_id = prefs.getString('login_id');
    });
    print("username: $username");
    print("login_id: $login_id");
  }

  void startRide() async {
    String formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    String formattedTime = "${currentTime.hour}:${currentTime.minute}:${currentTime.second}";

    setState(() {
      _isLoading = true;
    });

    var data = {
      "user_id": login_id?.replaceAll('"', ''),
      "starting_place": _startingPlaceController.text,
      "ending_place": _destinationController.text,
      "ending_placedis": _ending_placedisController.text,
      "starting_placedis": _starting_placedisController.text,
      "starting_time": _timeController.text,
      "person": _personController.text,
      "posting_date": formattedDate,
      "posting_tim": formattedTime,
      "price": _priceController.text, // Extract text value from the TextEditingController
      "date": _dateController.text, // Extract text value from the TextEditingController
    };
    print(data);
    var res = await Api().authData(data, '/shareride/shareride1');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Share1()));
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

  String? _validateStartingPlace(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a district';
    }
    if (!keralaDistricts.contains(value)) {
      return 'Invalid district name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                'Share a ride!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red[300]?.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TypeAheadFormField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _starting_placedisController,
                        decoration: const InputDecoration(
                          labelText: 'Starting Place district',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return keralaDistricts.where((district) => district.toLowerCase().contains(pattern.toLowerCase()));
                      },
                      itemBuilder: (BuildContext context, String? suggestion) {
                        return ListTile(
                          title: Text(suggestion!),
                        );
                      },
                      onSuggestionSelected: (String? suggestion) {
                        setState(() {
                          _starting_placedisController.text = suggestion!;
                          _startingPlace = suggestion; // Store the selected starting place
                        });
                      },
                      validator: (value) {
                        return value != null && value.isEmpty ? 'Please select a district' : null;
                      },
                      autovalidateMode: AutovalidateMode.always, // Trigger validation on focus change
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _startingPlaceController,
                      decoration: const InputDecoration(
                        labelText: 'Starting place adress',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Starting place adress';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16.0),
                    TypeAheadFormField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _ending_placedisController,
                        decoration: const InputDecoration(
                          labelText: 'destination Place district',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return keralaDistricts.where((district) => district.toLowerCase().contains(pattern.toLowerCase()));
                      },
                      itemBuilder: (BuildContext context, String? suggestion) {
                        return ListTile(
                          title: Text(suggestion!),
                        );
                      },
                      onSuggestionSelected: (String? suggestion) {
                        setState(() {
                          _ending_placedisController.text = suggestion!;
                          _startingPlace = suggestion; // Store the selected starting place
                        });
                      },
                      validator: (value) {
                        return value != null && value.isEmpty ? 'Please select a district' : null;
                      },
                      autovalidateMode: AutovalidateMode.always, // Trigger validation on focus change
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _destinationController,
                      decoration: const InputDecoration(
                        labelText: 'destination place adress',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Starting place adress';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: ' enter the fair price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a fair for ride';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _timeController,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a time';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _personController,
                      decoration: const InputDecoration(
                        labelText: 'number of person',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of person';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DateTimeField(
                      controller: _dateController,
                      onChanged: (value) {
                        setState(() {
                          date = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                          return DateTimeField.combine(
                            date,
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        if (_formKey.currentState!.validate()) {
                          startRide();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        minimumSize: const Size(double.infinity, 60.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Existing code for "Take a ride" button
                    // Existing code for "Start a ride" button
                    const SizedBox(height: 100.0),
                    Text(
                      'Wishing you a happy and unforgettable journey!',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'images/icons8-carpool-64.png', // Replace with your desired image path
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
