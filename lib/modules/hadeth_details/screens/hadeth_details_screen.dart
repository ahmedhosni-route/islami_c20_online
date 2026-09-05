import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/layout/screens/hadeth_screen.dart';

class HadethDetailsScreen extends StatelessWidget {
  final Hadeth hadeth;
  const HadethDetailsScreen({super.key, required this.hadeth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        surfaceTintColor: AppColors.black,
        foregroundColor: AppColors.gold,
        title: Text(hadeth.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset("assets/images/img_left_corner.png"),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      hadeth.title,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.gold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset("assets/images/img_right_corner.png"),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              child: Text(
                hadeth.body,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                  height: 2,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
