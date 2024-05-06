import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamweeny/features/driver/driver_locations/driver_locations_page.dart';
import 'package:tamweeny/features/driver/driver_profile/driver_profile_screen.dart';
import 'package:tamweeny/features/driver/home/driver_home_page.dart';

import '../../providers/pending_orders.dart';
import '../user/profile/providers/account_info.dart';

class DriverLandingView extends ConsumerStatefulWidget {
  const DriverLandingView({super.key});

  static const routeName = '/driver-landing';

  @override
  ConsumerState<DriverLandingView> createState() => _DriverLandingViewState();
}

class _DriverLandingViewState extends ConsumerState<DriverLandingView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 2, vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(pendingOrdersProvider);
    ref.watch(accountInfoProvider);
    final tabDecoratedBox = const DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF70B5FF),
            blurRadius: 15,
            offset: Offset(0, -15),
            spreadRadius: -8,
          ),
        ],
      ),
    ).animate().fadeIn(curve: Curves.easeIn);
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorColor: const Color(0xff61BC84),
        labelColor: const Color(0xff61BC84), //Selected icon color
        unselectedLabelColor: Colors.white,

        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        onTap: (value) {
          setState(() {});
        },
        tabs: [
          // Profile Screen
          Tab(
            icon: const Icon(Ionicons.person_outline),
            iconMargin: EdgeInsets.zero,
            height: 55,
            child: _tabController.index == 0 ? tabDecoratedBox : null,
          ),

          // Locations screen
          Tab(
            icon: const Icon(Ionicons.location_outline, size: 27),
            iconMargin: EdgeInsets.zero,
            height: 55,
            child: _tabController.index == 1 ? tabDecoratedBox : null,
          ),

          // HomePage
          Tab(
            icon: const Icon(Ionicons.home_outline, size: 27),
            iconMargin: EdgeInsets.zero,
            height: 55,
            child: _tabController.index == 2 ? tabDecoratedBox : null,
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DriverProfilePage(),
              DriverLocationsPage(),
              DriverHomePage(),
            ]),
      ),
    );
  }
}
