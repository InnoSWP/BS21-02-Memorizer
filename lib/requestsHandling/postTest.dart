import 'dart:convert';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


/**
 * Adding a user using GET API
 */
Future<List<User>> getUsers() async {
  List<User> usersList = [];
  print("connect to internet");
  Response response =
      await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));
  if (response.statusCode == 200) {
    final body = json.decode(response.body) as List;
    body.forEach((json) {
      print(json);
      usersList.add(User.fromJson(json));
    });
    return usersList;
  }
  return [];
}

/**
 * Adding user to server using POST API
 *
 */
void postUser(
    {required String name,
    required String gender,
    required String email,}) async {
  var response =
      await http.post(Uri.parse('https://gorest.co.in/public/v2/users'),
          headers: {
            "Authorization":
                "Bearer ed0645c09baf75ccb7b21afc0af41ab01f0770fd90e831d5295fab6c77d96965",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "name": "$name",
            "gender": "$gender",
            "email": "$email",
            "status": "active",
          }));

  print(response.body);
  if (response.statusCode == 201) {
    //ScaffoldMessenger.of(context)
     //   .showSnackBar(SnackBar(content: Text('User Added')));
     print(response.body);
  } else
    //ScaffoldMessenger.of(context)
       // .showSnackBar(SnackBar(content: Text('Error ${response.body}')));
       print(response.reasonPhrase);
}

/**
 * User Object
 */
class User {
  late int id;
  late String name;
  late String email;
  late String status;
  late String gender;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    gender = json['gender'];
  }
}
main(){
  //postUser(name:"Said", gender: "male", email: "tettted@gmail.com");
  getUsers();
}