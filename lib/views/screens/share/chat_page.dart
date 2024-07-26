import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 348.0),
        child: Column(
          children: [
            Text(
              'Want to Tell your query Direct ?',
              style: FontConstant.styleSemiBold(
                  fontSize: 16, color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  openWhatsAppWithNumber(
                      '9873596738', 'Hello, want to Talk more!!');
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
                      Images.whatsapp2,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text('Chat on WhatsApp'),
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

Future<void> openWhatsAppWithNumber(String phoneNumber, String message) async {
  final url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
