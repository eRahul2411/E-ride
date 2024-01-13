import 'package:flutter/material.dart';

class Rentalconditions extends StatefulWidget {
  const Rentalconditions({Key? key}) : super(key: key);

  @override
  State<Rentalconditions> createState() => _RentalconditionsState();
}

class _RentalconditionsState extends State<Rentalconditions> {
  @override
  List<Map<String, dynamic>> _items = [
    {
      "title" : "Driver's age",
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': "Driver's licence",
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Deposit and Credit card nformation ',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Insurance coverage ',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Fuel policy',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Mileage policy',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Conditions of optional extras',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Travel Restrictions',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Fees',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
    },
    {
      'title': 'Form(s)of ID ',
      'description':
          'This is the description of the item . Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'isExpanded': false
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ExpansionPanelList(
            elevation: 3,
            // Controlling the expansion behavior
            expansionCallback: (index, isExpanded) {
              setState(() {
                _items[index]['isExpanded'] = !isExpanded;
              });
            },
            animationDuration: Duration(milliseconds: 600),
            children: _items
                .map(
                  (item) => ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: item['isExpanded'] == true
                        ? Colors.cyan[100]
                        : Colors.white,
                    headerBuilder: (_, isExpanded) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        child: Text(
                          item['title'],
                          style: TextStyle(fontSize: 20),
                        )),
                    body: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text(item['description']),
                    ),
                    isExpanded: item['isExpanded'],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
