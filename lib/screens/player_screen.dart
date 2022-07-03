import 'package:flutter/material.dart';
import 'package:memorizer_flutter/screens/player_settings_screen.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:memorizer_flutter/providers/settings_provider.dart';
import 'package:memorizer_flutter/theme.dart';
import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:picovoice_flutter/picovoice_error.dart';
import 'package:rhino_flutter/rhino.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = "/playerscreen";

  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int _currentLine = 0;
  Icon iconMain = const Icon(Icons.play_arrow);
  Icon iconMicro = const Icon(Icons.mic_none);
  FlutterTts flutterTts = FlutterTts();
  bool onPause = true;
  bool _playbackOn = false;
  final pageController = PageController();
  PicovoiceManager? picovoiceManager;
  bool listeningForCommand = false;
  String? command;
  Settings settings = Settings(1, 1, 1);
  var lines = [];

  void _playText(lines, settings) async {
    String text = lines[_currentLine];
    int reps = settings.repetitions;
    text = (text + "  ") * reps;
    var vol = settings.volume;
    var speed = settings.speed;
    print("vol" + vol.toString());
    print("speed" + speed.toString());
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    await flutterTts.speak(text);
    print(reps);
    flutterTts.setCompletionHandler(() {
      setState(() {
        _playbackOn = true;
        if (_currentLine < lines.length - 1) {
          _currentLine++;
        }
      });
      pageController.nextPage(
          duration: Duration(milliseconds: 800), curve: Curves.easeIn);
    });
  }

  void initPicovoice() async {
    String contextAsset = "assets\\Memorizer_en_android_v2_1_0.rhn";
    String keywordAsset = "assets\\Hey-Memo_en_android_v2_1_0.ppn";
    String accessKey =
        "4CnkZqb8+dM7hDpoc4VVxgXnkDcgnYKvPuu0/OIfQLn3ogrpVwFycQ==";

    try {
      picovoiceManager = await PicovoiceManager.create(accessKey, keywordAsset,
          wakeWordCallback, contextAsset, inferenceCallback,
          processErrorCallback: processErrorCallback);
      print("activate voice manager");
      await picovoiceManager!.start();
      print(picovoiceManager);
    } on PicovoiceInvalidArgumentException catch (ex) {
      processErrorCallback(PicovoiceInvalidArgumentException(
          "${ex.message}\nEnsure your accessKey '$accessKey' is a valid access key."));
    } on PicovoiceActivationException {
      processErrorCallback(
          PicovoiceActivationException("AccessKey activation error."));
    } on PicovoiceActivationLimitException {
      processErrorCallback(PicovoiceActivationLimitException(
          "AccessKey reached its device limit."));
    } on PicovoiceActivationRefusedException {
      processErrorCallback(
          PicovoiceActivationRefusedException("AccessKey refused."));
    } on PicovoiceActivationThrottledException {
      processErrorCallback(PicovoiceActivationThrottledException(
          "AccessKey has been throttled."));
    } on PicovoiceException catch (ex) {
      processErrorCallback(ex);
    }
  }

  void wakeWordCallback() {
    print("wake word detected!");
  }

  inferenceCallback(RhinoInference inference) {
    print(inference.intent);
    if (inference.isUnderstood!) {
      listeningForCommand = false;
      command = inference.intent;
      print(command);
      switch (command) {
        case "play":
          playOrpause();
          break;
        case "pause":
          playOrpause();
          break;
        case "prev":
          playPrev();
          break;
        case "next":
          playNext();
          break;
        case "repeat":
          stopText();
          speakText(lines[_currentLine], settings);
      }
    }
  }

  void processErrorCallback(PicovoiceException error) {
    print(error.message);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final serverProvider = Provider.of<ServerProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    settings = settingsProvider.getSettings();
    int reps = settings.repetitions;
    lines = serverProvider.results;
    if (_playbackOn) {
      stopText();
      _playText(lines, settings);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Memorizer", style: TextStyle(color: Color(0xff6750a4))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
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
                    listeningForCommand = !listeningForCommand;
                    if (listeningForCommand) {
                      initPicovoice();
                      setState(() {
                        iconMicro = Icon(Icons.mic_off);
                      });
                      print("Voice commands");
                    } else {
                      setState(() {
                        iconMicro = Icon(Icons.mic_none);
                      });
                      picovoiceManager!.stop();
                    }
                  },
                  icon: iconMicro,
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
                      onPressed: playPrev,
                      icon: Icon(Icons.keyboard_arrow_left),
                      color: Color(0xff4f378b),
                      iconSize: 50),
                ),
                IconButton(
                    // ignore: avoid_print
                    onPressed: playOrpause,
                    icon: iconMain,
                    color: Color(0xff4f378b),
                    iconSize: 50),
                IconButton(
                    // ignore: avoid_print
                    onPressed: playNext,
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

  void playNext() {
    if (_currentLine < lines.length - 1) {
      if (!onPause) {
        stopText();
        speakText(lines[_currentLine + 1], settings);
      }
      setState(() {
        if (_currentLine < lines.length - 1) {
          _currentLine++;
        }
        pageController.nextPage(
            duration: Duration(milliseconds: 800), curve: Curves.easeIn);
      });
    }
  }

  void playOrpause() async {
    onPause = !onPause;
    if (iconMain.icon == Icons.play_arrow) {
      setState(() {
        iconMain = Icon(Icons.pause);
      });
      _playText(lines, settings);
    } else {
      setState(() {
        _playbackOn = false;
        iconMain = Icon(Icons.play_arrow);
      });
      stopText();
    }
  }

  void playPrev() async {
    if (_currentLine >= 1) {
      if (!onPause) {
        stopText();
        speakText(lines[_currentLine - 1], settings); // -1
      }
      setState(() {
        if (_currentLine > 0) {
          _currentLine--;
        }
        pageController.previousPage(
            duration: Duration(milliseconds: 800), curve: Curves.easeIn);
      });
    }
  }

  Widget listElementToScreen(var list, var sizeOfScreen, var index) {
    return Center(
      child: Text(
        list[index], // add text from the array,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 36, color: Color(0xff4f378b)),
      ),
    );
  }

  void speakText(var text, Settings setts) async {
    int reps = setts.repetitions;
    var vol = setts.volume;
    var speed = setts.speed;
    text = (text + "  ") * reps;
    print("vol" + vol.toString());
    print("speed" + speed.toString());
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    await flutterTts.speak(text);
    print(reps);
  }

  Future stopText() async {
    await flutterTts.stop();
  }
}
