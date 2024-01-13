import 'package:flutter/material.dart';

class Minibio extends StatefulWidget {

   Minibio({Key? key}) : super(key: key);


  @override
  State<Minibio> createState() => _MinibioState();
}

class _MinibioState extends State<Minibio> {
  void clearText() {
    fieldText.clear();
  }
  final fieldText = TextEditingController();
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
        SizedBox(
        height: 50,
      ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'What would you like other members to know about you?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8,top:15),
            child: TextFormField(
              maxLines: 10,
              minLines: 5,
              decoration: InputDecoration(

                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Example:"Im a student at Delhi Univerity ,and I often visit friends in jaipur.I love photography and rock music "',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: clearText,
              ),



            ),
              controller: fieldText,
          )
          ),
           SizedBox(
             height: 10,
           ),
           ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
            ),
            child: Text('Submit'),
          ),
        ],
      )

    );
  }
}
