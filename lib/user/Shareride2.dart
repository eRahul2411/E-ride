import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

class Shareride2 extends StatefulWidget {
  const Shareride2({Key? key}) : super(key: key);

  @override
  State<Shareride2> createState() => _Shareride2State();
}

class _Shareride2State extends State<Shareride2> {
  int simpleIntInput = 1;
  int steppedIntInput = 1;
  double simpleDoubleInput = 1;
  double steppedDoubleInput = 1;

  @override
  Widget build(BuildContext context) {

        return SafeArea(
            child: Scaffold(
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
                body: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QuantityInput(
                              label: 'Simple int input',
                              value: simpleIntInput,
                              onChanged: (value) => setState(() => simpleIntInput = int.parse(value.replaceAll(',', '')))
                          ),


                        ]
                    )
                )
            )
        );
  }
}
