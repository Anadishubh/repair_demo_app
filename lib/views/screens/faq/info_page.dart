import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isLoading = true;
  bool isYesTapped = false;

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
            Text(
              'About Us',
              style: FontConstant.styleSemiBold(
                  fontSize: 17, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            Text(
              'This is to introduce AC&I (Adhar Consultancy & Infrastructure), is a cutting edge technology company that works towards solution based strengthening of existing buildings and other structures to improve their service existence span and make them earthquake resistant by means of repair & retrofits.',
              style: FontConstant.styleRegular(
                  fontSize: 15, color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'AC&I comprises of experienced professionals that execute niche range of engineering services for existing buildings and other structures through scientific assessments and economical design based solutions. We restore requisite structural strength of the buildings by sourcing the best technologies from around the globe.',
              style: FontConstant.styleRegular(
                  fontSize: 15, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
