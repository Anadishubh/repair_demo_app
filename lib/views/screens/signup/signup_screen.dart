import 'package:aci_app/controller/auth_controller.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
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

  Future<void> _sendOTP(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Get.find<AuthController>().loginapi(
            context: context,
            name: nameController.text.trim(),
            number: mobileNoController.text.trim(),
            emailid: emailController.text.trim());
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verificationId for later use
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => OTPVerificationSheet(
            verificationId: verificationId,
            nameController: nameController,
            emailController: emailController,
            mobileNoController: mobileNoController,
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

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
                      _sendOTP(mobileNoController.text.trim());
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
            ],
          ),
        ),
      ),
    );
  }
}

class OTPVerificationSheet extends StatefulWidget {
  final String verificationId;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileNoController;

  const OTPVerificationSheet({
    super.key,
    required this.verificationId,
    required this.nameController,
    required this.emailController,
    required this.mobileNoController,
  });

  @override
  State<OTPVerificationSheet> createState() => _OTPVerificationSheetState();
}

class _OTPVerificationSheetState extends State<OTPVerificationSheet> {
  final TextEditingController otpController = TextEditingController();
  final OtpFieldController otpbox = OtpFieldController();
  String _smsCode = "";
  String? finalotpp;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _listenForSms();
  }

  void splitOtpMessage(String message) {
    RegExp otpRegex = RegExp(r'\d{6}');
    String otp = otpRegex.stringMatch(message) ?? '';
    String remainingText = message.replaceAll(otp, '').trim();
    finalotpp = otp;
    print('OTP: $otp');
    print('Text: $remainingText');
  }

  Future<void> _listenForSms() async {
    try {
      _smsCode = (await AltSmsAutofill().listenForSms)!;
      if (_smsCode.isNotEmpty) {
        otpbox.set(_smsCode.split(""));
        otpController.text = _smsCode;
        splitOtpMessage(otpController.text);
      } else {
        _showTopSnackBar(context, 'Failed to auto-fill OTP', Colors.orange);
      }
    } catch (e) {
      print("Failed to listen for SMS: $e");
      _showTopSnackBar(context, 'Error listening for SMS', Colors.red);
    }
  }

  Future<void> _verifyOTP(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      print("Entered OTP: $finalotpp");

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: finalotpp.toString(),
      );
      UserCredential userCredential =
      await auth.signInWithCredential(credential);
      print("User signed in: ${userCredential.user?.uid}");
      await Get.find<AuthController>().loginapi(
        context: context,
        name: widget.nameController.text.trim(),
        number: widget.mobileNoController.text.trim(),
        emailid: widget.emailController.text.trim(),
      );

      // Navigate to the dashboard
      Get.offAndToNamed('/dash');
    } catch (e) {
      // Log the error and show a SnackBar with the error message
      print("Error during OTP verification: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect OTP or verification failed'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Reset loading state
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Enter 6-digit OTP',
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          OTPTextField(
            outlineBorderRadius: 10,
            controller: otpbox,
            length: 6,
            width: screenWidth,
            fieldWidth: 50,
            style: const TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              otpController.text = pin;
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: isLoading ? null : () => _verifyOTP(context),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
              'Verify',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }

  void _showTopSnackBar(BuildContext context, String message, Color color) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
