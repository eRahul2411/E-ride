import 'dart:convert';
import 'package:eride/Admin/model/usermodel.dart';
import 'package:eride/api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  late SharedPreferences prefs;
  late String user_id;

  Future<List<UserModel>> fetchuser() async {
    var response = await Api().getData('/register/view-users');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<UserModel> products = List<UserModel>.from(
          items['data'].map((e) => UserModel.fromJson(e)).toList());
      return products;
    } else {
      List<UserModel> products = [];
      return products;
    }
  }


  Future<List<UserModel>> fetchtaxi() async {
    var response = await Api().getData('/register/view-taxi');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<UserModel> products = List<UserModel>.from(
          items['data'].map((e) => UserModel.fromJson(e)).toList());
      return products;
    } else {
      List<UserModel> products = [];
      return products;
    }
  }
  Future<List<UserModel>> fetchdriver() async {
    var response = await Api().getData('/register/view-driver');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<UserModel> products = List<UserModel>.from(
          items['data'].map((e) => UserModel.fromJson(e)).toList());
      return products;
    } else {
      List<UserModel> products = [];
      return products;
    }
  }
  Future<List<UserModel>> fetchuserstaus() async {
    var response = await Api().getData('/register/viewstatus-users');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<UserModel> products = List<UserModel>.from(
          items['data'].map((e) => UserModel.fromJson(e)).toList());
      return products;
    } else {
      List<UserModel> products = [];
      return products;
    }
  }
  Future<List<UserModel>> fetchdriverstaus() async {
    var response = await Api().getData('/register/viewstatus-driver');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<UserModel> products = List<UserModel>.from(
          items['data'].map((e) => UserModel.fromJson(e)).toList());
      return products;
    } else {
      List<UserModel> products = [];
      return products;
    }
  }
  Future<List<UserModel>> fetchtaxistaus() async {
    var response = await Api().getData('/register/viewstatus-taxi');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print((items));

      List<UserModel> products = List<UserModel>.from(
          items['data'].map((e) => UserModel.fromJson(e)).toList());
      return products;
    } else {
      List<UserModel> products = [];
      return products;
    }
  }




}
