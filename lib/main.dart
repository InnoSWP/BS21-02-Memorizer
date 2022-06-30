import 'package:flutter/material.dart';
import 'package:memorizer_flutter/screens/main_screen.dart';
import 'package:memorizer_flutter/screens/player_screen.dart';
import 'package:memorizer_flutter/server/pdf_parser.dart';
import 'package:memorizer_flutter/server/server_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServerProvider()),
        ChangeNotifierProvider(create: (_) => PdfProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          PlayerScreen.routeName: (context) => const PlayerScreen(),
        },
      ),
    );
  }
}