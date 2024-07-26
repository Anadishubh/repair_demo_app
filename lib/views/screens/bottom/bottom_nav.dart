import 'package:aci_app/utils/color.dart';
import 'package:aci_app/views/screens/dashboard/dashboard_screen.dart';
import 'package:aci_app/views/screens/faq/faq_page.dart';
import 'package:aci_app/views/screens/faq/info_page.dart';
import 'package:aci_app/views/screens/share/chat_page.dart';
import 'package:aci_app/views/screens/share/share_page.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 2;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (index) => GlobalKey<NavigatorState>(),
  );

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _selectedIndex != 0,
            child: _buildNavigator(0, const InfoPage()),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: _buildNavigator(1, const ChatPage()),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: _buildNavigator(2, const DashboardScreen()),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: _buildNavigator(3, const FaqPage()),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: _buildNavigator(4, const SharePage()),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Faq',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
