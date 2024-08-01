import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key, int? categoryId});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
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
    // Display static FAQ content
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFaqItem(
            'What does Adhar Repair App Do?',
            'Adhar Repair APP is an interactive mobile tool that not only makes understanding of structural distress easy but also allows its users to find solutions specific to their building situation.',
          ),
          _buildFaqItem(
            'How Does Adhar app work?',
            'Adhar App explains structural cracks are manifestation of internal Stresses/ Reversal processes/ Anomalies in a structure and are not just surface aberrations.',
          ),
          _buildFaqItem(
            'Does the app help identifying visual clues of distress?',
            'Overall aim of the app is to understand the root cause of visual distress and whether it is local or global.',
          ),
          _buildFaqItem(
            'Does the App help assess life of the repairs?',
            'Also, when to begin the repairs and how late is too late along with life term assessment of repairs (how long are these going to last).',
          ),
        ],
      );
    }
  }

  Widget _buildFaqItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Q. $question',
          style: FontConstant.styleSemiBold(
              fontSize: 16, color: AppColors.primaryColor),
        ),
        const SizedBox(height: 10),
        Text(
          'A. $answer',
          style: FontConstant.styleRegular(
              fontSize: 15, color: AppColors.primaryColor),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
