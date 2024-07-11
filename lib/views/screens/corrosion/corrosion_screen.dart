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

  void _onOptionTap(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
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
            Get.back();
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.bottomBar,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Select option below:',
            style: FontConstant.styleBold(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 20),
          ...List.generate(options.length, (index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => _onOptionTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? AppColors.lightColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
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
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
        ]),
      ),
    );
  }
}
