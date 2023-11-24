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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 50.0 : 0,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        // AutomaticNotchedShape(
        //   RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(
        //     Radius.circular(25),
        //   )),
        //   StadiumBorder(),
        // ),
        notchMargin: 7.0,
        color: Colors.white,

        child: Row(
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
                  Navigator.of(context)
                      .pushReplacementNamed(ProfileScreen.routeName);
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
                  Navigator.of(context)
                      .pushReplacementNamed(LandingPage.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
