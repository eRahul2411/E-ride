// import 'dart:convert';
//
// import 'package:eride/api/api.dart';
// import 'package:eride/api/api_services.dart';
// import 'package:eride/taxi/Taxihome.dart';
// import 'package:eride/taxi/model/taximodel/taximodel.dart';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class TaxiH extends StatefulWidget {
//   const TaxiH({super.key});
//
//   @override
//   State<TaxiH> createState() => _TaxiHState();
// }
//
// class _TaxiHState extends State<TaxiH> {
//   String amount = '';
//   void _showBottomSheet(String dx, String userid) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext ctx) {
//         return Padding(
//           padding: EdgeInsets.only(
//               top: 20,
//               left: 20,
//               right: 20,
//               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: TextFormField(
//                   controller: _distance,
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                   onChanged: (value) {
//                     // Calculate the fare amount when the distance is entered or changed
//                     double distance = double.tryParse(value) ?? 0.0;
//                     double fareAmount = distance * double.parse(dx);
//                     setState(() {
//                       amount = fareAmount.toStringAsFixed(2);
//                     });
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     hintText: 'Distance/km',
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Amount of km: $dx',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Estimated Fare:',
//                 style: TextStyle(fontSize: 16),
//               ),
//               Text(
//                 '\₹$amount',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   calculateFare(double.tryParse(_distance.text) ?? 0.0, double.parse(dx), userid);
//                   Navigator.pop(context); // Close the bottom sheet after calculating fare
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.black,
//                 ),
//                 child: Text('Calculate Fare'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//
//   void initState() {
//     super.initState();
//     _viewPro();
//
//   }
//
//   String first_name = "";
//   String Phone_no = "";
//   String last_name = "";
//   String address = "";
//   String email = "";
//   String gender = "";
//   String usernames = "";
//   String idcard = "";
//   String idcardimag = "";
//   String _id = "";
//   String mac = '';
//   ApiService client = ApiService();
//   String username = "";
//   String login_id = "";
//   String log = "";
//   String profilepic = "";
//   String pickup = "";
//   late SharedPreferences prefs;
//   double fareAmount = 0.0;
//   TextEditingController _distance = TextEditingController();
//   TextEditingController _peramount = TextEditingController();
//   Map<String, double> fareAmounts = {};
//
//   Future<void> _viewPro() async {
//
//     prefs = await SharedPreferences.getInstance();
//     username = (prefs.getString('username') ?? '');
//     login_id = prefs.getString('login_id') ?? '';
//     print("usr${username}");
//     print("usr${login_id}");
//
//     print("usssssssssssr${log}");
//
//     print("user selected id is $login_id");
//     print("user selected id is $login_id");
//     String mid = login_id.replaceAll('"', '');
//     print("user selected id is $mid");
//
//     var res = await Api().getData('/taxiride/viewtaxi/$mid');
//     var body = json.decode(res.body);
//     print("response body: $body");
//
//     if (body != null && body['success'] == true) {
//       setState(() {
//         first_name = body['data'][0]['first_name'];
//         Phone_no = body['data'][0]['Phone_no'];
//         last_name = body['data'][0]['last_name'];
//         address = body['data'][0]['address'];
//         email = body['data'][0]['email'];
//         gender = body['data'][0]['gender'];
//         username = body['data'][0]['username'];
//         idcard = body['data'][0]['idcard'];
//         _id = body['data'][0]['_id'];
//         profilepic = body['data'][0]['profilepic'];
//
//       });
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Failed to fetch user data',
//         backgroundColor: Colors.grey,
//       );
//     }
//   }
//
//   void calculateFare(double distanceInKm, double farePerKm, String userid) {
//     // Replace the farePerKm with the actual fare charged by taxi services in your area.
//     double fareAmount = distanceInKm * farePerKm;
//     setState(() {
//       fareAmounts[userid] = fareAmount;
//     });
//   }
//
//   Future approveUser(String userid) async {
//     double fareAmountForRequest = fareAmounts[userid] ?? 0.0;
//     if (fareAmountForRequest <= 0) {
//       Fluttertoast.showToast(
//         msg: "Please calculate the fare before accepting the request.",
//       );
//       return;
//     }
//
//     userid = userid;
//     var response = await Api().getData('/taxiride/accept/$userid/$_id/$fareAmountForRequest');
//     if (response.statusCode == 200) {
//       var items = json.decode(response.body);
//       print("body${items}");
//       print("approve status${items}");
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Taxihome()));
//
//       Fluttertoast.showToast(
//         msg: "accepted",
//       );
//     } else {
//       Fluttertoast.showToast(
//         msg: "Error",
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 24.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hello, ${first_name.replaceAll('"', '')}',
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       Text(
//                         'Accept request and make profit !',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 16.0),
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage("server/public/images/" + profilepic),
//                     radius: 30.0,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 24.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10),
//               child: Container(
//                 width: double.infinity,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     image: AssetImage('images/banner.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomRight,
//                       colors: [
//                         Colors.black.withOpacity(.6),
//                         Colors.black.withOpacity(.6),
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Text(
//                         "E-ride",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 35,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 25.0),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Container(
//                 height: 5.0,
//                 color: Colors.black87.withOpacity(0.8),
//               ),
//             ),
//             SizedBox(height: 25.0),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 "User Request",
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Card(
//                   color: Colors.grey.withOpacity(0.5),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     side: BorderSide(
//                       color: Colors.grey.withOpacity(0.8),
//                       width: 1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 10.0, left: 5, right: 5, bottom: 10),
//                     child: FutureBuilder<List<TaxiModel>>(
//                       future: client.fetchtaxiride(),
//                       builder: (BuildContext context, AsyncSnapshot<List<TaxiModel>> snapshot) {
//                         if (snapshot.hasData) {
//                           return Expanded(
//                             child: ListView.builder(
//                               itemCount: snapshot.data!.length,
//                               itemBuilder: (context, index) {
//                                 String dx = snapshot.data![index].pickup;
//                                 String userid = snapshot.data![index].id;
//                                 print('hi $userid');
//                                 return Expanded(
//                                   child: Card(
//                                     elevation: 4,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           leading: CircleAvatar(
//                                             radius: 30,
//                                             backgroundImage: AssetImage(
//                                               "server/public/images/" + snapshot.data![index].profilepic,
//                                             ),
//                                           ),
//                                           title: Text(
//                                             snapshot.data![index].fname,
//                                             style: TextStyle(
//                                               fontSize: 18.0,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           subtitle: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 'Address: ${snapshot.data![index].address}',
//                                                 style: TextStyle(
//                                                   fontSize: 14.0,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 2),
//                                               Text(
//                                                 'Destination: ${snapshot.data![index].destination}',
//                                                 style: TextStyle(
//                                                   fontSize: 14.0,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 2),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                           Icons.calendar_today,
//                                                           size: 14,
//                                                           color: Colors.grey.withOpacity(0.8),
//                                                         ),
//                                                         SizedBox(width: 4),
//                                                         Expanded(
//                                                           child: Text(
//                                                             'Date: ${snapshot.data![index].Date}',
//                                                             style: TextStyle(
//                                                               fontSize: 14.0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         SizedBox(width: 8),
//                                                         Icon(
//                                                           Icons.access_time,
//                                                           size: 14,
//                                                           color: Colors.grey.withOpacity(0.8),
//                                                         ),
//                                                         SizedBox(width: 4),
//                                                         Expanded(
//                                                           child: Text(
//                                                             'Time: ${snapshot.data![index].time}',
//                                                             style: TextStyle(
//                                                               fontSize: 14.0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 8),
//                                               Text(
//                                                 'Amount of km: $dx',
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                               SizedBox(height: 8),
//                                               Text(
//                                                 'Estimated Fare:',
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                               Text(
//                                                 '\₹${fareAmounts[userid] ?? 0.0}',
//                                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   _showBottomSheet(dx, userid);
//                                                 },
//                                                 style: ElevatedButton.styleFrom(
//                                                   primary: Colors.black,
//                                                 ),
//                                                 child: Text('Calculate Fare'),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   if (fareAmounts[userid] == null || fareAmounts[userid]! <= 0) {
//                                                     Fluttertoast.showToast(
//                                                       msg: "Please calculate the fare before accepting the request.",
//                                                     );
//                                                   } else {
//                                                     approveUser(userid);
//                                                   }
//                                                 },
//                                                 style: ElevatedButton.styleFrom(
//                                                   primary: Colors.black,
//                                                 ),
//                                                 child: Text('Accept'),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }
//                         return Center(child: CircularProgressIndicator());
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
