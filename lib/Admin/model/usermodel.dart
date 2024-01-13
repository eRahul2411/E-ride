class UserModel{
  final String fname;
  final String id;
  final String lname;
  final String lid;
  final String idcardimag;
  final String profilepic;


  UserModel({required this.fname,
    required this.id,
    required this.lname,
    required this.lid,
    required this.idcardimag,
    required this.profilepic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fname: json['first_name'],
      lname: json['last_name'],
      lid: json['id'],
      idcardimag: json['idcardimag'],
      profilepic: json['profilepic'],

    );
  }
}