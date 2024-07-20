import 'package:aci_app/utils/images.dart';
import 'package:aci_app/views/screens/dashboard/dashboard_screen.dart';
import 'package:aci_app/views/screens/faq/faq_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../constants/font_constant.dart';
import '../../../utils/color.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PageController controller = PageController(initialPage: 4);
  var selected = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          Center(
            child: Text('chat'),
          ),
          Center(
            child: Text('user'),
          ),
          // FaqPage(),
          FaqPage(),
          DashboardScreen(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        notchStyle: NotchStyle.circle,
        backgroundColor: AppColors.bottomBar,
        option: AnimatedBarOptions(
          iconSize: 30,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.Default,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.info_outline),
            title: Text(
              'Info',
              style: FontConstant.styleSemiBold(
                  fontSize: 12, color: AppColors.primaryColor),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(CupertinoIcons.chat_bubble_text),
            title: Text(
              'Chat',
              style: FontConstant.styleSemiBold(
                  fontSize: 12, color: AppColors.primaryColor),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            title: Text(
              'Faq',
              style: FontConstant.styleSemiBold(
                  fontSize: 12, color: AppColors.primaryColor),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.share),
            title: Text(
              'Share',
              style: FontConstant.styleSemiBold(
                  fontSize: 12, color: AppColors.primaryColor),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        ],
        fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(
            () {
              selected = index;
              controller.jumpToPage(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(
            () {
              controller.jumpToPage(4);
            },
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(
          Images.home,
          height: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
