import 'package:aci_app/constants/button_constant.dart';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeamColumn extends StatefulWidget {
  const BeamColumn({super.key});

  @override
  State<BeamColumn> createState() => _BeamColumnState();
}

class _BeamColumnState extends State<BeamColumn> {
  final List<String> imagePaths = [
    Images.img1, // Replace with your actual image paths
    Images.img2,
    Images.img3,
    Images.img4,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        title: Text(
          'Crack Awareness / Corrosion Crack / Beam',
          style: FontConstant.styleBold(fontSize: 15, color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 430,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: AppColors.greyLight),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    'Are you facing anything like these ?',
                    style: FontConstant.styleBold(
                        fontSize: 18, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 150),
                      itemCount: imagePaths.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(imagePaths[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20.0),
            child: Text(
              'Do you want to know more about this?',
              style: FontConstant.styleBold(
                  fontSize: 14, color: AppColors.textColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: CustomButton(
              text: 'Yes',
              onPressed: () {
                Get.toNamed('/corrosion');
              },
              color: AppColors.primaryColor,
              textStyle:
                  FontConstant.styleBold(fontSize: 18, color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/faq');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    Images.help,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Frequently Asked Question ?',
                    style: FontConstant.styleRegular(
                        fontSize: 14, color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
