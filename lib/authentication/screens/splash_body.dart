import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/navigation_screen.dart';
import '../provider/auth.dart';
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

  void goToNextView() async {
    final auth = Provider.of<Auth>(context, listen: false);
    final navigator = Navigator.of(context);
    await auth.tryAutoLogin();
    if (auth.isAuth) {
      navigator.pushReplacementNamed(NavigationScreen.routeName);
    } else {
      navigator.pushReplacementNamed(LogInScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    //This function runs goToNextView() after initState is done initializing?
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goToNextView();
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1E352F),
        body: Padding(
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
