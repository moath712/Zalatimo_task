import 'package:flutter/material.dart';
import 'package:test_2/Screens/home_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zalatimo Sweets',
      theme: ThemeData(
        fontFamily: 'Myriad Pro',
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
