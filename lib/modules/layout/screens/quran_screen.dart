import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/constant/sura_model.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/sura_details/screens/quran_details_screen.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/quran_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.black.withValues(alpha: 0.7),
                    AppColors.black,
                  ],
                  end: AlignmentGeometry.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Image.asset("assets/logo/home_logo.png", width: 300),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: AppColors.white,
                            endIndent: 50,
                            indent: 50,
                            height: 24,
                          );
                        },
                        padding: EdgeInsets.all(8),
                        itemCount: SuraModel.getAllSura().length,

                        itemBuilder: (context, index) {
                          var sura = SuraModel.getAllSura()[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return QuranDetailsScreen(sura: sura,);
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Stack(
                                  alignment: AlignmentGeometry.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/img_sur_number_frame.png",
                                      width: 55,
                                      height: 55,
                                    ),
                                    Text(
                                      (sura.id + 1).toString(),
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      sura.nameEn,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "${sura.ayaNumber} Verses",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  sura.nameAr,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
