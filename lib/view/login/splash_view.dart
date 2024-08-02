import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cetici_driver/common/color_extension.dart';
import 'package:cetici_driver/common/globs.dart';
import 'package:cetici_driver/common/service_call.dart';
import 'package:cetici_driver/view/home/home_view.dart';
import 'package:cetici_driver/view/login/onboarding_view.dart';
import 'package:cetici_driver/view/login/profile_image_view.dart';
import 'package:cetici_driver/view/user/user_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget nextScreen;
    if (Globs.udValueBool(Globs.userLogin)) {
      if (ServiceCall.userType == 2) {
        // Driver Login
        if (ServiceCall.userObj[KKey.status] == 1) {
          nextScreen = const HomeView();
        } else {
          nextScreen = const ProfileImageView();
        }
      } else {
        // User Login
        nextScreen = const UserHomeView();
      }
    } else {
      nextScreen = const OnboardingView();
    }

    return AnimatedSplashScreen(
      backgroundColor: TColor.bg,
      splash: 'assets/img/cetici.png',
      nextScreen: nextScreen,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
