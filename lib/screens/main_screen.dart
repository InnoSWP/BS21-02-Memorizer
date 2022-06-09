import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const textBoxColor = Color(0xFFF6F2FA);
  static const mainButtonColor = Color(0xFF6750A4);
  static const smallButtonColor = Color(0xFFEADDFF);
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: textBoxColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter your text",
                      ),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 100,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      CircleAvatar(
                        backgroundColor: smallButtonColor,
                        radius: 30,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.upload_file,
                            color: mainButtonColor,
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainButtonColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      CircleAvatar(
                        backgroundColor: smallButtonColor,
                        radius: 30,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            color: mainButtonColor,
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
      ),
    );
  }
}