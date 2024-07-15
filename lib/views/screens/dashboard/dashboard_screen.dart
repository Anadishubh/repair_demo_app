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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Dashboard',
          style: FontConstant.styleBold(
              fontSize: screenWidth * 0.045, color: Colors.white),
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
            height: screenHeight * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.backImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.11,
                left: screenWidth * 0.07,
                right: screenWidth * 0.07,
                bottom: screenHeight * 0.07),
            child: Center(
              child: Container(
                height: screenHeight * 0.32,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
            padding: EdgeInsets.only(
                top: screenHeight * 0.57, left: screenWidth * 0.07),
            child: Text(
              'ENGINEERS IN YOUR \nAREA TODAY!',
              style: FontConstant.styleBold(
                  fontSize: screenWidth * 0.05, color: AppColors.primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.63),
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
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: screenHeight * 0.2,
                      autoPlay: true,
                      viewportFraction: 0.98),
                  items: [Images.repair, Images.repair, Images.repair].map(
                    (imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.01),
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
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.09),
                  child: Text(
                    'Repair Services',
                    style: FontConstant.styleBold(
                        fontSize: screenWidth * 0.05, color: Colors.white),
                  ),
                ),
                Column(
                  children: items.map(
                    (item) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.009,
                            left: screenWidth * 0.11,
                            right: screenWidth * 0.11),
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.005),
                            decoration: BoxDecoration(
                              color: AppColors.boxLight,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.02),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.05),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: AppColors.checkColor,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  item,
                                  style: FontConstant.styleMedium(
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.white),
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
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
                            height: MediaQuery.of(context).size.width * 0.2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text('Column',
                              style: FontConstant.styleRegular(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Colors.black))
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
                            height: MediaQuery.of(context).size.width * 0.2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Beam',
                            style: FontConstant.styleRegular(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                color: Colors.black),
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
}
