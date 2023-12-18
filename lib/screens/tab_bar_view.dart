import 'package:flutter/material.dart';
import 'package:tamweeny/screens/landing_page.dart';
import 'package:tamweeny/screens/locations_screen.dart';
import 'package:tamweeny/screens/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = '/navigation-screen';

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, vsync: this, length: 4);
    _tabController?.addListener(() {
      setState(() {
        _currentIndex = _tabController!.index;
        print(_currentIndex);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,
            labelColor: Color.fromARGB(255, 30, 53, 47), //Selected icon color
            unselectedLabelColor: Color.fromARGB(255, 30, 53, 47),
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(
                  _currentIndex == 0
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  size: 27,
                ),
              ),
              Tab(
                icon: Icon(
                  _currentIndex == 1 ? Icons.home : Icons.home_outlined,
                  size: 27,
                ),
              ),
              Tab(
                icon: Icon(
                  _currentIndex == 2
                      ? Icons.location_on
                      : Icons.location_on_outlined,
                  size: 27,
                ),
              ),
              Tab(
                icon: Icon(
                  _currentIndex == 3 ? Icons.person : Icons.person_outline,
                  size: 27,
                ),
              ),
            ]),
      ),
      body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(),
            LandingPage(),
            LocationsScreen(),
            ProfileScreen(),
          ]),
    );
  }
}
