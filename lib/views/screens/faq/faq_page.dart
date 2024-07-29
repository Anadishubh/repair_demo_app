import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:aci_app/views/screens/arrangevisit/arrange_visit_page.dart';
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
                const SizedBox(width: 15),
                Image.asset(
                  Images.logo,
                  height: 40,
                ),
                const SizedBox(width: 15),
                Text(
                  'ADHAR CONSULTANCY\nAND INFRASTRUCTURE',
                  style: FontConstant.styleBold(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _authController.subCategories.isNotEmpty &&
                    _authController.subCategories[0].faq.isNotEmpty
                ? HtmlWidget(
                    _authController.subCategories[0].faq,
                    textStyle: FontConstant.styleRegular(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q.	What does Adhar Repair App Do?',
                        style: FontConstant.styleSemiBold(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'A. Adhar Repair APP is an interactive mobile tool that not only makes understanding of structural distress easy but also allows its users to find solutions specific to their building situation.',
                        style: FontConstant.styleRegular(
                            fontSize: 15, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Q.	How Does Adhar app work?',
                        style: FontConstant.styleSemiBold(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Adhar App explains structural cracks are manifestation of internal Stresses/ Reversal processes/ Anomalies in a structure and are not just surface aberrations.',
                        style: FontConstant.styleRegular(
                            fontSize: 15, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Q.	Does the app helps identifying visual clues of distress?',
                        style: FontConstant.styleSemiBold(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'A.	Over all aim of the app understand the root cause of visual distress and whether its local or global.',
                        style: FontConstant.styleRegular(
                            fontSize: 15, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Q.	Does the App help assess life of the repairs?',
                        style: FontConstant.styleSemiBold(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'A.	Also, when to begin the repairs and how late is too late along with life term assessment of repairs (how long are these going to last).',
                        style: FontConstant.styleRegular(
                            fontSize: 15, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
            const SizedBox(height: 30),
            CustomShadowButton(
              text: 'Book Appointment',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ArrangeVisitPage(),
                  ),
                );
              },
              color: AppColors.primaryColor,
              textStyle: FontConstant.styleSemiBold(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
