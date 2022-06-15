import 'package:flutter/material.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget {
  static const routeName = "/playerscreen";
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serverProvider = Provider.of<ServerProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: kMainButtonColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
        ),
        body: Column(children: [
          Container(
            alignment: Alignment.center,
            // ignore: todo
            //TODO: Connect with the screen (precentages)
            width: 370,
            height: 350,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F2FA),
              border: Border.all(color: const Color(0xFFF6F2FA)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              serverProvider.results.toString(),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    // ignore: avoid_print
                      onPressed: (() => print('Left button pressed')),
                      icon: Image.asset('assets/left.png')),
                  IconButton(
                    // ignore: avoid_print
                      onPressed: (() => print('Pause button pressed')),
                      icon: Image.asset('assets/pause.png')),
                  IconButton(
                    // ignore: avoid_print
                      onPressed: (() => print('Right button pressed')),
                      icon: Image.asset('assets/right.png'))
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: IconButton(
                // ignore: avoid_print
                onPressed: () => print('Repeat'),
                icon: Image.asset('assets/repeat.png'),
                alignment: Alignment.center,
              )),
          IconButton(
            iconSize: 70,
            // ignore: avoid_print
            onPressed: () => print('Voice comands'),
            icon: Image.asset('assets/mic.png'),
            alignment: Alignment.center,
          ),
        ]));
  }
}
