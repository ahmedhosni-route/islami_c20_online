import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/layout/screens/hadeth_screen.dart';
import 'package:islam_c20_online/modules/layout/screens/quran_screen.dart';
import 'package:islam_c20_online/modules/layout/screens/radio_screen.dart';
import 'package:islam_c20_online/modules/layout/screens/sebha_screen.dart';
import 'package:islam_c20_online/modules/layout/screens/time_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;
  List<Widget> screens = [
    QuranScreen(),
    HadethScreen(),
    SebhaScreen(),
    RadioScreen(),
    TimeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        backgroundColor: AppColors.gold,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(color: AppColors.white),
        fixedColor: AppColors.white,
        items: [
          buildBottomNavItem(label: "Quran", icon: "assets/icons/ic_quran.svg"),
          buildBottomNavItem(
            label: "Hadeth",
            icon: "assets/icons/ic_hadeth.svg",
          ),
          buildBottomNavItem(label: "Sebha", icon: "assets/icons/ic_sebha.svg"),
          buildBottomNavItem(label: "Radio", icon: "assets/icons/ic_radio.svg"),
          buildBottomNavItem(label: "Time", icon: "assets/icons/ic_time.svg"),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavItem({
    required String label,
    required String icon,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(icon, width: 20, height: 20),
      label: label,
      activeIcon: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(66),
          color: AppColors.black.withValues(alpha: 0.6),
        ),
        child: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          color: AppColors.white,
        ),
      ),
    );
  }
}
