import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';

class HadethScreen extends StatefulWidget {
  const HadethScreen({super.key});

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {

  List<Hadeth> ahadeth = [];
  @override
  void initState() {
    readFiles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/hadeth_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.black.withValues(alpha: 0.7), AppColors.black],
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/logo/home_logo.png", width: 290),
              SizedBox(height: 50),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: ahadeth.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.asset("assets/images/img_left_corner.png",color: AppColors.black,),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      ahadeth[index].title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset("assets/images/img_right_corner.png",color: AppColors.black,),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Column(
                                  children: [
                                    Flexible(child: Image.asset("assets/images/hadeth_card_bg.png",fit: BoxFit.cover,)),
                                    Positioned(
                                        right: -30,
                                        left: -30,
                                        child: Image.asset("assets/images/hadeth_card.png"))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(ahadeth[index].body,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: double.infinity,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void readFiles()async{
    for(int i = 1 ; i <= 50 ; i++){
      String data =await rootBundle.loadString("assets/hadeeth/h$i.txt");
      data = data.trim();
      String title = data.split("\n")[0].trim();
      String body = data.split("\n")[1].trim();

      ahadeth.add(Hadeth(title: title, body: body));
    }
    setState(() {});
  }
}

class Hadeth{
  String title;
  String body;

  Hadeth({required this.title , required this.body});

}
