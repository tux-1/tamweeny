import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tamweeny/screens/home_page.dart';
import 'package:tamweeny/screens/locations_screen.dart';
import 'package:tamweeny/screens/profile_screen.dart';

import '../widgets/custom_scaffold.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = '/navigation-screen';

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController scrollController;

  bool _isVisible = true;

  void _listen() {
    final ScrollDirection direction =
        scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _show();
    } else if (direction == ScrollDirection.reverse) {
      _hide();
    }
  }

  void _show() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 3, vsync: this, length: 4);
    scrollController = ScrollController();
    scrollController.addListener(_listen);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    scrollController.removeListener(_listen);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBody: true,
      bottomNavigationBar: AnimatedContainer(
        width: double.infinity,
        height: _isVisible ? 50 : 0,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: const Color(0xffDEA568),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: _isVisible ? Colors.black : Colors.transparent,
            labelColor: Colors.black, //Selected icon color
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.person, size: 27)),
              // Profile Screen

              // Locations screen
              Tab(icon: Icon(Icons.location_on, size: 27)),

              // Categories screen
              Tab(icon: Icon(Icons.shopping_bag_rounded, size: 27)),

              // HomePage
              Tab(icon: Icon(Icons.home, size: 27)),
            ]),
      ),
      body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ProfileScreen(),
            const LocationsScreen(),
            Container(),
            HomePage(scrollController: scrollController),
          ]),
    );
  }
}
