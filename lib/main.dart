import 'package:aci_app/route/route.dart';
import 'package:aci_app/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aci_app/utils/get_di.dart' as di;

void main() async {
  runApp(const MyApp());
  await di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const SplashScreen(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: SubCategoryPage(),
//     );
//   }
// }

// class SubCategory {
//   final int id;
//   final int categoryId;
//   final String name;
//   final List<String> images;
//   final List<String> beamImages;
//   final String faq;
//   final bool columnAndBeam;

//   SubCategory({
//     required this.id,
//     required this.categoryId,
//     required this.name,
//     required this.images,
//     required this.beamImages,
//     required this.faq,
//     required this.columnAndBeam,
//   });

//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['id'],
//       categoryId: json['category_id'],
//       name: json['name'],
//       images: [
//         json['image_1'],
//         json['image_2'],
//         json['image_3'],
//         json['image_4']
//       ].whereType<String>().toList(),
//       beamImages: [
//         json['image_beam_1'],
//         json['image_beam_2'],
//         json['image_beam_3'],
//         json['image_beam_4']
//       ].whereType<String>().toList(),
//       faq: json['faq'],
//       columnAndBeam: json['column_and_beam'] == 'Yes',
//     );
//   }
// }

// class SubCategoryController extends GetxController {
//   var subCategories = <SubCategory>[].obs;
//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     fetchSubCategories();
//     super.onInit();
//   }

//   void fetchSubCategories() async {
//     const url = 'https://aci.aks.5g.in/api/sub-category';
//     const token = '1063|gex9Wott6yd09zhyJi1Bjd5iMG4BRPRM9pA41jyz21aacdc9';
//     const headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final body = jsonEncode({"category_id": 1});

//     try {
//       isLoading(true);
//       final response = await http.post(Uri.parse(url), headers: headers, body: body);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['message'] == 'Success') {
//           subCategories.value = (data['data']['category'] as List)
//               .map((item) => SubCategory.fromJson(item))
//               .toList();
//         }
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   void showBottomSheet(SubCategory subCategory) {
//     Get.bottomSheet(
//       Column(
//         children: [
//           ListTile(
//             title: Text('Column Images'),
//             onTap: () {
              // Get.back();
              // Get.to(() => ImagePage(images: subCategory.images));
//             },
//           ),
//           ListTile(
//             title: Text('Beam Images'),
//             onTap: () {
              // Get.back();
              // Get.to(() => ImagePage(images: subCategory.beamImages));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SubCategoryPage extends StatelessWidget {
//   final SubCategoryController controller = Get.put(SubCategoryController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('SubCategories')),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.builder(
//           itemCount: controller.subCategories.length,
//           itemBuilder: (context, index) {
//             final subCategory = controller.subCategories[index];
//             return ListTile(
//               title: Text(subCategory.name),
//               onTap: () {
                // if (subCategory.columnAndBeam) {
                //   controller.showBottomSheet(subCategory);
                // } else {
                //   Get.to(() => ImagePage(images: subCategory.images));
                // }
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// class ImagePage extends StatelessWidget {
  // final List<String> images;

  // ImagePage({required this.images});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Images')),
      // body: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //   ),
      //   itemCount: images.length,
      //   itemBuilder: (context, index) {
      //     return Image.network('https://aci.aks.5g.in/${images[index]}');
      //   },
      // ),
//     );
//   }
// }
