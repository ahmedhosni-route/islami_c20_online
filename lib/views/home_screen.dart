import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/custom_button.dart';
import 'sebha_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: const Text('Islamiii'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomButton(
            text: 'Open Sebha Screen',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SebhaScreen()),
              );
            },
            backgroundColor: gold,
            textColor: dark,
          ),
        ),
      ),
    );
  }
}