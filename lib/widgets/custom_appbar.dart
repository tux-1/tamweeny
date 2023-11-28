import 'package:flutter/material.dart';

import '../screens/landing-page.dart';
import '../screens/profile-screen.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            IconButton(
              iconSize: 30,
              tooltip: 'Profile',
              icon: ModalRoute.of(context)?.settings.name ==
                      ProfileScreen.routeName
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_outline),
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    ProfileScreen.routeName) {
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
              icon: const Icon(Icons.location_on_outlined),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30,
              tooltip: 'Shop',
              icon:
                  ModalRoute.of(context)?.settings.name == LandingPage.routeName
                      ? const Icon(Icons.shopping_cart)
                      : const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    LandingPage.routeName) {
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
