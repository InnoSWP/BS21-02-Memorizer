import 'package:flutter/material.dart';
import 'package:memorizer_flutter/screens/player_screen.dart';
import 'package:memorizer_flutter/server/pdf_parser.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:provider/provider.dart';
import 'package:pdf_text/pdf_text.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/mainscreen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final _focusNode = FocusNode();
  final _textController = TextEditingController();
  //String? pdf;
  bool _showBackButton = false;

  void onTextPress() {
    setState(() {
      _showBackButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final serverProvider = Provider.of<ServerProvider>(context, listen: false);
    final pdfProvider = Provider.of<PdfProvider>(context);
    if (pdfProvider.PDF.length > 0) {
      _textController.text = pdfProvider.PDF;
    }
    MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextBoxColor,
        elevation: 0,
        centerTitle: true,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: _showBackButton ? 0.0 : 1.0,
          child: const Text(
            "Memorizer",
            style: TextStyle(
              color: kMainButtonColor,
              fontSize: 25,
            ),
          ),
        ),
        leading: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: _showBackButton ? 1.0 : 0.0,
          child: IconButton(
            onPressed: () {
              setState(() {
                _showBackButton = false;
              });
              _focusNode.unfocus();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kMainButtonColor,
              size: 30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: kTextBoxColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your text",
                  ),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 100,
                  focusNode: _focusNode,
                  onTap: onTextPress,
                  controller: _textController,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      backgroundColor: kSmallButtonColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          // TODO : upload PDF
                          pdfProvider.pickPDFText();
                          print("upload PDF");
                        },
                        icon: const Icon(
                          Icons.upload_file,
                          color: kMainButtonColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Upload PDF",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      backgroundColor: kMainButtonColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(PlayerScreen.routeName);
                          print(_textController.text);
                          serverProvider.postText(text: _textController.text);
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          color: kSmallButtonColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Start Memorize",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      backgroundColor: kSmallButtonColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: kMainButtonColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
