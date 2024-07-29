import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/font_constant.dart';
import '../../../utils/color.dart';
import '../../../utils/images.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Want to share via email?',
              style: FontConstant.styleSemiBold(
                  fontSize: 16, color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await launchUrl(Uri.parse(
                      "mailto:info@aci-india.co.in?subject=subject&body=Hello"));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  backgroundColor: AppColors.lightColor, // Text and icon color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Images.send,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Share',
                      style: FontConstant.styleRegular(
                          fontSize: 14, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
