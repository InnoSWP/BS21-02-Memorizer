import 'dart:convert';
import 'package:http/http.dart' as http;

// function takes String as a text and returns Future<List<String>> of sentences
Future<List<String>> postText({required String text}) async {
  Uri url = Uri.parse("https://6aa44587-74aa-4c56-bec3-edaf43b12c52.mock.pstmn.io/sentences");
  List<String> sentences = [];
  String sample = "Don’t think of it as anything more than that. Our natural growth isn’t only physical. As our bodies mature our minds and souls do too. It may be that he loves you now, and that his intentions are honorable, but remember who he is. He’s not his own man: he’s subject to his birth. He can’t just do as he likes as the common people can. In time the safety and health of Denmark will depend on his decisions. When he chooses a wife it must be after he has heard and considered the opinions of those institutions that he is the head of. So if he tells you he loves you you should understand that he loves you in as much as a man in his position can, which is no more than the people of Denmark will allow. Decide whether you can cope with it if you suffer disappointment by taking too much notice of his serenades and falling in love with him or surrendering your virginity to him.";
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({"text": sample}));
  if (response.statusCode == 200) {
    print("Connecting to API");
    final body = json.decode(response.body) as List;
    body.forEach((json) {
      sentences.add(json["sentence"]);
     });
     //print(sentences);
     return sentences;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    return [];
  }
}

// void main(List<String> args) {
//   postText(text: "Don’t think of it as anything more than that. Our natural growth isn’t only physical. As our bodies mature our minds and souls do too. It may be that he loves you now, and that his intentions are honorable, but remember who he is. He’s not his own man: he’s subject to his birth. He can’t just do as he likes as the common people can. In time the safety and health of Denmark will depend on his decisions. When he chooses a wife it must be after he has heard and considered the opinions of those institutions that he is the head of. So if he tells you he loves you you should understand that he loves you in as much as a man in his position can, which is no more than the people of Denmark will allow. Decide whether you can cope with it if you suffer disappointment by taking too much notice of his serenades and falling in love with him or surrendering your virginity to him.");
// }