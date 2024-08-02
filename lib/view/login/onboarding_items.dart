import 'onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Quelle est votre destination ?",
        descriptions:
            "Dites-nous où vous voulez aller, et planifions votre trajet avec nous en toute simplicité.",
        image: "assets/img/find_on_map.png"),
    OnboardingInfo(
        title: "Quelle lieux recherchez-vous ? ",
        descriptions:
            "Laissez-nous vous aider à localiser des entreprises  ou des endroits favoris facilement.",
        image: "assets/img/find_office.png"),
    OnboardingInfo(
        title: "Laissez-nous vous-y conduire",
        descriptions:
            "Installez-vous confortablement. Nous vous conduirons à votre destination en toute sécurité.",
        image: "assets/img/get_driver.png"),
  ];
}
