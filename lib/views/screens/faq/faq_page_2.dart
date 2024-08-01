import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../controller/auth_controller.dart';

class FaqPage2 extends StatefulWidget {
  const FaqPage2({super.key, int? categoryId});

  @override
  State<FaqPage2> createState() => _FaqPage2State();
}

class _FaqPage2State extends State<FaqPage2> {
  bool isLoading = true;
  bool isYesTapped = false;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _buildFaqContent();
  }

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
            _buildHeader(),
            const SizedBox(height: 30),
            _buildFaqContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(CupertinoIcons.back,color: AppColors.primaryColor,),
        ),
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
    );
  }

  Widget _buildFaqContent() {
    if (_authController.subCategories.isNotEmpty &&
        _authController.subCategories[0].faq.isNotEmpty) {
      // Display FAQ content from the controller
      return HtmlWidget(
        _authController.subCategories[0].faq,
        textStyle: FontConstant.styleRegular(
          fontSize: 14,
          color: AppColors.primaryColor,
        ),
      );
    } else {
      // Display static FAQ content
      return const Text('No Data');
    }
  }
}
