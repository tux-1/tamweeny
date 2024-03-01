import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters.dart';
import '../widgets/custom_scaffold.dart';
import 'categories/categories_screen.dart';
import 'home_screen.dart';
import 'locations/locations_screen.dart';
import 'profile/profile_screen.dart';

class NavigationView extends ConsumerStatefulWidget {
  static const routeName = '/navigation-screen';

  const NavigationView({super.key});

  @override
  ConsumerState<NavigationView> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController scrollController;
  int? previousIndex;
  bool _isVisible = true;
  bool canPop = false;

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
    ref.read(filtersProvider).tabController = _tabController;
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.removeListener(_listen);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (ref.read(filtersProvider).chosenCategory != null &&
            _tabController.index == 2) {
          setState(() {
            ref.read(filtersProvider).clearCategory();
          });
          return;
        }

        if (previousIndex == null) {
          _tabController.animateTo(3);
        } else if (previousIndex != null) {
          _tabController.animateTo(previousIndex!);
          previousIndex = null;
        }

        if (_tabController.index == 3) {
          setState(() {
            canPop = true;
          });
        }
      },
      child: CustomScaffold(
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
              onTap: (newIndex) {
                previousIndex = _tabController.previousIndex;
                if (newIndex != 3) {
                  setState(() {
                    canPop = false;
                  });
                }
              },
              tabs: const [
                // Profile Screen
                Tab(icon: Icon(Icons.person, size: 27)),

                // Locations screen
                Tab(icon: Icon(Icons.location_on, size: 27)),

                // Categories screen
                Tab(icon: Icon(Icons.shopping_bag_rounded, size: 27)),

                // HomePage
                Tab(icon: Icon(Icons.home, size: 27)),
              ]),
        ),
        body: SafeArea(
          child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ProfileScreen(),
                const LocationsScreen(),
                CategoriesScreen(scrollController: scrollController),
                HomeScreen(scrollController: scrollController),
              ]),
        ),
      ),
    );
  }
}
