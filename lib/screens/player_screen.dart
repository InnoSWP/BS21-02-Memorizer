import 'package:flutter/material.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget {
  static const routeName = "/playerscreen";
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Memorizer", style: TextStyle(color: Color(0xff6750a4))),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              // ignore: avoid_print
              onPressed: () => print('Go back'),
              icon: Icon(Icons.arrow_back, color: Color(0xff6750a4))),
        ),
        body: Column(children: [
          Container(
              alignment: Alignment.center,
              // ignore: todo
              //TODO: Connect with the screen (precentages)
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.63,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F2FA),
                border: Border.all(color: const Color(0xFFF6F2FA)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.only(top: 150),
                    child: Column(children: [
                      const Text(
                        "Oh, I hope some day I'll make it out of here. Even if it takes all night or a hundred years",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: const Text(
                            "Need a place to hide, but I can't find one near. Wanna feel alive, outside I can't fight my fear",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ))
                    ]))
              ])),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      // ignore: avoid_print
                      onPressed: (() => print('Left button pressed')),
                      icon: Icon(Icons.keyboard_double_arrow_left),
                      color: Color(0xff4f378b),
                      iconSize: 50),
                  IconButton(
                      // ignore: avoid_print
                      onPressed: (() => print('Pause button pressed')),
                      icon: Icon(Icons.play_arrow),
                      color: Color(0xff4f378b),
                      iconSize: 50),
                  IconButton(
                      // ignore: avoid_print
                      onPressed: (() => print('Right button pressed')),
                      icon: Icon(Icons.keyboard_double_arrow_right),
                      color: Color(0xff4f378b),
                      iconSize: 50)
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Ink(
                        decoration: const ShapeDecoration(
                          color: Color(0xffeaddff),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            onPressed: () => print("repeat"),
                            icon: Icon(Icons.repeat),
                            color: Color(0xff6750a4),
                            iconSize: 30)),
                    Ink(
                        decoration: const ShapeDecoration(
                          color: Color(0xff6750a4),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            onPressed: () => print("Voice commands"),
                            icon: Icon(Icons.mic_none),
                            color: Color(0xffeaddff),
                            iconSize: 40)),
                    Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Color(0xffeaddff),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                              onPressed: () => print("Settings"),
                              icon: Icon(Icons.settings),
                              color: Color(0xff4f378b),
                              iconSize: 30),
                        ))
                  ]))
        ]));
  }
}
