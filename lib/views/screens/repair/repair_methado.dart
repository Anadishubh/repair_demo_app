import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairMethodologyPage extends StatefulWidget {
  const RepairMethodologyPage({super.key});

  @override
  State<RepairMethodologyPage> createState() => _RepairMethodologyPageState();
}

class _RepairMethodologyPageState extends State<RepairMethodologyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Repair Methodology',
          style: FontConstant.styleSemiBold(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Get.offAndToNamed('corrosion');
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Dummy heading a shear Crack in RCC ?',
                style: FontConstant.styleSemiBold(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                'It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15),
              child: Text(
                'It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 20),
              child: Text(
                'Dummy heading a shear Crack in RCC ?',
                style: FontConstant.styleSemiBold(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                'It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15),
              child: Text(
                'It is postulated that various modes of diagonal failure exhibited multiaxial stress conditions load that exits in the pathn along which the comprehensive force is transmitted from support.',
                style: FontConstant.styleMedium(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
