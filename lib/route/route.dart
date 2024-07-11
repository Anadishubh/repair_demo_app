import 'package:aci_app/views/screens/bottom/bottom_nav.dart';
import 'package:aci_app/views/screens/corrosion/corrosion_screen.dart';
import 'package:aci_app/views/screens/crack_beam/beam_column.dart';
import 'package:aci_app/views/screens/signup/signup_screen.dart';
import 'package:get/get.dart';

import '../views/screens/splash/splash_screen.dart';


class AppRoutes {
  static const String splash = '/';
  static const String signUp = '/signup';
  static const String bottomNav = '/dash';
  static const String beam = '/beam';
  static const String corrosion = '/corrosion';
  // static const String profile2 = '/profile2';
  // static const String education = '/education';
  // static const String family = '/family';
  // static const String search = '/search';
  // static const String profileDtls = '/profiledtls';
  // static const String occupation = '/occupation';
  // static const String photo = '/photo';
  // static const String profileComplete = '/pc';
  // static const String dashboard = '/dashboard';
  // static const String searchResult = '/searchResult';
  // static const String contact = '/contact';
  // static const String professional = '/prof';
  // static const String devotion = '/devotion';
  // static const String location = '/location';
  // static const String spirit = '/spirit';
  // static const String horoscope = '/horo';


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
    GetPage(
      name: beam,
      page: () => const BeamColumn(),
      transition: Transition.fadeIn,
      // transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: corrosion,
      page: () => const CorrosionScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    // GetPage(
    //   name: profile2,
    //   page: () => const Profile2Page(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: education,
    //   page: () => const EducationPage(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: family,
    //   page: () => const FamilyPage(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: search,
    //   page: () => const SearchPage(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: profileDtls,
    //   page: () => const ProfileDetailsScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: occupation,
    //   page: () => const Occupation(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: photo,
    //   page: () => const PhotoUpload(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: profileComplete,
    //   page: () => const ProfileComplete(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: dashboard,
    //   page: () => const Dashboard(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: searchResult,
    //   page: () => const SearchResult(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: contact,
    //   page: () => const ContactPage(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: professional,
    //   page: () => const ProfessionalDetailsPage(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: devotion,
    //   page: () => const DevotionDetails(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: location,
    //   page: () => const Location(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: spirit,
    //   page: () => const SpiritualDetails(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: horoscope,
    //   page: () => const HoroscopeDetails(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
  ];
}
