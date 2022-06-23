import 'package:flutter/material.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = "/playerscreen";

  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int _currentLine = 1;
  Icon iconMain = const Icon(Icons.play_arrow);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final serverProvider = Provider.of<ServerProvider>(context);
    final lines = serverProvider.results;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Memorizer", style: TextStyle(color: Color(0xff6750a4))),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              // ignore: avoid_print
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, color: Color(0xff6750a4))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ]),
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
            child: ListView(
              children: [
                Container(
                  height: size.height * 0.25,
                ),
                Container(
                  child: Text(
                    lines[_currentLine], // add text from the array,
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.15,
                ),
                Container(
                  child: Text(
                    _currentLine + 1 < lines.length ? lines[_currentLine + 1] : "",
                    // add text from the array,
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // child: SingleChildScrollView(
          //   child: Column(
          //     children: [
          // Container(
          //     child: Column(children: [
          //   for (var index = 0; index < lines.length; ++index)
          //     if (_currentLine - 1 == index)
          //       Text(
          //         lines[index],
          //         style: const TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 30,
          //         ),
          //         textAlign: TextAlign.center,
          //       )
          //     else
          //       Text(
          //         lines[index],
          //         style: const TextStyle(
          //           fontSize: 24,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          // Padding(
          //     padding: const EdgeInsets.only(top: 70),
          //     child: const Text(
          //       "Need a place to hide, but I can't find one near. Wanna feel alive, outside I can't fight my fear",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: 24,
          //       ),
          //     ))
          //         ]))
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 0),
                    child: IconButton(
                        // ignore: avoid_print
                        onPressed: () {
                          if (_currentLine > 1) {
                            setState(() {
                              _currentLine--;
                            });
                          }
                        },
                        icon: Icon(Icons.keyboard_arrow_left),
                        color: Color(0xff4f378b),
                        iconSize: 50),
                  ),
                  IconButton(
                      // ignore: avoid_print
                      onPressed: (() {
                        setState(() {





                          if (iconMain.icon == Icons.play_arrow) {
                            iconMain = Icon(Icons.pause);
                          } else {
                            iconMain = Icon(Icons.play_arrow);
                          }
                        });
                      }),
                      icon: iconMain,
                      color: Color(0xff4f378b),
                      iconSize: 50),
                  IconButton(
                      // ignore: avoid_print
                      onPressed: () {
                        if (_currentLine < lines.length - 1) {
                          setState(() {
                            print(_currentLine);
                            print(lines.length);
                            _currentLine++;
                          });
                        }
                      },
                      icon: Icon(Icons.keyboard_arrow_right),
                      color: Color(0xff4f378b),
                      iconSize: 50)
                ],
              )),
          // Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Ink(
          //               decoration: const ShapeDecoration(
          //                 color: Color(0xffeaddff),
          //                 shape: CircleBorder(),
          //               ),
          //               child: IconButton(
          //                   onPressed: () => print("repeat"),
          //                   icon: Icon(Icons.repeat),
          //                   color: Color(0xff6750a4),
          //                   iconSize: 30)),
          //           Ink(
          //               decoration: const ShapeDecoration(
          //                 color: Color(0xff6750a4),
          //                 shape: CircleBorder(),
          //               ),
          //               child: IconButton(
          //                   onPressed: () => print("Voice commands"),
          //                   icon: Icon(Icons.mic_none),
          //                   color: Color(0xffeaddff),
          //                   iconSize: 40)),
          //           Padding(
          //               padding: const EdgeInsets.only(left: 0),
          //               child: Ink(
          //                 decoration: const ShapeDecoration(
          //                   color: Color(0xffeaddff),
          //                   shape: CircleBorder(),
          //                 ),
          //                 child: IconButton(
          //                     onPressed: () => print("Settings"),
          //                     icon: Icon(Icons.settings),
          //                     color: Color(0xff4f378b),
          //                     iconSize: 30),
          //               ))
          //         ]))
        ]));
  }
}
