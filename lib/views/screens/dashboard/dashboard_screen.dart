import 'dart:convert';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:aci_app/views/screens/dashboard/dashboard_2.dart';
import 'package:aci_app/views/screens/signup/signup_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/models/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Banners> banners = [];
  List<CategoryElement> categories = [];
  bool isLoading = true;

  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return shouldExit ?? false; // Ensure a non-null boolean is returned
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      onPopInvoked: (canPop) async {
        if (!canPop) {
          bool shouldExit = await _onWillPop();
          if (shouldExit) {
            // Exit the app or navigate to a different screen
          }
        }
      },
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(screenWidth),
        body: isLoading
            ? _buildLoadingIndicator()
            : _buildDashboard(screenWidth, screenHeight),
      ),
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
      ],
    );
  }

  Widget _buildBackgroundImage(double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.45,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.backImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGradientContainer(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Center(
        child: Container(
          height: screenHeight * 0.35,
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
      padding: EdgeInsets.only(top: screenHeight * 0.64),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.2, // Adjust the height as needed
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              banners.isNotEmpty
                  ? 'https://aci.aks.5g.in/${banners.last.imageUrl}'
                  : '', // Ensure proper URL handling
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(double screenWidth, double screenHeight) {
    return Positioned(
      top: screenHeight * 0.01,
      left: 5,
      right: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: banners.isNotEmpty
            ? CarouselSlider(
                options: CarouselOptions(
                    height: screenHeight * 0.2,
                    autoPlay: true,
                    viewportFraction: 0.98),
                items: banners.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: Image.network(
                            'https://aci.aks.5g.in/${banner.imageUrl}',
                            fit: BoxFit.fill),
                      );
                    },
                  );
                }).toList(),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildCategories(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.265),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.1),
            child: Text(
              'Repair Services',
              style: FontConstant.styleBold(
                  fontSize: screenWidth * 0.045, color: Colors.white),
            ),
          ),
          Column(
            children: categories.map(
              (item) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<AuthController>()
                          .fetchSubCategories(categoryid: item.id);
                      final remainingItems = categories
                          .where((category) => category.id != item.id)
                          .map(
                            (category) => CategoryElement(
                              id: category.id,
                              name: category.name,
                            ),
                          )
                          .toList();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Dashboard2(
                            remainingItems: remainingItems,
                            categoryId: item.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.0001),
                      decoration: BoxDecoration(
                        color: AppColors.boxLight,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            child: const Icon(
                              Icons.check_circle,
                              color: AppColors.checkColor,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Text(
                              item.name,
                              style: FontConstant.styleMedium(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeData() async {
    await TokenStorage.loadToken(); // Load the token before making requests
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://aci.aks.5g.in/api/dashboard');
    final token = TokenStorage.token;

    if (token == null) {
      return;
    }

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
        final dashboardResponse = Dashboard.fromJson(jsonResponse);
        setState(() {
          banners = dashboardResponse.data.banner;
          categories = dashboardResponse.data.category;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
