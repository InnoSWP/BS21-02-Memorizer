import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memorizer_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class PlayerSettingsScreen extends StatefulWidget {
  static const routeName = '/player-settings';
  const PlayerSettingsScreen({Key? key}) : super(key: key);

  @override
  State<PlayerSettingsScreen> createState() => _PlayerSettingsScreenState();
}

class _PlayerSettingsScreenState extends State<PlayerSettingsScreen> {
  String _speedValue = '1x';
  String _volumeValue = '50%';

  static const Map<String, double> _speedMap = {
    '0.25x': 0.25,
    '0.5x': 0.5,
    '1x': 1,
    '1.5x': 1.5,
    '2x': 2,
  };

  static const Map<String, double> _volumeMap = {
    '10%': 0.1,
    '25%': 0.25,
    '50%': 0.5,
    '75%': 0.75,
    '100%': 1,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextBoxColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Player Settings',
            style: TextStyle(color: kMainButtonColor)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kMainButtonColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SettingsRow(
              'Playback speed',
              DropdownButton(
                value: _speedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _speedValue = newValue!;
                    Provider.of<SettingsProvider>(context, listen: false)
                        .changeSpeed(_speedMap[_speedValue]!);
                  });
                },
                items: <String>['0.25x', '0.5x', '1x', '1.5x', '2x']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SettingsRow(
              'Volume',
              DropdownButton(
                value: _volumeValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _volumeValue = newValue!;
                    Provider.of<SettingsProvider>(context, listen: false)
                        .changeSpeed(_volumeMap[_volumeValue]!);
                  });
                },
                items: <String>['10%', '25%', '50%', '75%', '100%']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String title;
  final Widget action;
  const SettingsRow(this.title, this.action, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(title, style: TextStyle(fontSize: 18)), action],
      ),
    );
  }
}
