import 'package:cetici_driver/common/color_extension.dart';
import 'package:cetici_driver/common_widget/round_button.dart';
import 'package:cetici_driver/view/login/mobile_number_view.dart';
import 'package:cetici_driver/view/login/onboarding_items.dart';
import 'package:cetici_driver/view/login/testOtp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: TColor.bg,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Skip Button
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text("Passer")),

                  //Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: TColor.primary),
                  ),

                  //Next Button
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      child: const Text("Suivant")),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image,
                      height: MediaQuery.of(context).size.height * 0.4),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center),
                ],
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return RoundButton(
      title: "Commencer",
      onPressed: () async {
        final pres = await SharedPreferences.getInstance();
        pres.setBool("onboarding", true);
        if (!mounted) return;
        context.push(
            //const MobileNumberView()
            const PhoneOTPVerification());
      },
    );
  }
}
