import 'package:flutter/material.dart';
import 'package:nikhil_sinha/features/blinkit_money/presentation/screens/blinkit_money_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nikhil Sinha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'Gilroy', 
      ),
      home: const BlinkitMoneyScreen(),
    );
  }
}
