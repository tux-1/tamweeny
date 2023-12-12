import 'package:flutter/material.dart';

import '../helpers/lang.dart';
import '../screens/landing_page.dart';
import '../screens/locations_screen.dart';
import '../screens/profile_screen.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    required this.isVisible,
    super.key,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)?.settings.name;
    void slideInPage(
        {required String routeName,
        required Widget page,
        required Offset beginOffset}) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return page;
          },
          settings: RouteSettings(name: routeName),
          transitionDuration: const Duration(milliseconds: 150),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: Tween<Offset>(begin: beginOffset, end: Offset.zero)
                    .animate(animation),
                child: child);
            // return FadeTransition(opacity: animation, child: child,);
          },
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 50 : 0,
      child: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        shape: const CircularNotchedRectangle(),
        notchMargin: 7.0,
        color: Colors.white,
        child: Wrap(
          textDirection: Language.isArabic() ? null : TextDirection.rtl,
          alignment:
              Language.isArabic() ? WrapAlignment.start : WrapAlignment.end,
          children: <Widget>[
            IconButton(
              iconSize: 30,
              tooltip: 'Profile',
              icon: currentRouteName == ProfileScreen.routeName
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_outline),
              onPressed: () {
                if (currentRouteName != ProfileScreen.routeName) {
                  slideInPage(
                    routeName: ProfileScreen.routeName,
                    page: ProfileScreen(),
                    beginOffset: const Offset(1, 0),
                  );
                }
              },
            ),
            IconButton(
              iconSize: 30,
              tooltip: 'Locations',
              icon: currentRouteName == LocationsScreen.routeName
                  ? const Icon(Icons.location_on)
                  : const Icon(Icons.location_on_outlined),
              onPressed: () {
                if (currentRouteName != LocationsScreen.routeName) {
                  slideInPage(
                    routeName: LocationsScreen.routeName,
                    page: LocationsScreen(),
                    beginOffset: currentRouteName == LandingPage.routeName
                        ? const Offset(1, 0)
                        : const Offset(-1, 0),
                  );
                }
              },
            ),
            IconButton(
              iconSize: 30,
              tooltip: 'Shop',
              icon: currentRouteName == LandingPage.routeName
                  ? const Icon(Icons.shopping_cart)
                  : const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                if (currentRouteName != LandingPage.routeName) {
                  slideInPage(
                    routeName: LandingPage.routeName,
                    page: LandingPage(),
                    beginOffset: const Offset(-1, 0),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
