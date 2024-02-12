import 'package:flutter/material.dart';

import '../utils/lang.dart';
import '../screens/home_page.dart';
import '../screens/locations_screen.dart';
import '../screens/profile_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({
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
          transitionDuration: const Duration(milliseconds: 1200),
          reverseTransitionDuration: const Duration(milliseconds: 1200),
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

    return Theme(
      data: ThemeData(
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              iconSize: MaterialStatePropertyAll(32),
              iconColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 30, 53, 47))),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isVisible ? 55 : 0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            shape: const CircularNotchedRectangle(),
            notchMargin: 7.0,
            color: Color(0xffDEA568),
            child: Wrap(
              textDirection: Language.isArabic() ? null : TextDirection.rtl,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                NavIconButton(
                    routeName: ProfileScreen.routeName,
                    icon: const Icon(Icons.person),
                    selectedIcon: const Icon(Icons.person_outline),
                    onPressed: () {
                      if (currentRouteName != ProfileScreen.routeName) {
                        slideInPage(
                          routeName: ProfileScreen.routeName,
                          page: ProfileScreen(),
                          beginOffset: const Offset(1, 0),
                        );
                      }
                    }),
                NavIconButton(
                    routeName: LocationsScreen.routeName,
                    icon: const Icon(Icons.location_on),
                    selectedIcon: const Icon(Icons.location_on_outlined),
                    onPressed: () {
                      if (currentRouteName != LocationsScreen.routeName) {
                        slideInPage(
                          routeName: LocationsScreen.routeName,
                          page: const LocationsScreen(),
                          beginOffset: currentRouteName == HomePage.routeName
                              ? const Offset(1, 0)
                              : const Offset(-1, 0),
                        );
                      }
                    }),
                NavIconButton(
                    routeName: HomePage.routeName,
                    icon: const Icon(Icons.home),
                    selectedIcon: const Icon(Icons.home_outlined),
                    onPressed: () {
                      if (currentRouteName != HomePage.routeName) {
                        slideInPage(
                          routeName: HomePage.routeName,
                          page: HomePage(),
                          beginOffset: const Offset(-1, 0),
                        );
                      }
                    }),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavIconButton extends StatelessWidget {
  final String routeName;
  final Icon icon;
  final Icon selectedIcon;
  final Function()? onPressed;
  const NavIconButton({
    super.key,
    required this.routeName,
    required this.icon,
    required this.selectedIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)?.settings.name;
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: currentRouteName == routeName
                  ? const BorderSide(color: Color.fromARGB(255, 25, 44, 39))
                  : BorderSide.none)),
      child: IconButton(
        icon: currentRouteName == routeName ? icon : selectedIcon,
        onPressed: onPressed,
      ),
    );
  }
}
