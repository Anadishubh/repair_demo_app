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
      home: const SplashScreen(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Splash Screen', style: TextStyle(fontSize: 24)),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   HomeScreenState createState() => HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  // int _selectedIndex = 2;

  // final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
  //   5,
  //   (index) => GlobalKey<NavigatorState>(),
  // );

  // void _onItemTapped(int index) {
  //   if (_selectedIndex == index) {
  //     _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
  //   } else {
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  //   }
  // }

  // Widget _buildNavigator(int index, Widget child) {
  //   return Navigator(
  //     key: _navigatorKeys[index],
  //     onGenerateRoute: (routeSettings) {
  //       return MaterialPageRoute(
  //         builder: (context) => child,
  //       );
  //     },
  //   );
  // }

//   @override
//   Widget build(BuildContext context) {
//     return 
// Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Offstage(
//             offstage: _selectedIndex != 0,
//             child:
//                 _buildNavigator(0, TabPage(title: 'Search', color: Colors.red)),
//           ),
//           Offstage(
//             offstage: _selectedIndex != 1,
//             child:
//                 _buildNavigator(1, TabPage(title: 'Chat', color: Colors.green)),
//           ),
//           Offstage(
//             offstage: _selectedIndex != 2,
//             child:
//                 _buildNavigator(2, TabPage(title: 'Home', color: Colors.blue)),
//           ),
//           Offstage(
//             offstage: _selectedIndex != 3,
//             child: _buildNavigator(
//                 3, TabPage(title: 'Notifications', color: Colors.yellow)),
//           ),
//           Offstage(
//             offstage: _selectedIndex != 4,
//             child: _buildNavigator(
//                 4, TabPage(title: 'Settings', color: Colors.purple)),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class TabPage extends StatelessWidget {
//   final String title;
//   final Color color;

//   const TabPage({required this.title, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               '$title Page',
//               style: TextStyle(fontSize: 24),
//             ),
//             ElevatedButton(
//               onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //       builder: (context) => SubPage(title: '$title Subpage')),
                // );
//               },
//               child: Text('Go to Subpage'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           SubPahbnjmge(title: '$title Subpage')),
//                 );
//               },
//               child: Text('Go to dtfgyhukijlkom,l'),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: color,
//     );
//   }
// }

// class SubPage extends StatelessWidget {
//   final String title;

//   const SubPage({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text(
//           '$title Content',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class SubPahbnjmge extends StatelessWidget {
//   final String title;

//   const SubPahbnjmge({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text(
//           '$title Contfghjent',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
