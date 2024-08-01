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
  String? categroyname;
  Dashboard2(
      {super.key,
      required this.remainingItems,
      this.categoryId,
      this.categroyname});

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
          : _buildDashboard(
              screenWidth, screenHeight, widget.categroyname.toString()),
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
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildDashboard(
      double screenWidth, double screenHeight, String categroname) {
    return Stack(
      children: [
        _buildBackgroundImage(screenHeight),
        _buildGradientContainer(screenWidth, screenHeight),
        _buildLogoContainer(screenHeight),
        _buildCarousel(screenWidth, screenHeight),
        _buildCategories(screenWidth, screenHeight, categroname),
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
          bottom: screenHeight * 0.1),
      child: Center(
        child: Container(
          height: screenHeight * 0.245,
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
      padding: EdgeInsets.only(top: screenHeight * 0.65),
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

  Widget _buildCategories(
      double screenWidth, double screenHeight, String catrgoname) {
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
                          _showBottomSheet(context, item, item.name,catrgoname);
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BeamColumn(
                                images: item.images,
                                categoryId: item.categoryId,
                                subcategoryId: item.id,
                                subcatroyesname: item.name,
                                catergonme: catrgoname,
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
                                    fontSize: 14, color: Colors.white),
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
    final visibleCategoryIds =
        _authController.subCategories.map((item) => item.categoryId).toSet();
    final filteredCategories = categories
        .where((item) =>
            !visibleCategoryIds.contains(item.id) ||
            _previouslyHiddenCategoryId == item.id)
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.49, left: 10, right: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (screenWidth / 2.4) / (screenHeight * 0.05),
        ),
        itemCount: filteredCategories.length,
        itemBuilder: (context, index) {
          final item = filteredCategories[index];
          // final isStatic = item.id == widget.categoryId;
          // final isHidden = _previouslyHiddenCategoryId == item.id;

          return GestureDetector(
            onTap: () {
              setState(() {
                final currentHiddenId = _previouslyHiddenCategoryId;
                _previouslyHiddenCategoryId = item.id;

                //  if (!isStatic) {
                Get.find<AuthController>()
                    .fetchSubCategories(categoryid: item.id);
                //}

                //  if (isStatic && currentHiddenId != null) {
                _previouslyHiddenCategoryId = currentHiddenId;
                //}
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
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
        },
      ),
    );
  }

  Future<void> _initializeData() async {
    await TokenStorage.loadToken();
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

void _showBottomSheet(
  BuildContext context,
  SubCategory subCategory,
  subnamee, categrname
) {
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
                        subcatroyesname: subnamee,
                        catergonme: categrname,
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
                        subcatroyesname: subnamee,
                        catergonme: categrname,
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
