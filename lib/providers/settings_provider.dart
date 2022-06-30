import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  final _settings = Settings(1, 1, 1);
  SettingsProvider();

  void changeVolume(double volume) {
    _settings.volume = volume;
    print(_settings.volume);
    notifyListeners();
  }

  void changeSpeed(double speed) {
    _settings.speed = speed;
    print(speed);
    notifyListeners();
  }

  void changeRepetitions(int repetitions) {
    _settings.repetitions = repetitions;
    print(_settings.repetitions);
    notifyListeners();
  }

  Settings get settings => settings;
}

class Settings {
  double volume;
  double speed;
  int repetitions;

  Settings(this.volume, this.speed, this.repetitions);
}