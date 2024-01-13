import 'dart:convert';

import 'package:eride/api/api.dart';
import 'package:eride/user/Takeride.dart';
import 'package:eride/user/Takeuser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Takeride3 extends StatefulWidget {
  final String sid;
  const Takeride3({ required this.sid});

  @override
  State<Takeride3> createState() => _Takeride3State();
}

class _Takeride3State extends State<Takeride3> {

 String starting_place ='';
 String ending_place ='';
 String starting_time ='';
 String person ='';
 String starting_placedis ='';
 String ending_placedis ='';
 String status ='';
 String date ='';
 String first_name ='';
 String last_name ='';
 String sid ='';
 String date1 ='';
 String login_id ='';
 String price ='';
 bool  _isLoading = false;

 final String userPhotoUrl = 'https://example.com/user_photo.jpg'; // Replace with the user's photo URL

  @override
  void initState() {
    super.initState();
    _viewPro();

  }
 late SharedPreferences prefs;
  Future<void> _viewPro() async {


    String mid = widget.sid.replaceAll('"', '');
    print("user selected id is $mid");

    var res = await Api().getData('/shareride/sharerideview/$mid');
    var body = json.decode(res.body);
    print("response body: $body");

    if (body != null && body['success'] == true) {
      setState(() {
        first_name = body['data'][0]['first_name'];
        starting_place = body['data'][0]['starting_place'];
        last_name = body['data'][0]['last_name'];
        ending_place = body['data'][0]['ending_place'];
        starting_time = body['data'][0]['starting_time'];
        person = body['data'][0]['person'];
        starting_placedis = body['data'][0]['starting_placedis'];
        ending_placedis = body['data'][0]['ending_placedis'];

        sid = body['data'][0]['_id'];
        date1 = body['data'][0]['date'];
        price = body['data'][0]['price'];

      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch user data',
        backgroundColor: Colors.grey,
      );
    }
  }
 void registerUser() async {
   // Check if an image is selected
   prefs = await SharedPreferences.getInstance();

   login_id = prefs.getString('login_id') ?? '';
print("ds$login_id");
   print("dsds $sid");
   setState(() {
     _isLoading = true;
   });

   var data = {
     "user_id":login_id.replaceAll('"', ''),
     "shareid": sid,


   };
   var res = await Api().authData(data,'/shareride/takeride2');
   var body = json.decode(res.body);

   if(body['success']==true)
   {

     print(body);
     Fluttertoast.showToast(
       msg: body['message'].toString(),
       backgroundColor: Colors.grey,
     );

     Navigator.push(
       this.context, //add this so it uses the context of the class
       MaterialPageRoute(
         builder: (context) => Takeride(),
       ), //MaterialpageRoute
     );


   }
   else
   {
     Fluttertoast.showToast(
       msg: body['message'].toString(),
       backgroundColor: Colors.grey,
     );

   }
 }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp, color: Colors.red),
          label: const Text('Back', style: TextStyle(color: Colors.red)),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              date1, // Replace with your desired date
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(

              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TimelineTile(

                    alignment: TimelineAlign.manual,
                    lineXY: 0,
                    isFirst: true,
                    endChild: Container(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              starting_placedis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              starting_place,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    beforeLineStyle: LineStyle(
                      color: Colors.blue,
                      thickness: 6,
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 40,
                      height: 40,
                      indicator: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0,
                    isLast: true,
                    endChild: Container(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ending_placedis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ending_place,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    beforeLineStyle: LineStyle(
                      color: Colors.orange,
                      thickness: 6,
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 40,
                      height: 40,
                      indicator: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 9,
                    ),
                  ),
                ),

                SizedBox(height: 8,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price for 1 Passenger',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs $price',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8,),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Divider(

                      color: Colors.grey[300],
                      thickness: 9,
                    ),
                  ),
                ),

                SizedBox(height: 8,),

              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Takeuser()));
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  first_name,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Rating:5.0/5',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 145),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Takeuser()));
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userPhotoUrl),
                            radius: 30.0,
                          ),

                        ),

                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      )

                    ],
                  ),

                SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.only(left: 18,right: 18),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ),

                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.only(left: 18,right: 18),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Contact ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'car',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'car',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 9,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Report ride',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),

                    ],
                  ),

              ],
            ),
          ),

          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: Text('Request'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
