import 'package:flutter/material.dart';
import 'package:tunesync/screen/home_screen.dart';
import 'package:tunesync/screen/player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
