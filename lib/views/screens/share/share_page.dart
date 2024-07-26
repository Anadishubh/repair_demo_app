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
                  await _shareViaEmail('Hello, check this out!');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  backgroundColor: AppColors.lightColor, // Text and icon color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  Future<void> _shareViaEmail(String text) async {
    const String recipientEmail = 'info@aci-india.co.in';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      query: Uri.encodeQueryComponent('subject=Check this out&body=$text'),
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'Could not launch $emailUri';
      }
    } catch (e) {
      print('Error sharing content via email: $e');
    }
  }
}