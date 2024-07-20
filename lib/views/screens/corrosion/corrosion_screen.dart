// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/models/questions.dart';

class TokenStorage {
  static String? token;

  static Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }
}

class CorrosionScreen extends StatefulWidget {
  const CorrosionScreen({super.key});

  @override
  State<CorrosionScreen> createState() => _CorrosionScreenState();
}

class _CorrosionScreenState extends State<CorrosionScreen> {
  int _selectedIndex = -1;
  List<Datum> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    TokenStorage.loadToken().then((_) {
      fetchQuestions();
    });
  }

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

  Future<void> fetchQuestions() async {
    final url = Uri.parse('https://aci.aks.5g.in/api/questionnaires');
    final token = TokenStorage.token;

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final questionsResponse = (jsonResponse['data'] as List)
            .map((data) => Datum.fromJson(data))
            .toList();
        setState(() {
          questions = questionsResponse;
          isLoading = false; // Set isLoading to false when data is fetched
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          isLoading = false; // Set isLoading to false in case of failure
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false; // Set isLoading to false in case of error
      });
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
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select option below:',
                    style: FontConstant.styleBold(
                        fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => _onOptionTap(index),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.width * 0.469,
                                decoration: BoxDecoration(
                                  color: _selectedIndex == index
                                      ? AppColors.lightColor
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            index == 0
                                                ? 'assets/images/chat.png'
                                                : index == 1
                                                    ? 'assets/images/hammer.png'
                                                    : 'assets/images/location.png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      questions[index].questionType,
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
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.offAndToNamed('/repair');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
