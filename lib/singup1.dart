import 'package:eride/driver/singdriver.dart';
import 'package:eride/login.dart';
import 'package:eride/user/singuser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Singup1 extends StatefulWidget {
  const Singup1({Key? key}) : super(key: key);

  @override
  State<Singup1> createState() => _Singup1State();
}

class _Singup1State extends State<Singup1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      appBar: AppBar(
        // Overide the default Back button
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp,color: Colors.redAccent,),
          label: const Text('Back',style: TextStyle(color:Colors.red )),
          style: ElevatedButton.styleFrom(

            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // other stuff

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
            child: Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/banner.png"),fit: BoxFit.cover),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // background
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
// foreground
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>singuser()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "As User",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey, // background
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
// foreground
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>singdriver()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.drive_eta),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "As Driver",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: "Already have a account? ",
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
                children:  <TextSpan>[
                  TextSpan(text: 'login', style: TextStyle(fontWeight: FontWeight.bold),
    recognizer: TapGestureRecognizer()
    ..onTap = () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
    }),

                ],
              ),
            ),
          )
  ],
      ),
    );
  }
}
