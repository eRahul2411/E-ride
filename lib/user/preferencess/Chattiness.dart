import 'package:flutter/material.dart';

class Chattiness extends StatefulWidget {
  const Chattiness({Key? key}) : super(key: key);

  @override
  _ChattinessState createState() => _ChattinessState();
}

class _ChattinessState extends State<Chattiness> {
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
                "Chattiness",
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
                  title: Text('I love to chat'),
                  secondary: Icon(Icons.chat,color: Colors.green),
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
                  title: Text("I'm chatty when I feel comfortable"),
                  secondary: Icon(Icons.sms,color: Colors.green),
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
                  title: Text("I'm the quit type"),
                  secondary: Icon(Icons.chat_bubble_outline,color: Colors.green),
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