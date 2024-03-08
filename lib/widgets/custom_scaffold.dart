import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String backgroundImageAsset;
  final AppBar? appBar;
  final bool resizeToAvoidBottomInset;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final Drawer? drawer;
  final Widget? bottomNavigationBar;
  final bool fadeBackground;
  final Color? backgroundColor;
  final bool showLogo;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.backgroundColor,
    this.backgroundImageAsset = 'assets/images/Logo.png',
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.primary = true,
    this.drawer,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.bottomNavigationBar,
    this.fadeBackground = true,
    this.showLogo = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xff1E352F),
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      body: Stack(
        children: [
          if (showLogo)
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: deviceSize.height / 10,
                left: 20,
                right: 20,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (fadeBackground)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: const SizedBox(),
            ),
          body,
        ],
      ),
    );
  }
}
