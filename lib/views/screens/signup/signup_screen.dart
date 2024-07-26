// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:aci_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aci_app/constants/button_constant.dart';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/constants/textfield_constant.dart';
import 'package:aci_app/utils/color.dart';
import '../../../utils/images.dart';

class TokenStorage {
  static String? token;

  static Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print("Loaded Token: $token"); // Debugging line
  }

  static Future<void> saveToken(String newToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', newToken);
    token = newToken;
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  bool isLoading = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }


  // Future<void> _signup() async {
  //   String url = 'https://aci.aks.5g.in/api/login';
  //   var body = {
  //     'name': nameController.text.trim(),
  //     'email': emailController.text.trim(),
  //     'mobile_no': mobileNoController.text.trim(),
  //   };

  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     var response = await http.post(Uri.parse(url), body: body);
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);

  //       String token = jsonResponse['token'];
  //       Get.offAllNamed('/dash');
  //       TokenStorage.token = token;
  //       await saveToken(token);
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Signup failed. Please try again.')),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('An error occurred. Please try again.')),
  //     );
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // Future<void> saveToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.055),
                  child: ClipOval(
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(screenWidth * 0.2),
                        image: const DecorationImage(
                          image: AssetImage(Images.logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Signup',
                style: FontConstant.styleMedium(
                  fontSize: screenWidth * 0.08,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      labelText: 'Name',
                      color: AppColors.primaryColor,
                      validator: _validateName,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Your Email',
                      color: AppColors.primaryColor,
                      validator: _validateEmail,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomTextField(
                      maxlength: 10,
                      keyboardType: TextInputType.number,
                      controller: mobileNoController,
                      labelText: 'Mobile No.',
                      color: AppColors.primaryColor,
                      validator: _validateMobile,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : CustomButton(
                        text: 'Sign Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.find<AuthController>().loginapi(
                                context: context,
                                name: nameController.text.trim(),
                                number: mobileNoController.text.trim(),
                                emailid: emailController.text.trim());
                          }
                        },
                        color: AppColors.primaryColor,
                        textStyle: FontConstant.styleRegular(
                          fontSize: screenWidth * 0.06,
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a User?',
                    style: FontConstant.styleRegular(
                      fontSize: screenWidth * 0.045,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed('/login');
                    },
                    child: Text(
                      ' Login',
                      style: FontConstant.styleBold(
                        fontSize: screenWidth * 0.05,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle Google sign-up
                    },
                    icon: Image.asset(
                      Images.google,
                      height: screenWidth * 0.08,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  IconButton(
                    onPressed: () {
                      // Handle Facebook sign-up
                    },
                    icon: Image.asset(
                      Images.facebook,
                      height: screenWidth * 0.08,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  IconButton(
                    onPressed: () {
                      // Handle Twitter sign-up
                    },
                    icon: Image.asset(
                      Images.twitter,
                      height: screenWidth * 0.08,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
