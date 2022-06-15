import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerProvider extends ChangeNotifier {
  final List<String> _results = [];
  ServerProvider();

  void postText({required String text}) async {
    Uri url = Uri.parse("https://aqueous-anchorage-93443.herokuapp.com/sentences");
    List<String> sentences = [];
    var response = await http.post(url,
        headers: {
          "Access-Control_Allow_Origin": "*",
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"text": text}));
    if (response.statusCode == 200) {
      print("Connecting to API");
      final body = json.decode(response.body) as List;
      body.forEach((json) {
        _results.add(json["sentence"]);
      });
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  List<String> get results => _results;
}
