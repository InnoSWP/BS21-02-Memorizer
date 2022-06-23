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
void posTest({required bool isPDF}) async {
  String text = "";
  String access = "";
  String req = "";
  if (isPDF) {
    access = "pdf";
    req = 'https://6aa44587-74aa-4c56-bec3-edaf43b12c52.mock.pstmn.io/pdf';
    text =
        "Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler, long I stood And looked down one as far as I could To where it bent in the undergrowth; Then took the other, as just as fair, And having perhaps the better claim, Because it was grassy and wanted wear;Though as for that the passing there Had worn them really about the same, And both that morning equally lay In leaves no step had trodden black.";
  } else {
    access = "*";
    req =
        'https://6aa44587-74aa-4c56-bec3-edaf43b12c52.mock.pstmn.io/sentences';
    text =
        "Don’t think of it as anything more than that. Our natural growth isn’t only physical. As our bodies mature our minds and souls do too. It may be that he loves you now, and that his intentions are honorable, but remember who he is. He’s not his own man: he’s subject to his birth. He can’t just do as he likes as the common people can. In time the safety and health of Denmark will depend on his decisions. When he chooses a wife it must be after he has heard and considered the opinions of those institutions that he is the head of. So if he tells you he loves you you should understand that he loves you in as much as a man in his position can, which is no more than the people of Denmark will allow. Decide whether you can cope with it if you suffer disappointment by taking too much notice of his serenades and falling in love with him or surrendering your virginity to him.";
  }
  var response = await http.post(Uri.parse(req),
      headers: {
        "Access-Control_Allow_Origin": access,
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({"text": text}));

  print(response.body);
  if (response.statusCode == 200) {
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

main() {
  //postUser(name:"Said", gender: "male", email: "tettted@gmail.com");
  posTest(isPDF: true);
  posTest(isPDF: false);
}
