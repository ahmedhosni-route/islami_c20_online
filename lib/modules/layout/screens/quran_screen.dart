import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islam_c20_online/core/constant/sura_model.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/layout/widgets/most_recently_widget.dart';
import 'package:islam_c20_online/modules/sura_details/screens/quran_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranScreen extends StatefulWidget {
  QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<SuraModel> suraSearch = [];
  List<SuraModel> mostRecently = [];
  bool isSearch = false;
  @override
  void initState() {
    getSura();
    super.initState();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/logo/home_logo.png",
                        width: 300,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            isSearch = true;
                          } else {
                            isSearch = false;
                          }
                          search(value);
                        },
                        style: TextStyle(color: AppColors.white),
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "ابحث عن السورة",
                          hintStyle: TextStyle(color: AppColors.white,fontFamily: GoogleFonts.tajawal().fontFamily),
                          fillColor: AppColors.black.withValues(alpha: 0.7),
                          filled: true,
                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icons/ic_quran.svg",
                              color: AppColors.gold,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.gold),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.gold),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.gold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    if (mostRecently.isNotEmpty)
                      Text(
                        "Most Recently",
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    if (mostRecently.isNotEmpty) SizedBox(height: 12),
                    if (mostRecently.isNotEmpty)
                      SizedBox(
                        height: 130,
                        child: ListView.separated(
                          itemCount: mostRecently.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return MostRecentlyWidget(
                              sura: mostRecently[index],
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 12),
                    Expanded(
                      child: isSearch && suraSearch.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    "لا يوجد سور ",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: AppColors.white,
                                  endIndent: 50,
                                  indent: 50,
                                  height: 24,
                                );
                              },
                              padding: EdgeInsets.all(8),
                              itemCount: !isSearch
                                  ? SuraModel.getAllSura().length
                                  : suraSearch.length,

                              itemBuilder: (context, index) {
                                var sura = !isSearch
                                    ? SuraModel.getAllSura()[index]
                                    : suraSearch[index];
                                return InkWell(
                                  onTap: () {
                                    saveSura(sura);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return QuranDetailsScreen(sura: sura);
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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

  void search(String q) {
    suraSearch.clear();
    for (var e in SuraModel.getAllSura()) {
      if (e.nameAr.contains(q) ||
          e.nameEn.toLowerCase().contains(q.toLowerCase())) {
        suraSearch.add(e);
      }
      setState(() {});
    }
  }

  void saveSura(SuraModel sura) async {
    mostRecently.insert(0, sura);
    mostRecently = mostRecently.toSet().toList();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> suraList = List.generate(5, (index) {
      return mostRecently[index].id.toString();
    });
    await prefs.setStringList("mostRecently", suraList);
    setState(() {});
  }

  void getSura() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> suraList = prefs.getStringList("mostRecently") ?? [];
    List<SuraModel> allSura = SuraModel.getAllSura();
    allSura.where((element) {
      if (suraList.contains(element.id.toString())) {
        mostRecently.add(element);
      }
      return true;
    }).toList();

    setState(() {});
  }
}
