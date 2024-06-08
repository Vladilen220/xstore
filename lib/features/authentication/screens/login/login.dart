import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/common/styles/spacing_styles.dart';
import 'package:xstore/features/authentication/screens/login/widgets/login_form.dart';
import 'package:xstore/features/authentication/screens/login/widgets/login_header.dart';
import 'package:xstore/utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/theme_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final dark = themeController.isDarkMode;
    //final dark = THelperFunctions.isDarkMode(context);


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                ///Logo Title & SubTitle
                TLoginHeader(dark: dark),

                ///Form
                const TLoginForm(),

                ///Divider
                 TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
                const SizedBox(height: TSizes.spaceBtwSections),

                ///Footer
                const TSocialButtons(),
              ],
            )),
      ),
    );
  }
}








