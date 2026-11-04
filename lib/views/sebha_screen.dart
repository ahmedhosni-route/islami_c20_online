import 'package:flutter/material.dart';
import '../main.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int count = 0;
  int dhikrIndex = 0;
  double rotation = 0;

  final List<String> adhkar = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
  ];

  void increment() {
    setState(() {
      count++;
      rotation += 0.15;
      if (count >= 33) {
        count = 0;
        dhikrIndex = (dhikrIndex + 1) % adhkar.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/sebha_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: dark),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/top_mosque.png',
                        height: 180,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'سَبِّحْ اسْمَ رَبِّكَ الْأَعْلَى',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: increment,
                      child: SizedBox(
                        width: 410,
                        height: 460,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 95,
                              child: AnimatedRotation(
                                turns: rotation,
                                duration: const Duration(milliseconds: 200),
                                child: Image.asset(
                                  'assets/images/sebha_body.png',
                                  width: 320,
                                  height: 320,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.circle_outlined, size: 300, color: gold),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              child: Transform.translate(
                                offset: const Offset(1, 0),
                                child: Transform.rotate(
                                  angle: -0.15,
                                  child: Image.asset(
                                    'assets/images/sebha_top.png',
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 65),
                                Text(
                                  adhkar[dhikrIndex],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/bottom_nav_bar.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (_, __, ___) => Container(
                    height: 60,
                    color: gold,
                    child: const Center(
                      child: Text(
                        'Bottom Navigation Bar Image Missing',
                        style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}