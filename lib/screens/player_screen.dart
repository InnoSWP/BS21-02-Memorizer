import 'package:flutter/material.dart';
import 'package:memorizer_flutter/screens/player_settings_screen.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:memorizer_flutter/providers/settings_provider.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:provider/provider.dart';
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
  bool onPause = true;
  bool _playbackOn = false;
  final pageController = PageController();
  //SettingsProvider settingsProvider = SettingsProvider();
  //int repetitions = settingsProvider.settings.repetitions;

  // void scrollToIndex(int index) => itemController.scrollTo(
  //     index: index, duration: Duration(milliseconds: 500));

  void _playText(lines, settings) async {
    String text = lines[_currentLine];
    int reps = settings.repetitions;
    var vol = settings.volume;
    var speed = settings.speed;
    print("vol" + vol.toString());
    print("speed" + speed.toString());
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    //await flutterTts.setSpeechRate(speed - 0.5);
    //await flutterTts.setVolume(vol);
    await flutterTts.setQueueMode(1);
    print(reps);
    for (int i = 0; i < reps; i++) {
      await flutterTts.speak(text);
    }
    flutterTts.setCompletionHandler(() {
      setState(() {
        _playbackOn = true;
        _currentLine++;
      });
      pageController.nextPage(
          duration: Duration(milliseconds: 800), curve: Curves.easeIn);
      // print('are we jere' + _currentLine.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final serverProvider = Provider.of<ServerProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    //int reps = settingsProvider.settings.repetitions;
    Settings settings = settingsProvider.getSettings();
    int reps = settings.repetitions;
    final lines = serverProvider.results;
    if (_playbackOn) {
      _playText(lines, settings);
    }
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
                        if (!onPause) {
                          stopText();
                          speakText(lines[_currentLine], settings);
                        }
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
                  onPressed: () {
                    print("Voice commands");
                    // print(await flutterTts.getVoices);
                  },
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
              child: CircleAvatar(
                backgroundColor: kSmallButtonColor,
                radius: 30,
                child: IconButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(PlayerSettingsScreen.routeName),
                    icon: Icon(Icons.settings),
                    color: kMainButtonColor,
                    iconSize: 25),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: IconButton(
                    // ignore: avoid_print
                      onPressed: () async {
                        if (_currentLine >= 1) {
                          if (!onPause) {
                            stopText();
                            speakText(lines[_currentLine - 1], settings);
                          }
                          setState(() {
                            _currentLine--;
                            pageController.previousPage(
                                duration: Duration(milliseconds: 800),
                                curve: Curves.easeIn);
                          });
                        }
                      },
                      icon: Icon(Icons.keyboard_arrow_left),
                      color: Color(0xff4f378b),
                      iconSize: 50),
                ),
                IconButton(
                  // ignore: avoid_print
                    onPressed: (() async {
                      onPause = !onPause;
                      if (iconMain.icon == Icons.play_arrow) {
                        setState(() {
                          iconMain = Icon(Icons.pause);
                        });
                        String text = lines[_currentLine];
                        int reps = settings.repetitions;
                        var vol = settings.volume;
                        var speed = settings.speed;
                        print("vol" + vol.toString());
                        print("speed" + speed.toString());
                        await flutterTts.setVoice(
                            {"name": "en-us-x-tpf-local", "locale": "en-US"});
                        //await flutterTts.setSpeechRate(speed - 0.5);
                        //await flutterTts.setVolume(vol);
                        await flutterTts.setQueueMode(1);
                        print(reps);
                        for (int i = 0; i < reps; i++) {
                          await flutterTts.speak(text);
                        }
                        flutterTts.setCompletionHandler(() {
                          setState(() {
                            _playbackOn = true;
                            _currentLine++;
                          });
                          pageController.nextPage(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeIn);
                          // print('are we jere' + _currentLine.toString());
                        });
                        // print('are we here>', currentLin);
                        // _currentLine++;
                        // pageController.nextPage(
                        //     duration: Duration(milliseconds: 800),
                        //     curve: Curves.easeIn);
                        // setState(() {
                        //   iconMain = Icon(Icons.pause);
                        // });
                        // // stopText();
                        // // speakText(lines[_currentLine], settings);
                        // String text = lines[_currentLine];
                        // int reps = settings.repetitions;
                        // var vol = settings.volume;
                        // var speed = settings.speed;
                        // print("vol" + vol.toString());
                        // print("speed" + speed.toString());
                        // await flutterTts.setVoice(
                        //     {"name": "en-us-x-tpf-local", "locale": "en-US"});
                        // //await flutterTts.setSpeechRate(speed - 0.5);
                        // //await flutterTts.setVolume(vol);
                        // await flutterTts.setQueueMode(1);
                        // print(reps);
                        // for (int i = 0; i < reps; i++) {
                        //   await flutterTts.speak(text);
                        // }
                        // flutterTts.setCompletionHandler(() {
                        //   print('done!');
                        //   if (_currentLine < lines.length - 1) {
                        //     setState(() {
                        //       print(_currentLine);
                        //       _currentLine++;
                        //       _lineComplete = true;
                        //       print(_currentLine);
                        //        pageController.nextPage(
                        //         duration: Duration(milliseconds: 800),
                        //         curve: Curves.easeIn);
                        //     });
                        //   }
                        // });
                        // if (_lineComplete) {
                        //   setState(() {
                        //     _lineComplete = false;
                        //     print('wtf $_lineComplete');

                        //   });
                        // }
                      } else {
                        setState(() {
                          _playbackOn = false;
                          iconMain = Icon(Icons.play_arrow);
                        });
                        stopText();
                      }
                    }),
                    icon: iconMain,
                    color: Color(0xff4f378b),
                    iconSize: 50),
                IconButton(
                  // ignore: avoid_print
                    onPressed: () {
                      if (_currentLine < lines.length - 1) {
                        if (!onPause) {
                          stopText();
                          speakText(lines[_currentLine + 1], settings);
                        }
                        setState(() {
                          _currentLine++;
                          pageController.nextPage(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeIn);
                        });
                      }
                    },
                    icon: Icon(Icons.keyboard_arrow_right),
                    color: Color(0xff4f378b),
                    iconSize: 50)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listElementToScreen(var list, var sizeOfScreen, var index) {
    return Center(
      child: Text(
        list[index], // add text from the array,
        textAlign: TextAlign.center,
        // overflow: TextOverflow.ellipsis,
        // maxLines: 2,
        style: const TextStyle(fontSize: 36, color: Color(0xff4f378b)),
      ),
    );
  }

  Future speakText(var text, Settings setts) async {
    int reps = setts.repetitions;
    var vol = setts.volume;
    var speed = setts.speed;
    print("vol" + vol.toString());
    print("speed" + speed.toString());
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    //await flutterTts.setSpeechRate(speed - 0.5);
    //await flutterTts.setVolume(vol);
    await flutterTts.setQueueMode(1);
    print(reps);
    for (int i = 0; i < reps; i++) {
      await flutterTts.speak(text);
    }
    //await flutterTts.speak(text);
    //await flutterTts.speak(text);
  }

  Future stopText() async {
    await flutterTts.stop();
  }
}
