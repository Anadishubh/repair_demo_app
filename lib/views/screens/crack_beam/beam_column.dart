import 'dart:convert';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/views/screens/arrangevisit/form_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/font_constant.dart';
import '../../../utils/color.dart';
import '../../../utils/models/dashboard.dart';
import '../corrosion/corrosion_screen.dart';
import '../signup/signup_screen.dart';

class BeamColumn extends StatefulWidget {
  final List<String> images;
  final int? categoryId;
  final int? subcategoryId;

  const BeamColumn({
    super.key,
    required this.images,
    this.categoryId,
    this.subcategoryId,
  });

  @override
  State<BeamColumn> createState() => _BeamColumnState();
}

class _BeamColumnState extends State<BeamColumn> {
  List<Banners> banners = [];
  List<CategoryElement> categories = [];
  bool isLoading = true;
  bool isYesTapped = false;
  AuthController controller = Get.find<AuthController>();

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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Crack Awareness/Corrosion Crack/Beam',
          style: FontConstant.styleBold(
            fontSize: screenWidth * 0.035,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.465,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.005),
                          child: Text(
                            controller.subCategories.first.question,
                            style: FontConstant.styleBold(
                              fontSize: screenWidth * 0.045,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _buildImageGrid(context),
                      ],
                    ),
                  ),
                  _buildYesNoButtons(context),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomBanner(screenHeight),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.images.length > 1 ? 2 : 1,
            crossAxisSpacing: screenWidth * 0.03,
            mainAxisSpacing: screenWidth * 0.03,
            childAspectRatio:
                _calculateChildAspectRatio(widget.images.length, screenWidth),
          ),
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return _buildImageTile(widget.images[index], screenWidth);
          },
        ),
      ),
    );
  }

  double _calculateChildAspectRatio(int itemCount, double screenWidth) {
    if (itemCount == 0) return 1.0;
    if (itemCount == 1) {
      return screenWidth / (screenWidth * 0.75);
    }
    if (itemCount == 2) {
      return (screenWidth / 2) / (screenWidth * 0.5);
    }
    return 2.25 / 2;
  }

  Widget _buildImageTile(String imageUrl, double screenWidth) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, imageUrl),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
          image: DecorationImage(
            image: NetworkImage('https://aci.aks.5g.in/$imageUrl'),
            fit: BoxFit.cover,
            onError: (error, stackTrace) => Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: screenWidth * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: SizedBox(
              width: double.infinity,
              height: 500,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'https://aci.aks.5g.in/$imageUrl',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.cancel, color: Colors.black, size: 30),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildYesNoButtons(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isYesTapped = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isYesTapped)
                          const Icon(Icons.check_circle,
                              color: AppColors.primaryColor),
                        Text(
                          'Yes',
                          style: FontConstant.styleBold(
                            fontSize: screenWidth * 0.05,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isYesTapped = false;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FormPage(),
                      ),
                    );
                    //  Get.toNamed('/dash');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: FontConstant.styleBold(
                          fontSize: screenWidth * 0.05,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (isYesTapped) ...[
            Text(
              'Do you want to know more?',
              style: FontConstant.styleSemiBold(
                fontSize: 16,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CorrosionScreen(
                      categoryId: widget.categoryId,
                      subcategoryId: widget.subcategoryId,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                width: screenWidth * 0.35,
                child: Center(
                  child: Text(
                    'Yes',
                    style: FontConstant.styleBold(
                      fontSize: screenWidth * 0.05,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomBanner(double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.16,
      decoration: BoxDecoration(
        image: banners.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(
                    'https://aci.aks.5g.in/${banners.last.imageUrl}'),
                fit: BoxFit.fill,
              )
            : null,
      ),
      child: banners.isEmpty
          ? const Center(
              child: Text(
                'No banners available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          : null,
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
