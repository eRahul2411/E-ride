import 'dart:convert';

import 'package:eride/Admin/Detailsuser.dart';
import 'package:eride/Admin/model/usermodel.dart';
import 'package:eride/api/api.dart';
import 'package:eride/api/api_services.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Manageuser extends StatefulWidget {
  @override
  State<Manageuser> createState() => _ManageuserState();
}

class _ManageuserState extends State<Manageuser> {
  List _loadprooducts = [];

  String uid='';

  final List<String> containerImages = [
    'images/ava3.png',
    'images/ava3.png',
    'images/ava3.png',
    'images/ava3.png',
  ];

  final List<String> entries1 = ['shamli ', 'fazi'];

  final List<String> userIds = ['001', '002'];

  final List<String> entries = ['vishnu', 'lis', 'Gen', 'raj'];

  final List<String> userIds2 = ['007', '008','009','003'];

  ApiService client = ApiService();

  Future approveUser(String userid) async {
    print("u ${userid}");
    var response = await Api().getData('/register/approve/'+userid);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print("approve status${items}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Manageuser()));
      Fluttertoast.showToast(
        msg: "Approved",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error",
      );
    }
  }

  Future reject(String userid) async {
    print("u ${userid}");
    var response = await Api().getData('/register/reject/'+userid);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print("approve status${items}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Manageuser()));
      Fluttertoast.showToast(
        msg: "reject",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error",
      );
    }
  }

  late String userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_left_sharp, color: Colors.green),
            label: const Text(
              'Back',
              style: TextStyle(color: Colors.green),
            ),
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
          Text(
          'Request',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        FutureBuilder<List<UserModel>>(
            future: client.fetchuser(),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount:  snapshot.data!.length,

                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                     var userid=snapshot.data![index].lid;
                     print(userid);
                    return  GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailsuser(userid: userid)));},

                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("server/public/images/"+snapshot.data![index].profilepic),
                        ),
                        title: Text(
                          snapshot.data![index].fname,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        subtitle: Text(
                          'ID: ${snapshot.data![index].lid}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  approveUser(userid);

                                });

                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {

                                setState(() {
                                  reject(userid);
                                });
                              },
                            ),

                          ],
                        ),
                        tileColor: Colors.grey.withOpacity(0.4),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                );
              }
              return Center(child: CircularProgressIndicator());
            } ),


                  Divider(
                  thickness: 2,
                  color: Colors.black,
                  ),
                  Text(
                  'All User',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),

            FutureBuilder<List<UserModel>>(
              future: client.fetchuserstaus(),
              builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var uid = snapshot.data![index].lid; // Retrieve the UID for the current index
                      print("selected user $uid");
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Detailsuser(userid: uid)),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("server/public/images/"+snapshot.data![index].profilepic),
                          ),
                          title: Text(
                            snapshot.data![index].fname,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          subtitle: Text(
                            'ID: ${snapshot.data![index].lid}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // Handle delete button pressed
                              _showDeleteConfirmationDialog(context, index);
                            },
                          ),
                          tileColor: Colors.grey.withOpacity(0.4),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),


          ],
                  ),
                  );
                }

                void _showDeleteConfirmationDialog(
                BuildContext context, int index) async {
        return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
        return AlertDialog(
        title: const Text('Delete User'),
        content: SingleChildScrollView(
        child: ListBody(
        children: const <Widget>[
        Text('Are you sure you want to delete this user?'),
        ],
        ),
        ),
        actions: <Widget>[
        TextButton(
        child: const Text('Cancel'),
        onPressed: () {
        Navigator.of(context).pop();
        },
        ),
        TextButton(
        child: const Text('Delete'),
        onPressed: () {
        // Perform delete operation
        _deleteUser(index);
        Navigator.of(context).pop();
        },
        ),
        ],
        );
        },
        );
        }

            void _deleteUser(int index) {


  }

    void _declineUser(int index) {


    }
}
