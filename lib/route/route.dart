import 'package:aci_app/views/screens/arrangevisit/arrange_visit_page.dart';
import 'package:aci_app/views/screens/bottom/bottom_nav.dart';
import 'package:aci_app/views/screens/corrosion/corrosion_screen.dart';
import 'package:aci_app/views/screens/repair/repair_methado.dart';
import 'package:aci_app/views/screens/signup/signup_screen.dart';
import 'package:get/get.dart';

import '../views/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String signUp = '/signup';
  static const String bottomNav = '/dash';
  static const String beam = '/beam';
  static const String corrosion = '/corrosion';
  static const String repair = '/repair';
  static const String visit = '/visit';
  static const String faq = '/faq';
  static const String deshboard2 = '/deshboard2';

  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: signUp,
      page: () => const SignupScreen(),
      transition: Transition.fadeIn,
      // transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: bottomNav,
      page: () => const BottomNav(),
      transition: Transition.fadeIn,
      // transitionDuration: const Duration(milliseconds: 400),
    ),
    // GetPage(
    //   name: beam,
    //   page: () => const BeamColumn(selectionType: ''),
    //   transition: Transition.fadeIn,
    //   // transitionDuration: const Duration(milliseconds: 400),
    // ),
    GetPage(
      name: corrosion,
      page: () => const CorrosionScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: repair,
      page: () => const RepairMethodologyPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: visit,
      page: () => const ArrangeVisitPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    // GetPage(
    //   name: faq,
    //   page: () => const FaqPage(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: deshboard2,
    //   page: () =>  Deshbaord2(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
  ];
}
