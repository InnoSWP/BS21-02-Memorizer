import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:http/http.dart' as http;

class ServerProvider extends ChangeNotifier {
  List<String> _results = [];
  ServerProvider();

  void postText({required String text, required bool flagPDF}) async {
    _results = [];
    String req = "";
    String acces = "";
    String sample = "";
    if (flagPDF) {
      print("зашел");
      req = "https://6aa44587-74aa-4c56-bec3-edaf43b12c52.mock.pstmn.io/pdf";
      acces = "pdf";
      sample =
          "Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler, long I stood And looked down one as far as I could To where it bent in the undergrowth; Then took the other, as just as fair, And having perhaps the better claim, Because it was grassy and wanted wear;Though as for that the passing there Had worn them really about the same, And both that morning equally lay In leaves no step had trodden black.";
    } else {
      req =
          "https://6aa44587-74aa-4c56-bec3-edaf43b12c52.mock.pstmn.io/sentences";
      acces = "*";
      sample =
          "Don’t think of it as anything more than that. Our natural growth isn’t only physical. As our bodies mature our minds and souls do too. It may be that he loves you now, and that his intentions are honorable, but remember who he is. He’s not his own man: he’s subject to his birth. He can’t just do as he likes as the common people can. In time the safety and health of Denmark will depend on his decisions. When he chooses a wife it must be after he has heard and considered the opinions of those institutions that he is the head of. So if he tells you he loves you you should understand that he loves you in as much as a man in his position can, which is no more than the people of Denmark will allow. Decide whether you can cope with it if you suffer disappointment by taking too much notice of his serenades and falling in love with him or surrendering your virginity to him.";
    }
    Uri url = Uri.parse(req);
    var response = await http.post(url,
        headers: {
          "Access-Control_Allow_Origin": acces,
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"text": sample}));
    if (response.statusCode == 200) {
      print("Connecting to API");
      final body = json.decode(response.body) as List;
      print(body);
      body.forEach((json) {
        _results.add(json["sentence"]);
      });
      print(_results);
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  List<String> get results => _results;
}
