// import 'package:flutter/material.dart';
// class Payment {
//   final String description;
//   final DateTime date;
//   final double amount;
//   final bool isDebited;
//
//   Payment({
//     required this.description,
//     required this.date,
//     required this.amount,
//     required this.isDebited,
//   });
// }
// class Pay extends StatefulWidget {
//   const Pay({Key? key}) : super(key: key);
//
//   @override
//   State<Pay> createState() => _PayState();
// }
//
//
// List<Payment> paymentHistory = [
//   Payment(
//     description: 'Payment 1',
//     date: DateTime.now(),
//     amount: 20.0,
//     isDebited: true,
//   ),
//   Payment(
//     description: 'Payment 2',
//     date: DateTime.now(),
//     amount: 15.0,
//     isDebited: false,
//   ),
//   Payment(
//     description: 'Payment 3',
//     date: DateTime.now(),
//     amount: 30.0,
//     isDebited: true,
//   ),
// ];
//
// List<Payment> filteredPayments =
//     paymentHistory; // Initialize with all payments
// bool? isDebitedFilter; // Selected filter option
//
// // Filter logic
// void filterPayments(bool? isDebited) {
//   setState(() {
//     isDebitedFilter = isDebited;
//     filteredPayments = isDebited == null
//         ? paymentHistory
//         : paymentHistory
//         .where((payment) => payment.isDebited == isDebited)
//         .toList();
//   });
// }
// class _PayState extends State<Pay> {
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//
//     body: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Padding(
//     padding: EdgeInsets.all(16.0),
//     child: Text(
//     'Wallet',
//     style: TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.bold,
//     ),
//     ),
//     ),
//     ListTile(
//     leading: Icon(Icons.account_balance_wallet),
//     title: Text('Balance: \$100'),
//     ),
//     Divider(),
//     Padding(
//     padding: EdgeInsets.all(16.0),
//     child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//     Text(
//     'Payment History',
//     style: TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.bold,
//     ),
//     ),
//     DropdownButton<bool?>(
//     value: isDebitedFilter,
//     hint: Text('Filter'),
//     items: [
//     DropdownMenuItem<bool?>(
//     value: null,
//     child: Text('All'),
//     ),
//     DropdownMenuItem<bool?>(
//     value: true,
//     child: Text('Debited'),
//     ),
//     DropdownMenuItem<bool?>(
//     value: false,
//     child: Text('Credited'),
//     ),
//     ],
//     onChanged: (value) {
//     filterPayments(value);
//     },
//     ),
//     ],
//     ),
//     ),
//     Expanded(
//     child: ListView.builder(
//     itemCount: filteredPayments.length,
//     itemBuilder: (context, index) {
//     final payment = filteredPayments[index];
//     final paymentType = payment.isDebited ? 'Debited' : 'Credited';
//     final paymentAmount = payment.isDebited
//     ? '-\$${payment.amount}'
//         : '+\$${payment.amount}';
//     final paymentColor =
//     payment.isDebited ? Colors.red : Colors.green;
//     return ListTile(
//     title: Text(payment.description),
//     subtitle: Text('Date: ${payment.date.toString()}'),
//     trailing: Text(
//     '$paymentType: $paymentAmount',
//     style: TextStyle(
//     color: paymentColor,
//     fontWeight: FontWeight.bold,
//     ),
//     ),
//     );
//     },
//     ),
//     ),
//     ],
//     )
//     );
//   }
// }
