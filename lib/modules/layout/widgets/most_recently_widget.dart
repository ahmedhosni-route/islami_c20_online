import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/constant/sura_model.dart';

import '../../../core/theme/app_colors.dart';

class MostRecentlyWidget extends StatelessWidget {
  final SuraModel sura;
  const MostRecentlyWidget({super.key,required this.sura});

  @override
  Widget build(BuildContext context) {
    return                     Container(
      padding: EdgeInsets.all(12),
      width: 280,
      height: 150,
      decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(20)
      ),
      child:Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(sura.nameEn,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),   Text(sura.nameAr,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),
                Text("${sura.ayaNumber} Verses",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                ),),
              ],
            ),
          ),
          Image.asset("assets/images/img_most_recent.png")
        ],
      ),
    );
  }
}
