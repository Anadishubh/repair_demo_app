import 'package:aci_app/constants/button_constant.dart';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/constants/textfield_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArrangeVisitPage extends StatefulWidget {
  const ArrangeVisitPage({super.key});

  @override
  State<ArrangeVisitPage> createState() => _ArrangeVisitPageState();
}

class _ArrangeVisitPageState extends State<ArrangeVisitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.16,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '1. Since when are you suffering from these?',
                style: FontConstant.styleBold(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: CustomTextField(
                color: AppColors.textField,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '2. Have you tried to get rid of these?',
                style: FontConstant.styleBold(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: CustomTextField(
                color: AppColors.textField,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '3. What do you think are probable reasons?',
                style: FontConstant.styleBold(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: CustomTextField(
                color: AppColors.textField,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                'Share details on WhatsApp or Mail',
                style: FontConstant.styleBold(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomBasicButton(
                text: 'Share on WhatsApp',
                onPressed: () {},
                color: AppColors.primaryColor,
                textStyle: FontConstant.styleBold(
                  fontSize: 14,
                  color: Colors.white,
                ),
                image: Image.asset(Images.whatsapp, height: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: CustomBasicButton(
                text: 'Share on Mail',
                onPressed: () {},
                color: AppColors.primaryColor,
                textStyle: FontConstant.styleBold(
                  fontSize: 14,
                  color: Colors.white,
                ),
                image: Image.asset(Images.email, height: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}