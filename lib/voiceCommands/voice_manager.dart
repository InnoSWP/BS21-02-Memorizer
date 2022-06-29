import 'dart:io';

import 'package:flutter/services.dart';
import 'package:picovoice_flutter/picovoice.dart';
import 'package:picovoice_flutter/picovoice_error.dart';
import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:rhino_flutter/rhino_error.dart';
import 'package:rhino_flutter/rhino_manager.dart';

class voiceControl {
  PicovoiceManager? picovoiceManager;
  bool listeningForCommand = false;
  String? command;

  voiceControl();
  void initPicovoice() async {
    String contextAsset = "assets\\Memorizer_en_android_v2_1_0.rhn";
    String contextPath = await _extractAsset(contextAsset);
    String keywordAsset = "assets\\hey-Memorizer_en_android_v2_1_0.ppn";
    String keywordPath = await _extractAsset(keywordAsset);
    String accessKey =
        "4CnkZqb8+dM7hDpoc4VVxgXnkDcgnYKvPuu0/OIfQLn3ogrpVwFycQ==";

    try {
      picovoiceManager = await PicovoiceManager.create(accessKey, keywordAsset,
          wakeWordCallback, contextAsset, inferenceCallback,
          processErrorCallback: processErrorCallback);
      print("activate voice manager");

      await picovoiceManager!.start();
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

  void startPicoVoice() async {
    try {
      print("я стартанул");
      await picovoiceManager!.start();
    } on PicovoiceException catch (ex) {
      processErrorCallback(ex);
    }
  }

  void wakeWordCallback() {
    print("wake word detected!");
    listeningForCommand = true;
  }

  inferenceCallback(RhinoInference inference) {
    print(inference.intent);
    if (inference.isUnderstood!) {
      listeningForCommand = false;
      command = inference.intent;
      print(command);
    }
    //_listeningForCommand = false;
  }

  void processErrorCallback(PicovoiceException error) {
    print(error.message);
  }

  Future<String> _extractAsset(String resourcePath) async {
    String resourceDirectory = (await getApplicationDocumentsDirectory()).path;
    String outputPath = '$resourceDirectory/$resourcePath';
    File outputFile = new File(outputPath);

    ByteData data = await rootBundle.load(resourcePath);
    final buffer = data.buffer;

    await outputFile.create(recursive: true);
    await outputFile.writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return outputPath;
  }
}
