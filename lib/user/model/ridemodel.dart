import 'dart:ffi';

class ridemodel {
  final String shareid;
  final String gender;
  //
  final String email;
  final String Phone_no;
  // final int last_name;
  final String first_name;
  final String profilepic;

  ridemodel({
    required this.shareid,
    required this.gender,
    required this.email,
    required this.Phone_no,
    // required this.last_name,
    required this.first_name,
    required this.profilepic,
  });

  factory ridemodel.fromJson(Map<String, dynamic> json) {
    return ridemodel(
      profilepic: json['profilepic'] ?? "", // Provide a default value for null
      first_name: json['first_name'] ?? "",
      shareid: json['shareID'] ?? "",
      gender: json['gender'] ?? "",
      email: json['email'] ?? "",
      Phone_no: json['Phone_no'] ?? "",
      // last_name: json['last_name'] ?? "",
    );
  }
}
