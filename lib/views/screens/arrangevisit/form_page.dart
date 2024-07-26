import 'dart:async';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../../../constants/button_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/textfield_constant.dart';
import '../../../utils/color.dart';
import '../../../utils/images.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final AuthController controller = Get.find<AuthController>();

  List<String> answers = ['', '', ''];

  // Method to generate WhatsApp message
  String _generateWhatsAppMessage() {
    String message = '';
    for (int i = 0; i < controller.questions.length; i++) {
      message += '${i + 1}. ${controller.questions[i]}\n';
      message += 'Answer: ${answers[i]}\n\n';
    }
    return message;
  }

  // Method to share via WhatsApp using URL scheme
  Future<void> shareViaWhatsApp() async {
    String message = _generateWhatsAppMessage();
    String phoneNumber = '919873596738'; // Replace with the specific number
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/$phoneNumber?text=$encodedMessage');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool _isLoading = true;

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arrange Visit',
          style: FontConstant.styleBold(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.logo),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (int i = 0; i < controller.form.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10),
                            child: Text(
                              '${i + 1}. ${controller.form[i]}',
                              style: FontConstant.styleBold(
                                  fontSize: 14,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10),
                            child: CustomTextField(
                              onChanged: (value) {
                                setState(() {
                                  answers[i] = value;
                                });
                              },
                              color: AppColors.textField,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      child: Text(
                        'Share details on Whatsapp or Mail',
                        style: FontConstant.styleBold(
                            fontSize: 14, color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CustomBasicButton(
                        text: 'Share on WhatsApp',
                        onPressed: shareViaWhatsApp,
                        color: AppColors.primaryColor,
                        textStyle: FontConstant.styleBold(
                            fontSize: 14, color: Colors.white),
                        image: Image.asset(
                          Images.whatsapp,
                          height: 35,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 15),
                      child: CustomBasicButton(
                        text: 'Share on Mail',
                        onPressed: () {},
                        color: AppColors.primaryColor,
                        textStyle: FontConstant.styleBold(
                            fontSize: 14, color: Colors.white),
                        image: Image.asset(
                          Images.email,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}