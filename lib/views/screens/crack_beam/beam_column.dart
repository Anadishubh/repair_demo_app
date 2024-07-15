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
    Images.img1,
    Images.img2,
    Images.img3,
    Images.img4,
  ];

  bool isYesSelected = false;
  bool isYesTapped = false;

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
            Get.offAndToNamed('/dash');
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 550,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                    child: Text(
                      'Are you facing anything like these?',
                      style: FontConstant.styleBold(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 110),
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
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isYesSelected = true;
                          isYesTapped = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.lightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isYesTapped)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primaryColor,
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Yes',
                              style: FontConstant.styleBold(
                                  fontSize: 18, color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isYesSelected = false;
                          isYesTapped = false;
                        });
                        Get.offAndToNamed('/dash');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.lightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'No',
                            style: FontConstant.styleBold(
                                fontSize: 18, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isYesSelected)
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Do you want to know more?',
                        style: FontConstant.styleMedium(
                            fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.offAndToNamed('/corrosion');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.lightColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: FontConstant.styleBold(
                                      fontSize: 18, color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.offAndToNamed('/dash');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.lightColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'No',
                                  style: FontConstant.styleBold(
                                      fontSize: 18, color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}