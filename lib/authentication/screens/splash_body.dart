import 'dart:async';

import 'package:flutter/material.dart';

import 'logIn_screen.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});
  static const routeName = '/';

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  void goToNextView() {
    Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    // Or go to landing page if you have a token?
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
    //loading time could be set here in duration using await?
    Timer(const Duration(seconds: 1), () {
      goToNextView();
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1E352F),
        body: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: FadeTransition(
                  opacity: fadingAnimation!,
                  child: Image.asset('assets/images/Logo.png'),
                ),
              ),
            ],
          ),
        ));
  }
}
