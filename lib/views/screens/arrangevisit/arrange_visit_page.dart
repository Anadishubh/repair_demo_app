import 'dart:async';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/button_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/textfield_constant.dart';
import '../../../utils/color.dart';
import '../../../utils/images.dart';

class ArrangeVisitPage extends StatefulWidget {
  final int? categroyidddd;
  final int? subcatrd;

  const ArrangeVisitPage({
    super.key,
    this.categroyidddd,
    this.subcatrd,
  });

  @override
  State<ArrangeVisitPage> createState() => _ArrangeVisitPageState();
}

class _ArrangeVisitPageState extends State<ArrangeVisitPage> {
  final AuthController controller = Get.find<AuthController>();
  List<String> answers = [];
  bool _isLoading = true; // Loader state

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false; // Disable loader after 1 second
      });
    });
  }

  void shareViaWhatsApp() async {
    String message = '';
    for (int i = 0; i < controller.questions.length; i++) {
      message += '${i + 1}. ${controller.questions[i]}\n';
      message += 'Answer: ${answers[i]}\n\n';
    }
    await launchUrl(
      Uri.parse(
          "https://api.whatsapp.com/send/?phone=9873596738&text=$message"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            // Get.back(); // Alternative navigation using GetX
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: _isLoading // Display loader if still loading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      } else if (controller.errorMessage.isNotEmpty) {
                        return Center(
                            child: Text(controller.errorMessage.value));
                      } else if (controller.questions.isEmpty) {
                        return Center(
                          child: Text(
                            'No questions available',
                            style: FontConstant.styleBold(
                                fontSize: 14, color: AppColors.primaryColor),
                          ),
                        );
                      } else {
                        // Ensure answers list has the same length as questions
                        if (answers.length != controller.questions.length) {
                          answers = List.generate(
                              controller.questions.length, (_) => '');
                        }

                        return Padding(
                          padding: const EdgeInsets.all(15.0),
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
                              const SizedBox(
                                height: 20,
                              ),
                              for (int i = 0;
                                  i < controller.questions.length;
                                  i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, top: 10),
                                      child: Text(
                                        '${i + 1}. ${controller.questions[i]}',
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
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: Text(
                      'Share details on Whatsapp or Mail',
                      style: FontConstant.styleBold(
                          fontSize: 14, color: AppColors.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        horizontal: 15.0, vertical: 15),
                    child: CustomBasicButton(
                      text: 'Share on Mail',
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse(
                              "mailto:info@aci-india.co.in?subject=subject&body=Hello"),
                        );
                      },
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
}
