import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:xstore/data/repositories/user/user_repository.dart';
import 'package:xstore/features/personalization/controllers/user_controller.dart';
import 'package:xstore/features/personalization/screens/profile/profile.dart';
import 'package:xstore/features/personalization/screens/settings/settings.dart';
import 'package:xstore/navigation_menu.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/popups/full_screen_loader.dart';
import 'package:xstore/utils/popups/loaders.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/http/network_manager.dart';

class UpdateEmailController extends GetxController{
  static UpdateEmailController get instance => Get.find();

  final email = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateEmailFormKey = GlobalKey<FormState>();

  /// init user data when Home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async{
    email.text = userController.user.value.email;
  }

  Future<void> updateEmail() async {
    try {

      String emailX = email.text.trim();
      print('OLD USER NAME $emailX and the new one is ${userController.user.value.email}');
      if(emailX == userController.user.value.email)  {
        TLoaders.errorSnackBar(title: 'Are you trying to use the same Email?!');
      } else {
        Get.defaultDialog(
          contentPadding: const EdgeInsets.all(TSizes.md),
          title: 'Email Change',
          middleText:
          'Are you sure you want to change your email ? This action is not reversible if you logged out and forgot the Email. ',
          confirm: ElevatedButton(
              onPressed: () async {
                // Start Loading
                TFullScreenLoader.openLoadingDialog(
                    'We are updating your information...', TImages.docerAnimation);

                // Check Internet Connectivity
                final isConnected = await NetworkManager.instance.isConnected();
                if (!isConnected) {
                  TFullScreenLoader.stopLoading();
                  return;
                }

                // Form Validation
                if (!updateEmailFormKey.currentState!.validate()) {
                  TFullScreenLoader.stopLoading();
                  return;
                }

                // Update user's first & last name in the Firebase Firestore
                Map<String, dynamic> name = {'Email': email.text.trim()};
                await userRepository.updateSingleField(name);

                // Update the Rx
                userController.user.value.email = email.text.trim();

                // Remove Loader
                TFullScreenLoader.stopLoading();

                // Show Success Message
                TLoaders.successSnackBar(title: 'Congratulations',
                    message: 'Your Email has been updated redirecting to Profile');

                // Move to Navigation-> Settings  Screen.
                Get.off(() => const NavigationMenu());
                update();

              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
              child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Change Email'))
          ),
          cancel: OutlinedButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(Get.overlayContext!).pop()
          ),
        );

      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}