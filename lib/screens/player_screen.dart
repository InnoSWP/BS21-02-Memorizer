import 'package:flutter/material.dart';
import 'package:memorizer_flutter/screens/player_settings_screen.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = "/playerscreen";

  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // final itemController = ItemScrollController();
  int _currentLine = 0;
  Icon iconMain = const Icon(Icons.play_arrow);
  FlutterTts flutterTts = FlutterTts();

  // void scrollToIndex(int index) => itemController.scrollTo(
  //     index: index, duration: Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final serverProvider = Provider.of<ServerProvider>(context);
    final lines = serverProvider.results;
    final pageController = PageController();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Memorizer", style: TextStyle(color: Color(0xff6750a4))),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              // ignore: avoid_print
              onPressed: () {
                stopText();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Color(0xff6750a4))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Ink(
              decoration: const ShapeDecoration(
                color: Color(0xffeaddff),
                shape: CircleBorder(),
              ),
              child: CircleAvatar(
                  backgroundColor: kSmallButtonColor,
                  radius: 30,
                  child: IconButton(
                      onPressed: () {
                        print("repeat");
                        stopText();
                        speakText(lines[_currentLine]);
                      },
                      icon: Icon(Icons.repeat),
                      color: Color(0xff6750a4),
                      iconSize: 30))),
          Ink(
              decoration: const ShapeDecoration(
                color: Color(0xff6750a4),
                shape: CircleBorder(),
              ),
              child: IconButton(
                  onPressed: () => print("Voice commands"),
                  icon: Icon(Icons.mic_none),
                  color: Color(0xffeaddff),
                  iconSize: 30)),
          Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Ink(
                  decoration: const ShapeDecoration(
                    color: Color(0xffeaddff),
                    shape: CircleBorder(),
                  ),
                  child: CircleAvatar(
                    backgroundColor: kSmallButtonColor,
                    radius: 30,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pushNamed(PlayerSettingsScreen.routeName),
                        icon: Icon(Icons.settings),
                        color: kMainButtonColor,
                        iconSize: 25),
                  )))
        ]),
        body: Column(children: [
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.63,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F2FA),
                border: Border.all(color: const Color(0xFFF6F2FA)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: pageController,
                children: [
                  for (int i = 0; i < lines.length; i++)
                    listElementToScreen(lines, size, i)
                ],
              )

              // children: [
              //   for (int i = 0; i < lines.length; i++)
              //     listElementToScreen(lines, size, i),
              //   Container(
              //     height: size.height * 0.1,
              //   ),
              // ],
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
                          if (_currentLine >= 1) {
                            speakText(lines[_currentLine - 1]);
                            setState(() {
                              _currentLine--;
                              pageController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeIn);
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
                            speakText(lines[_currentLine]);
                          } else {
                            iconMain = Icon(Icons.play_arrow);
                            stopText();
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
                          speakText(lines[_currentLine + 1]);
                          setState(() {
                            _currentLine++;
                            pageController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeIn)
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

  Widget listElementToScreen(var list, var sizeOfScreen, var index) {
    // return Container(
    //   margin: EdgeInsets.only(bottom: sizeOfScreen.height * 0.15),
    //   child: Text(
    //     list[index], // add text from the array,
    //     textAlign: TextAlign.center,
    //     // overflow: TextOverflow.ellipsis,
    //     // maxLines: 2,
    //     style: const TextStyle(
    //       fontSize: 32,
    //     ),
    //   ),
    // );
    var el;
    if (index != list.length - 1) {
      el = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: sizeOfScreen.height * 0.25,
          ),
          Text(
            list[index], // add text from the array,
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
            // maxLines: 2,
            style: const TextStyle(fontSize: 36, color: Color(0xff4f378b)),
          ),
        ],
      );
      //print(list[index]);
      //speakText(list[index]);
    } else {
      el = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: sizeOfScreen.height * 0.25,
          ),
          Text(
            list[index], // add text from the array,
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
            // maxLines: 2,
            style: const TextStyle(
              fontSize: 36,
              color: Color(0xff4f378b),
            ),
          ),
          Container(
            height: sizeOfScreen.height * 0.25,
          ),
        ],
      );
      //print(list[index]);
      //speakText(list[index]);
    }
    return el;
  }

  Future speakText(var text) async {
    await flutterTts.speak(text);
  }

  Future stopText() async {
    await flutterTts.stop();
  }
}
