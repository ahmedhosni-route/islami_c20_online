import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islam_c20_online/core/constant/sura_model.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranDetailsScreen extends StatefulWidget {
  SuraModel sura;
  QuranDetailsScreen({super.key, required this.sura});

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  ScrollController controller = ScrollController();
  List<String> suraList = [];
  String savedAya = "";
  @override
  Widget build(BuildContext context) {
    if (suraList.isEmpty) {
      readFile();
    }
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        surfaceTintColor: AppColors.black,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
        title: Text(widget.sura.nameEn),
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
                      widget.sura.nameAr,
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

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: suraList.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.all(4),
            //         padding: EdgeInsets.all(16),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: AppColors.gold),
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         child: Center(
            //           child: Text(
            //             "${suraList[index]} [${index + 1}]",
            //             style: TextStyle(
            //               color: AppColors.gold,
            //               fontWeight: FontWeight.w700,
            //               fontSize: 16,
            //             ),
            //             textAlign: TextAlign.center,
            //             textDirection: TextDirection.rtl,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    if (widget.sura.id != 0 && widget.sura.id != 8)
                      Text(
                        "بسم الله الرحمن الرحيم",
                        style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 3,
                          fontFamily: GoogleFonts.amiriQuran().fontFamily,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    Text.rich(
                      TextSpan(
                        children: suraList.map((e) {
                          int index = suraList.indexOf(e);
                          return TextSpan(
                            text: "$e[${index + 1}]  ",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (savedAya == e) {
                                  removeSaved();
                                  setState(() {});
                                  return;
                                }
                                saveAya(e);
                                savedAya = e;
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(
                                        "تم حفظ الاية",
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                    width: 120,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.gold,
                                  ),
                                );
                              },

                            style: TextStyle(
                              backgroundColor: savedAya == e
                                  ? Colors.orange.withValues(alpha: 0.2)
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 3,
                        fontFamily: GoogleFonts.amiriQuran().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void readFile() async {
    String data = await rootBundle.loadString(
      "assets/suras/${widget.sura.id + 1}.txt",
    );
    data = data.trim();
    suraList = data.split("\n");
    getSavedAya();
    print(suraList);
    setState(() {});
  }

  void saveAya(String aya) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("aya", aya);
    await prefs.setDouble("scroll", controller.offset);
  }

  void getSavedAya() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedAya = prefs.getString("aya") ?? "";
    if (savedAya.isNotEmpty && suraList.contains(savedAya)) {
      double offset = prefs.getDouble("scroll") ?? 0;
      controller.animateTo(
        offset,
        duration: Duration(seconds: 2),
        curve: Curves.ease,
      );
      setState(() {});
    }
  }

  void removeSaved() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("aya");
    await prefs.remove("scroll");
    savedAya = "";
    setState(() {});
  }
}
