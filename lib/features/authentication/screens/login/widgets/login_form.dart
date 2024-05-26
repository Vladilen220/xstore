import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/features/authentication/controllers/login/login_controller.dart';
import 'package:xstore/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:xstore/utils/validators/validation.dart';


import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///Password
            Obx(
                  () => TextFormField(
                validator: (value) => TValidator.validateEmptyText('Password',value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value ,
                      icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye, color: TColors.darkGrey,)),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember
                Row(
                  children: [
                    Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                ///Forget password
                TextButton(
                    onPressed: () => Get.to( () => const ForgetPassword()),
                    child: const Text(TTexts.forgetPassword))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(()=> const SignupScreen()),
                    child: const Text(TTexts.createAccount))),
            // const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}