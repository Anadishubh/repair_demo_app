import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CorrosionScreen extends StatefulWidget {
  const CorrosionScreen({super.key});

  @override
  State<CorrosionScreen> createState() => _CorrosionScreenState();
}

class _CorrosionScreenState extends State<CorrosionScreen> {
  int _selectedIndex = -1;

  final List<String> options = [
    'Tell us more about your condition',
    'Do you want to know repair methodology',
    'Arrange a visit'
  ];

  final List<String> imagePaths = [
    'assets/images/chat.png',
    'assets/images/hammer.png',
    'assets/images/location.png'
  ];

  void _onOptionTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Get.offAndToNamed('/visit');
    } else if (index == 1) {
      Get.offAndToNamed('/repair');
    } else if (index == 2) {
      Get.offAndToNamed('/visit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Corrosion Crack',
          style: FontConstant.styleBold(fontSize: 15, color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.offAndToNamed('/beam');
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.bottomBar,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select option below:',
              style: FontConstant.styleBold(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => _onOptionTap(index),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? AppColors.lightColor
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(imagePaths[index]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                options[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: _selectedIndex == index
                                      ? AppColors.primaryColor
                                      : Colors.black,
                                ),
                              ),
                              if (index == 1) ...[
                                const SizedBox(height: 9,),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.offAndToNamed('/repair');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Yes',
                                    style: FontConstant.styleBold(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
