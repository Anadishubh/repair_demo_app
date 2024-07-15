import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> items = [
    'Crack Awareness',
    'Building Plaques',
    'Emergency Situations',
    'Looking for alternates',
    'Seismic Safety',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Dashboard',
          style: FontConstant.styleBold(fontSize: 18, color: Colors.white),
        ),
        // leading: IconButton(
        //   icon: Image.asset(Images.menu),
        //   onPressed: () {
        //     // Get.offAndToNamed('/prof');
        //   },
        // ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.backImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 30),
            child: Center(
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.boxGrad2,
                      AppColors.boxGrad1,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 455, left: 25),
            child: Text(
              'ENGINEERS IN YOUR \nAREA TODAY!',
              style: FontConstant.styleBold(
                  fontSize: 20, color: AppColors.primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 500.0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.workLogo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 150.0, autoPlay: true, viewportFraction: 0.98),
                  items: [Images.repair, Images.repair, Images.repair].map(
                    (imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Image.asset(imagePath, fit: BoxFit.fill),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 198.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text(
                    'Repair Services',
                    style: FontConstant.styleBold(
                        fontSize: 20, color: Colors.white),
                  ),
                ),
                Column(
                  children: items.map(
                    (item) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 45, right: 45),
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.boxLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: AppColors.checkColor,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  item,
                                  style: FontConstant.styleMedium(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed('/beam');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          Images.column,
                          height: 80,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('Column',
                            style: FontConstant.styleRegular(
                                fontSize: 19, color: Colors.black))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed('/beam');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          Images.beam,
                          height: 80,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Beam',
                          style: FontConstant.styleRegular(
                              fontSize: 19, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
