import 'dart:convert';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/views/screens/arrangevisit/arrange_visit_page.dart';
import 'package:aci_app/views/screens/arrangevisit/form_page.dart';
import 'package:aci_app/views/screens/repair/repair_methado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/app_constant.dart';
import '../../../utils/models/questions.dart';

class CorrosionScreen extends StatefulWidget {
  final int? categoryId;
  final int? subcategoryId;

  const CorrosionScreen({super.key, this.categoryId, this.subcategoryId});

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
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.questions}');
    final token = Get.find<AuthController>().getAuthToken();

    try {
      setState(() {
        isLoading = true;
        questions = [];
      });

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "category_id": widget.categoryId,
          "sub_category_id": widget.subcategoryId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['data'] != null && jsonResponse['data'] is List) {
          final questionsResponse = (jsonResponse['data'] as List)
              .map((data) => Datum.fromJson(data))
              .toList();
          setState(() {
            questions = questionsResponse;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print('No question data available');
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized: ${response.body}');
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
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
            Get.offAndToNamed('/dash');
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
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });

                                final selectedQuestion = questions[index];
                                final authController =
                                    Get.find<AuthController>();

                                if (index == 0) {
                                  authController.getquestionlistt(
                                    categoryId: widget.categoryId,
                                    subcategoryId: widget.subcategoryId,
                                    questionId1: selectedQuestion.id,
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ArrangeVisitPage(),
                                    ),
                                  );
                                  // Get.toNamed('/visit');
                                } else if (index == 1) {
                                  authController.informationList(
                                    categoryId: widget.categoryId,
                                    subcategoryId: widget.subcategoryId,
                                    questionId2: selectedQuestion.id,
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RepairMethodologyPage(),
                                    ),
                                  );
                                  //  Get.toNamed('/repair');
                                } else if (index == 2) {
                                  authController.formList(
                                    categoryId: widget.categoryId,
                                    subcategoryId: widget.subcategoryId,
                                    questionId3: selectedQuestion.id,
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const FormPage(),
                                    ),
                                  );
                                  // Get.toNamed('/form');
                                }
                              },
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
                                          MediaQuery.of(context).size.height *
                                              0.05,
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
                                    const SizedBox(height: 10),
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
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
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
