import 'package:eride/user/Addcarrent.dart';
import 'package:eride/user/Carrent2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carrent extends StatefulWidget {
  @override
  State<Carrent> createState() => _CarrentState();
}

class _CarrentState extends State<Carrent> {

  String? _startingPlace;
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
    // Add other districts here...
  ];

  late SharedPreferences prefs;
  String username = "";
  String login_id = "";
  void initState() {
    super.initState();

    fetchuser();
  }
  fetchuser()async{
    prefs = await SharedPreferences.getInstance();
    username = (prefs.getString('username') ?? '');
    login_id = prefs.getString('login_id') ?? '';
    print("usr${username}");
    print("usr${login_id}");



  }
  final TextEditingController _searchController = TextEditingController();
  String searchValue = ''; // Variable to store the search value

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch() {
    setState(() {
      searchValue = _searchController.text;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Carrent2(searchValue: searchValue,login_id:login_id)),
    );
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
          label: const Text('Back', style: TextStyle(color: Colors.redAccent)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TypeAheadFormField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
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
                    _searchController.text = suggestion!;
                    _startingPlace = suggestion; // Store the selected starting place
                  });
                },
                validator: (value) {
                  return value != null && value.isEmpty ? 'Please select a district' : null;
                },
                autovalidateMode: AutovalidateMode.always, // Trigger validation on focus change
              ),
            ),
          ),
          Container(
            width: 310,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: performSearch, // Call performSearch() when "search" button is pressed
              child: Text("search"),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addcarrent()),
            );
          },
          child: Icon(Icons.car_rental),
        ),
      ),
    );
  }
}
