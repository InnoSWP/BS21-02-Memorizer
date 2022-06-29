import 'package:flutter/material.dart';
import 'package:memorizer_flutter/screens/player_settings_screen.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../theme.dart';

class MainSettingsScreen extends StatefulWidget {
  static const routeName = '/main-settings';
  const MainSettingsScreen({Key? key}) : super(key: key);

  @override
  State<MainSettingsScreen> createState() => _MainSettingsScreenState();
}

class _MainSettingsScreenState extends State<MainSettingsScreen> {
  int _repetitions = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextBoxColor,
        elevation: 0,
        centerTitle: true,
        title:
            const Text('Settings', style: TextStyle(color: kMainButtonColor)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kMainButtonColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SettingsRow(
              'Repeat',
              DropdownButton(
                value: _repetitions.toString(),
                onChanged: (String? newValue) {
                  setState(() {
                    _repetitions = int.parse(newValue!);
                    Provider.of<SettingsProvider>(context, listen: false)
                        .changeRepetitions(_repetitions);
                  });
                },
                items: <int>[1, 2, 3, 4, 5]
                    .map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
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
