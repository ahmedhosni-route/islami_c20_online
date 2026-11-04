import 'package:flutter/material.dart';
import '../main.dart';
import 'home_screen.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<OnboardingItem> pages = const [
    OnboardingItem(
      title: 'Welcome To Islami App',
      description: '',
      image: 'assets/images/welcome.png',
    ),
    OnboardingItem(
      title: 'Welcome To Islami',
      description: 'We Are Very Excited To Have You In Our Community.',
      image: 'assets/images/community.png',
    ),
    OnboardingItem(
      title: 'Reading the Quran',
      description: 'Read, and your Lord is the Most Generous',
      image: 'assets/images/quran.png',
    ),
    OnboardingItem(
      title: 'Bearish',
      description: 'Praise the name of your Lord, the Most High',
      image: 'assets/images/sebha.png',
    ),
    OnboardingItem(
      title: 'Holy Quran Radio',
      description: 'You can listen to the Holy Quran Radio through the application for free and easily',
      image: 'assets/images/radio.png',
    ),
  ];

  void finish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void next() {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      finish();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Center(
                child: Image.asset(
                  'assets/images/top_mosque.png',
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Image.asset(
                              page.image,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image_not_supported_outlined,
                                color: gold,
                                size: 120,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: gold,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (page.description.isNotEmpty)
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: gold,
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: currentPage == index ? 24 : 6,
                  decoration: BoxDecoration(
                    color: currentPage == index ? gold : Colors.white38,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage > 0
                      ? TextButton(
                    onPressed: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: gold, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                      : const SizedBox(width: 50),
                  TextButton(
                    onPressed: next,
                    child: Text(
                      currentPage == pages.length - 1 ? 'Finish' : 'Next',
                      style: const TextStyle(color: gold, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}