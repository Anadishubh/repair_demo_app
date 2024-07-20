import 'dart:convert';
import 'package:aci_app/constants/app_constant.dart';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:aci_app/utils/models/beam_column.dart';
import 'package:aci_app/views/screens/signup/signup_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/models/dashboard.dart';
import '../crack_beam/beam_column.dart';

class Dashboard2 extends StatefulWidget {
  final List<CategoryElement> remainingItems;
  const Dashboard2({super.key, required this.remainingItems});

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  List<String> banners = [];
  List<CategoryElement> categories = [];
  bool isLoading = true;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(screenWidth),
      body: isLoading
          ? _buildLoadingIndicator()
          : _buildDashboard(screenWidth, screenHeight),
    );
  }

  AppBar _buildAppBar(double screenWidth) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      title: Text(
        'Dashboard',
        style: FontConstant.styleBold(
            fontSize: screenWidth * 0.045, color: Colors.white),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDashboard(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        _buildBackgroundImage(screenHeight),
        _buildGradientContainer(screenWidth, screenHeight),
        _buildLogoContainer(screenHeight),
        _buildCarousel(screenWidth, screenHeight),
        _buildCategories(screenWidth, screenHeight),
        Padding(
          padding: const EdgeInsets.only(top: 490, left: 10, right: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              mainAxisExtent: 45,
            ),
            itemCount: widget.remainingItems.length,
            itemBuilder: (context, index) {
              final item = widget.remainingItems[index];
              return GestureDetector(
                onTap: () {
                  Get.find<AuthController>()
                      .fetchSubCategories(categoryid: item.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.transparent),
                    borderRadius:
                        BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: FontConstant.styleSemiBold(
                          fontSize: 14, color: AppColors.primaryColor),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildBackgroundImage(double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.4,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.backImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildGradientContainer(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.0,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          bottom: screenHeight * 0.05),
      child: Center(
        child: Container(
          height: screenHeight * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.boxGrad2,
                AppColors.boxGrad1,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoContainer(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.7),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://aci.aks.5g.in/${banners[4]}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.015,
              left: screenWidth * 0.03,
              right: screenWidth * 0.03),
          child: CarouselSlider(
            options: CarouselOptions(
                height: screenHeight * 0.2,
                autoPlay: true,
                viewportFraction: 0.98),
            items: banners.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Image.network('https://aci.aks.5g.in/$imageUrl',
                        fit: BoxFit.fill),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(double screenWidth, double screenHeight) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.09),
                child: Text(
                  'Repair Services',
                  style: FontConstant.styleBold(
                      fontSize: screenWidth * 0.05, color: Colors.white),
                ),
              ),
              Column(
                children: _authController.subCategories.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1),
                    child: GestureDetector(
                      onTap: () {
                        if (item.columnAndBeam) {
                          _showBottomSheet(context, item);
                        } else {
                          Get.to(
                              BeamColumn(
                                images: item.images,
                              ),
                              duration: const Duration(
                                  milliseconds:
                                      AppConstants.screenTransitionTime),
                              transition: Transition.rightToLeft);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.003),
                        decoration: BoxDecoration(
                          color: AppColors.boxLight,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.05),
                              child: const Icon(
                                Icons.check_circle,
                                color: AppColors.checkColor,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              item.name,
                              style: FontConstant.styleMedium(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://aci.aks.5g.in/api/dashboard');
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
        final dashboardResponse = DashboardResponse.fromJson(jsonResponse);
        setState(() {
          banners = [
            dashboardResponse.data.banner.topBanner1,
            dashboardResponse.data.banner.topBanner2,
            dashboardResponse.data.banner.topBanner3,
            dashboardResponse.data.banner.topBanner4,
            dashboardResponse.data.banner.bottom1,
          ];
          categories = dashboardResponse.data.category;
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print('Failed to load data: ${response.statusCode}');
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showBottomSheet(BuildContext context, SubCategory subCategory) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.to(
                            BeamColumn(
                              images: subCategory.beamImages,
                            ),
                            duration: const Duration(
                                milliseconds:
                                    AppConstants.screenTransitionTime),
                            transition: Transition.rightToLeft);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            Images.beam,
                            height: MediaQuery.of(context).size.width * 0.2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Beam',
                            style: FontConstant.styleRegular(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.to(
                            BeamColumn(
                              images: subCategory.images,
                            ),
                            duration: const Duration(
                                milliseconds:
                                    AppConstants.screenTransitionTime),
                            transition: Transition.rightToLeft);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            Images.column,
                            height: MediaQuery.of(context).size.width * 0.2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Column',
                            style: FontConstant.styleRegular(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
