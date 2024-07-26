import 'dart:async';

import 'package:aci_app/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import '../../../constants/button_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/textfield_constant.dart';
import '../../../utils/color.dart';
import '../../../utils/images.dart';

class ArrangeVisitPage extends StatefulWidget {
  int? categroyidddd;
  int? subcatrd;
  ArrangeVisitPage({
    super.key,
    this.categroyidddd,
    this.subcatrd,
  });

  @override
  State<ArrangeVisitPage> createState() => _ArrangeVisitPageState();
}

class _ArrangeVisitPageState extends State<ArrangeVisitPage> {
  final AuthController controller = Get.find<AuthController>();

  List<String> answers = ['', '', ''];

  void shareViaWhatsApp() async {
    String message = '';
    for (int i = 0; i < controller.questions.length; i++) {
      message += '${i + 1}. ${controller.questions[i]}\n';
      message += 'Answer: ${answers[i]}\n\n';
    }

    // Share via WhatsApp
    await WhatsappShare.share(
      text: message,
      linkUrl: '',
      phone: '8787787878',
    );
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
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);

            // Get.back();
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            } else {
              return _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
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

                          for (int i = 0; i < controller.questions.length; i++)
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
                          Padding(
                            padding: const EdgeInsets.only(left: 0, top: 0),
                            child: Text(
                              'Share details on Whatsapp or Mail',
                              style: FontConstant.styleBold(
                                  fontSize: 14, color: AppColors.primaryColor),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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

                          // Text(_authController.questionList.first.questionOrInformation.first.question)
                        ],
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
