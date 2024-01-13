import 'package:flutter/material.dart';

class Smoking extends StatefulWidget {
  const Smoking({Key? key}) : super(key: key);

  @override
  _SmokingState createState() => _SmokingState();
}

class _SmokingState extends State<Smoking> {
  int _selectedValue = 0;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Music",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                RadioListTile(
                  value: 0,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value as int;
                    });
                  },
                  title: Text("I’m fine with smoking"),
                  secondary: Icon(Icons.smoking_rooms,color: Colors.green),
                  activeColor: Colors.blue,
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value as int;
                    });
                  },
                  title: Text("Cigarette breaks outside the car are ok"),
                  secondary: Icon(Icons.smoking_rooms,color: Colors.green),
                  activeColor: Colors.blue,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value as int;
                    });
                  },
                  title: Text("Please, no smoking in the car"),
                  secondary: Icon(Icons.smoke_free,color: Colors.green),
                  activeColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}