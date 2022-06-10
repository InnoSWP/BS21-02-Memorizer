import 'dart:convert';
import 'package:http/http.dart' as http;

// function takes String as a text and returns Future<List<String>> of sentences
Future<List<String>> postText({required String text}) async {
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
      sentences.add(json["sentence"]);
     });
     return sentences;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    return [];
  }
}

