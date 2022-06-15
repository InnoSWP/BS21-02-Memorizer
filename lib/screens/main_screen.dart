import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const textBoxColor = Color(0xFFF6F2FA);
  static const mainButtonColor = Color(0xFF6750A4);
  static const smallButtonColor = Color(0xFFEADDFF);
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final _focusNode = FocusNode();
  bool _showBackButton = false;

  void onTextPress() {
    setState(() {
      _showBackButton = true;
    });
  }

  @overr
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainScreen.textBoxColor,
        elevation: 0,
        centerTitle: true,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: _showBackButton ? 0.0 : 1.0,
          child: const Text(
            "Memorizer",
            style: TextStyle(
              color: MainScreen.mainButtonColor,
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
              Icons.chevron_left,
              color: MainScreen.mainButtonColor,
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
                color: MainScreen.textBoxColor,
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
                      backgroundColor: MainScreen.smallButtonColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.upload_file,
                          color: MainScreen.mainButtonColor,
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
                      backgroundColor: MainScreen.mainButtonColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          color: MainScreen.smallButtonColor,
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
                      backgroundColor: MainScreen.smallButtonColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: MainScreen.mainButtonColor,
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
