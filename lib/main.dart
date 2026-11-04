import 'package:flutter/material.dart';
import 'views/onboarding_screen.dart';

void main() {
  runApp(const IslamiiiApp());
}

const Color gold = Color(0xFFD6B46A);
const Color dark = Color(0xFF171717);
const Color blue = Color(0xFF07358D);

class IslamiiiApp extends StatelessWidget {
  const IslamiiiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamiii',
      theme: ThemeData(
        scaffoldBackgroundColor: dark,
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}