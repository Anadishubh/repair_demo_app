// ignore_for_file: await_only_futures
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/font_constant.dart';
import '../../../utils/color.dart';

class BeamColumn extends StatefulWidget {
  final List<String> images;

  const BeamColumn({super.key, required this.images});

  @override
  State<BeamColumn> createState() => _BeamColumnState();
}

class _BeamColumnState extends State<BeamColumn> {
  bool isLoading = true;

  bool isYesTapped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        title: Text(
          'Crack Awareness/Corrosion Crack/Beam',
          style: FontConstant.styleBold(fontSize: 15, color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.toNamed('/dash');
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.64,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                    child: Text(
                      'Are you facing anything like these ?',
                      style: FontConstant.styleBold(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 0.5, // Border width
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://aci.aks.5g.in/${widget.images[index]}'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            _buildYesNoButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildYesNoButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isYesTapped = true;
                });
                Get.toNamed('/corrosion');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isYesTapped)
                      const Icon(Icons.check_circle,
                          color: AppColors.primaryColor),
                    const SizedBox(width: 10),
                    Text(
                      'Yes',
                      style: FontConstant.styleBold(
                          fontSize: 18, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isYesTapped = false;
                });
                Get.toNamed('/dash');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'No',
                    style: FontConstant.styleBold(
                        fontSize: 18, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
