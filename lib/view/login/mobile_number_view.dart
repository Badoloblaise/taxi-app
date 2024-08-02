import 'package:cetici_driver/common/color_extension.dart';
import 'package:cetici_driver/common_widget/round_button.dart';
import 'package:cetici_driver/view/login/otp_view.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

class MobileNumberView extends StatefulWidget {
  const MobileNumberView({super.key});

  @override
  State<MobileNumberView> createState() => _MobileNumberViewState();
}

class _MobileNumberViewState extends State<MobileNumberView> {
  FlCountryCodePicker countryCodePicker = const FlCountryCodePicker();
  TextEditingController txtMobile = TextEditingController();
  late CountryCode countryCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    countryCode = countryCodePicker.countryCodes
        .firstWhere((element) => element.dialCode == "+226");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 25,
            height: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Entrer votre numéro de téléphone",
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 20,
                      child: countryCode.flagImage(),
                    ),
                    Text(
                      "  ${countryCode.dialCode}",
                      style: TextStyle(color: TColor.primaryText, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: txtMobile,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "07010701",
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "En continuant, Je confirme avoir lue & accepter les",
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Termes & conditions",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 12,
                  ),
                ),
                Text(
                  " et les ",
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Politiques de confidentialité",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            RoundButton(
              onPressed: () {
                context.push(OTPView(
                  number: txtMobile.text,
                  code: countryCode.dialCode,
                  isDriver: false,
                ));
              },
              title: "Inscription UTILISATEUR",
            ),
            const SizedBox(
              height: 15,
            ),
            RoundButton(
              onPressed: () {
                context.push(OTPView(
                    number: txtMobile.text, code: countryCode.dialCode));
              },
              title: "Inscription DRIVER",
            ),
          ],
        ),
      ),
    );
  }
}
