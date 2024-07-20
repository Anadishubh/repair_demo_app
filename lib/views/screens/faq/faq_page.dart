import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../constants/button_constant.dart';
import '../../../controller/auth_controller.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  bool isLoading = true;
  bool isYesTapped = false;
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.055,
          vertical: MediaQuery.of(context).size.height * 0.09,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  Images.logo,
                  height: 40,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'ADHAR CONSULTANCY\nAND INFRASTRUCTURE',
                  style: FontConstant.styleBold(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Implement share functionality
                  },
                  child: const Icon(
                    Icons.share,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            HtmlWidget(_authController.subCategories[0].faq),
            const SizedBox(height: 30),
            CustomShadowButton(
              text: 'Book Appointment',
              onPressed: () {
                Get.offAndToNamed('/visit');
              },
              color: AppColors.primaryColor,
              textStyle:
                  FontConstant.styleSemiBold(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
