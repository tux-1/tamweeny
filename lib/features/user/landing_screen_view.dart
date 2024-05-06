import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../providers/filters.dart';
import 'categories/categories_screen.dart';
import 'home_screen.dart';
import 'locations/locations_screen.dart';
import 'profile/profile_screen.dart';

class LandingScreenView extends ConsumerStatefulWidget {
  static const routeName = '/navigation-screen';

  const LandingScreenView({super.key});

  @override
  ConsumerState<LandingScreenView> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<LandingScreenView>
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
    final tabControllerProvider = ref.watch(filtersProvider).tabController;
    final tabDecoratedBox = const DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF70B5FF),
            blurRadius: 15,
            offset: Offset(0, -15),
            spreadRadius: -8,
          )
        ],
      ),
    ).animate().fadeIn(curve: Curves.easeIn);
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
          setState(() {});
        } else if (previousIndex != null) {
          _tabController.animateTo(previousIndex!);
          previousIndex = null;
          setState(() {});
        }

        if (_tabController.index == 3) {
          setState(() {
            canPop = true;
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff1E1E1E),
        extendBody: true,
        bottomNavigationBar: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: _isVisible ? null : 0,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              border: Border(top: BorderSide(color: Colors.white30)),
              color: Color(0xff1E1E1E),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor:
                  _isVisible ? const Color(0xff61BC84) : Colors.transparent,
              labelColor: const Color(0xff61BC84), //Selected icon color
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              onTap: (newIndex) {
                previousIndex = _tabController.previousIndex;
                if (newIndex != 3) {
                  setState(() {
                    canPop = false;
                  });
                } else {
                  setState(() {});
                }
              },
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                // Profile Screen
                Tab(
                  icon: const Icon(Ionicons.person_outline),
                  iconMargin: EdgeInsets.zero,
                  height: 55,
                  child: tabControllerProvider?.index == 0
                      ? tabDecoratedBox
                      : null,
                ),

                // Locations screen
                Tab(
                  icon: const Icon(Ionicons.location_outline, size: 27),
                  iconMargin: EdgeInsets.zero,
                  height: 55,
                  child: tabControllerProvider?.index == 1
                      ? tabDecoratedBox
                      : null,
                ),

                // Categories screen
                Tab(
                  icon: const Icon(Ionicons.fast_food_outline, size: 27),
                  iconMargin: EdgeInsets.zero,
                  height: 55,
                  child: tabControllerProvider?.index == 2
                      ? tabDecoratedBox
                      : null,
                ),

                // HomePage
                Tab(
                  icon: const Icon(Ionicons.home_outline, size: 27),
                  iconMargin: EdgeInsets.zero,
                  height: 55,
                  child: tabControllerProvider?.index == 3
                      ? tabDecoratedBox
                      : null,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          bottom: false,
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
