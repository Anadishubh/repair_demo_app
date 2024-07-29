import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';

class RepairMethodologyPage extends StatefulWidget {
  const RepairMethodologyPage({super.key});

  @override
  State<RepairMethodologyPage> createState() => _RepairMethodologyPageState();
}

class _RepairMethodologyPageState extends State<RepairMethodologyPage> {
  final AuthController _authController = Get.find<AuthController>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataWithDelay();
  }

  Future<void> _fetchDataWithDelay() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Repair Methodology',
          style: FontConstant.styleSemiBold(fontSize: 15, color: Colors.white),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < _authController.information.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: HtmlWidget(
                        _authController.information[i],
                        textStyle: FontConstant.styleRegular(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      'https://aci.aks.5g.in/${_authController.image.first}',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
