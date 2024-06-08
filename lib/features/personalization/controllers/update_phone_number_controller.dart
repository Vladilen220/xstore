import 'package:flutter/cupertino.dart';
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

import '../../../utils/http/network_manager.dart';

class UpdatePhoneNumberController extends GetxController{
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNo = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumFormKey = GlobalKey<FormState>();

  /// init user data when Home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async{
    phoneNo.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhoneNo() async {
    try {

      String phoneNumberX = phoneNo.text.trim();
      print('OLD USER NAME $phoneNumberX and the new one is ${userController.user.value.phoneNumber}');
      if(phoneNumberX == userController.user.value.phoneNumber)  {
        TLoaders.errorSnackBar(title: 'Are you trying to use the same Phone Number?!');
      } else {
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
        if (!updatePhoneNumFormKey.currentState!.validate()) {
          TFullScreenLoader.stopLoading();
          return;
        }

        // Update user's first & last name in the Firebase Firestore
        Map<String, dynamic> name = {'PhoneNumber': phoneNo.text.trim()};
        await userRepository.updateSingleField(name);

        // Update the Rx
        userController.user.value.phoneNumber = phoneNo.text.trim();

        // Remove Loader
        TFullScreenLoader.stopLoading();

        // Show Success Message
        TLoaders.successSnackBar(title: 'Congratulations',
            message: 'Your Name has been updated redirecting to Profile');

        // Move to Navigation-> Settings  Screen.
        Get.off(() => const NavigationMenu());
        update();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}