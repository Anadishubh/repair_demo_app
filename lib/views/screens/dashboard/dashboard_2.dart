import 'dart:convert';
import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/utils/color.dart';
import 'package:aci_app/utils/images.dart';
import 'package:aci_app/utils/models/beam_column.dart';
import 'package:aci_app/views/screens/signup/signup_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/models/dashboard.dart';
import '../crack_beam/beam_column.dart';

// ignore: must_be_immutable
class Dashboard2 extends StatefulWidget {
  final List<CategoryElement> remainingItems;
  int? categoryId;
  Dashboard2({super.key, required this.remainingItems, this.categoryId});

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  List<Banners> banners = [];
  List<CategoryElement> categories = [];
  bool isLoading = true;
  final AuthController _authController = Get.find<AuthController>();
  int? _previouslyHiddenCategoryId;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _initializeCategories();
  }

  List<int> _allCategoriesExcludingStatic = [];

  void _initializeCategories() {
    _allCategoriesExcludingStatic = categories
        .where((item) => item.id != widget.categoryId)
        .map((item) => item.id)
        .toList();
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
        _buildGridView(screenWidth, screenHeight),
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
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildGradientContainer(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          bottom: screenHeight * 0.11),
      child: Center(
        child: Container(
          height: screenHeight * 0.24,
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
      padding: EdgeInsets.only(top: screenHeight * 0.68),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                NetworkImage('https://aci.aks.5g.in/${banners.last.imageUrl}'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
      child: CarouselSlider(
        options: CarouselOptions(
            height: screenHeight * 0.2, autoPlay: true, viewportFraction: 1),
        items: banners.map((banner) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.network('https://aci.aks.5g.in/${banner.imageUrl}',
                    fit: BoxFit.fill),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategories(double screenWidth, double screenHeight) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.245),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.09),
                child: Text(
                  'Repair Services',
                  style: FontConstant.styleBold(
                      fontSize: screenWidth * 0.04, color: Colors.white),
                ),
              ),
              Column(
                children: _authController.subCategories.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.007,
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1),
                    child: GestureDetector(
                      onTap: () {
                        if (item.columnAndBeam) {
                          _showBottomSheet(context, item);
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BeamColumn(
                                images: item.images,
                                categoryId: item.categoryId,
                                subcategoryId: item.id,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.boxLight,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.04),
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
                                    fontSize: 14,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
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

  Widget _buildGridView(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.48, left: 10, right: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (screenWidth / 2.4) / (screenHeight * 0.05),
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          final isStatic = item.id == widget.categoryId;
          final isHidden = _previouslyHiddenCategoryId == item.id;

          if (isStatic) {
            return isHidden
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        _previouslyHiddenCategoryId = item.id;
                        Get.find<AuthController>()
                            .fetchSubCategories(categoryid: item.id);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        padding: EdgeInsets.all(screenWidth * 0.0),
                        child: Center(
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: FontConstant.styleSemiBold(
                                fontSize: 13, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  );
          } else {
            return isHidden
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        _previouslyHiddenCategoryId = item.id;
                        Get.find<AuthController>()
                            .fetchSubCategories(categoryid: item.id);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        padding: EdgeInsets.all(screenWidth * 0.0),
                        child: Center(
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: FontConstant.styleSemiBold(
                              fontSize: 13,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          }
        },
      ),
      // GridView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: screenWidth * 0.02,
      //     mainAxisSpacing: screenHeight * 0.01,
      //     childAspectRatio: (screenWidth / 2.8) / (screenHeight * 0.07),
      //   ),
      //   itemCount: categories.length,
      //   itemBuilder: (context, index) {
      //     final item = categories[index];
      //     return GestureDetector(
      //       onTap: () {
      // Get.find<AuthController>()
      //     .fetchSubCategories(categoryid: item.id);
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: AppColors.greyLight,
      //             borderRadius: BorderRadius.circular(screenWidth * 0.02),
      //           ),
      //           padding: EdgeInsets.all(screenWidth * 0.0),
      //           child: Center(
      //             child: Text(
      //               item.name,
      //               textAlign: TextAlign.center,
      //               style: FontConstant.styleSemiBold(
      //                   fontSize: screenWidth * 0.04,
      //                   color: AppColors.primaryColor),
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
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
      print('No token available');
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
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}

void _showBottomSheet(BuildContext context, SubCategory subCategory) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BeamColumn(
                        images: subCategory.beamImages,
                        categoryId: subCategory.categoryId,
                        subcategoryId: subCategory.id,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: 3.14,
                      child: Image.asset(
                        Images.beam,
                        height: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      'Beam',
                      style: FontConstant.styleRegular(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BeamColumn(
                        images: subCategory.images,
                        categoryId: subCategory.categoryId,
                        subcategoryId: subCategory.id,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
