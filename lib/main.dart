import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const CashMinderApp());
}

class CashMinderApp extends StatelessWidget {
  const CashMinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashMinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}