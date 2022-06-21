import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:http/http.dart' as http;

class PdfProvider extends ChangeNotifier {
  final List<String> _results = [];
  String PDF = "";
  PdfProvider();

  void postPDF({required String? doc}) async {
    String text = doc as String;
    Uri url = Uri.parse(
        "https://6aa44587-74aa-4c56-bec3-edaf43b12c52.mock.pstmn.io/sentences");
    var response = await http.post(url,
        headers: {
          "Access-Control_Allow_Origin": "*",
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"text": text}));
    if (response.statusCode == 200) {
      print("Connecting to API (PDF)");
      final body = json.decode(response.body) as List;
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

  void pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      var pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      PDF = await pdfDoc.text;
      notifyListeners();
    }
  }

  List<String> get results => _results;
  //String get myPDF => PDF;
}
